//
//  AssembleTeamViewController.m
//  TuCancha
//
//  Created by Ernesto Diaz on 10/23/14.
//  Copyright (c) 2014 Ernesto Diaz. All rights reserved.
//

#import "AssembleTeamViewController.h"


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface AssembleTeamViewController ()

@end

@implementation AssembleTeamViewController
@synthesize gamesCollection;
PFUser *parseCurrentUser;
PFQuery *retrieveTeams;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Set Side Menu button
    UIImage *barButtonImage = [UIImage imageNamed:@"Hamburguer-Menu.png"];
    barButtonImage = [barButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *menuBarButton = [[UIBarButtonItem alloc] initWithImage:barButtonImage style:UIBarButtonItemStylePlain target:self.revealViewController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem.width = 50.0;
    self.navigationItem.leftBarButtonItem = menuBarButton;
    
    //Customize Buttons
    //Create New Game Button
    _createGameButton.hidden=NO;
    _createGameButton.layer.cornerRadius=_createGameButton.frame.size.width/2;
    _createGameButton.clipsToBounds=NO;
    _createGameButton.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _createGameButton.layer.shadowOffset = CGSizeZero;
    _createGameButton.layer.shadowRadius = _createGameButton.frame.size.width/2;
    _createGameButton.layer.shadowOpacity = 0.4;
    _createGameButton.layer.masksToBounds=NO;
    _createGameButton.layer.shadowPath =[UIBezierPath bezierPathWithRect:_createGameButton.bounds].CGPath;
    //- Show Login Button
    _createNewGameButton.layer.cornerRadius=_createNewGameButton.frame.size.width*0.02;
    _createNewGameButton.clipsToBounds=NO;
    _createNewGameButton.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _createNewGameButton.layer.shadowOffset = CGSizeZero;
    _createNewGameButton.layer.shadowRadius = _createNewGameButton.frame.size.width*0.007;
    _createNewGameButton.layer.shadowOpacity = 0.75;
    _createNewGameButton.layer.masksToBounds=NO;
    _createNewGameButton.layer.shadowPath =[UIBezierPath bezierPathWithRect:_createNewGameButton.bounds].CGPath;
    //-CloseLoginButton
    _closeNewGameButton.layer.cornerRadius=_closeNewGameButton.frame.size.width*0.1;
    _closeNewGameButton.clipsToBounds=NO;
    _closeNewGameButton.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _closeNewGameButton.layer.shadowOffset = CGSizeZero;
    _closeNewGameButton.layer.shadowRadius = _closeNewGameButton.frame.size.width*0.1;
    _closeNewGameButton.layer.shadowOpacity = 0.75;
    _closeNewGameButton.layer.masksToBounds=NO;
    _closeNewGameButton.layer.shadowPath =[UIBezierPath bezierPathWithRect:_closeNewGameButton.bounds].CGPath;
    //Customize Views
    //Create New Game View
    _createNewGameView.hidden=YES;
    _createNewGameView.layer.cornerRadius=_createNewGameView.frame.size.width*0.02;
    //_fieldsLoginView.clipsToBounds=NO;
    _createNewGameView.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _createNewGameView.layer.shadowOffset = CGSizeZero;
    _createNewGameView.layer.shadowRadius = _createNewGameView.frame.size.width*0.007;
    _createNewGameView.layer.shadowOpacity = 0.75;
    //_fieldsLoginView.layer.masksToBounds=NO;
    _createNewGameView.layer.shadowPath =[UIBezierPath bezierPathWithRect:_createNewGameView.bounds].CGPath;

    city=@"Medellin";
    [self retrieveGamesFromParse];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.invitationTextField resignFirstResponder];
    [self.teamTextField resignFirstResponder];
    [self.fieldTextField resignFirstResponder];
    [self.playersTextField resignFirstResponder];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

-(void) retrieveGamesFromParse {

    //Query and Cache games
    PFQuery *retrieveGames = [PFQuery queryWithClassName:@"Games"];
    [retrieveGames whereKey:@"City" equalTo:city];
    [retrieveGames findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            gamesArray = [[NSArray alloc] initWithArray:objects];
        }
        [gamesCollection reloadData];
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    // Return the number of sections.
    if (gamesArray) {
        self.gamesCollection.backgroundView = nil;
        return 1;
    } else {
        
        // Display a message when the table is empty
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        messageLabel.text = @"No se encontraron juegos";
        messageLabel.textColor = UIColorFromRGB(0x1D4A00);
        messageLabel.numberOfLines = 1;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
        messageLabel.alpha = 0.4;
        [messageLabel sizeToFit];
        self.gamesCollection.backgroundView = messageLabel;
        return 0;
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return [gamesArray count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"GameCell";
    GamesCollectionViewCell *cell = (GamesCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    PFObject *tempObject = [gamesArray objectAtIndex:indexPath.row ];
    cell.field.text=[tempObject valueForKey:@"Game_Field"];
    cell.gameName.text=[tempObject valueForKey:@"Game_Name"];
    cell.football.text=[tempObject valueForKey:@"Game_Players"];
    

    // Configure the cell
    cell.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(0,0);
    cell.layer.shadowRadius = cell.frame.size.width*0.007;
    cell.layer.shadowOpacity = 0.75;
    cell.layer.masksToBounds=NO;
    cell.layer.shadowPath =[UIBezierPath bezierPathWithRect:cell.bounds].CGPath;
    
    //Availability
    //
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"PlayGameSegue"]) {
        PlayGameViewController *destViewController = segue.destinationViewController;
        NSArray *indexPaths = [self.gamesCollection indexPathsForSelectedItems];
        NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
        PFObject *tempObject = [gamesArray objectAtIndex:indexPath.row];
        destViewController.game=tempObject;
    }
}


- (IBAction)createNewGameAction:(id)sender {
    [self checkFieldsComplete];
    
}

- (IBAction)closeNewGameAction:(id)sender {
    _createNewGameView.hidden=YES;
    _createGameButton.hidden=NO;
}

- (IBAction)createGameAction:(id)sender {
    _createNewGameView.hidden=NO;
    _createGameButton.hidden=YES;
}

-(void)checkFieldsComplete{
    
    if ([_teamTextField.text isEqualToString:@""] || [_playersTextField.text isEqualToString:@""] || [_fieldTextField.text isEqualToString:@""] || [_invitationTextField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oopss" message:@"Recuerda llenar todos los datos" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else {
        [self postNewGame];
    }
}

-(void)postNewGame{
    PFUser *user=[PFUser currentUser];
    PFObject *newPostGame = [PFObject objectWithClassName:@"Games"];
    newPostGame[@"Game_Name"] = _teamTextField.text;
    newPostGame[@"Game_Field"] = _fieldTextField.text;
    newPostGame[@"Game_Players"] = _playersTextField.text;
    newPostGame[@"Invitation"] = _invitationTextField.text;
    newPostGame[@"City"] = city;
    newPostGame[@"Administrator"]=user.username;
    [newPostGame saveInBackground];
    
    UIAlertView *postedAlert =[[UIAlertView alloc]initWithTitle:@"TuCancha" message:@"Tu Partido ha sido creado" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [postedAlert show];
    [self retrieveGamesFromParse];
    _createNewGameView.hidden=YES;
}
@end
