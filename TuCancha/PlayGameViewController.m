//
//  PlayGameViewController.m
//  TuCancha
//
//  Created by Ernesto Diaz on 4/27/15.
//  Copyright (c) 2015 Ernesto Diaz. All rights reserved.
//

#import "PlayGameViewController.h"

@interface PlayGameViewController ()

@end

@implementation PlayGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Customize Buttons
    //Play Game Button
    _playGameButton.layer.cornerRadius=_playGameButton.frame.size.width*0.02;
    _playGameButton.clipsToBounds=NO;
    _playGameButton.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _playGameButton.layer.shadowOffset = CGSizeZero;
    _playGameButton.layer.shadowRadius = _playGameButton.frame.size.width*0.007;
    _playGameButton.layer.shadowOpacity = 0.75;
    _playGameButton.layer.masksToBounds=NO;
    _playGameButton.layer.shadowPath =[UIBezierPath bezierPathWithRect:_playGameButton.bounds].CGPath;
    
    //Delete Game Button
    _deleteGameButton.layer.cornerRadius=_deleteGameButton.frame.size.width*0.02;
    _deleteGameButton.clipsToBounds=NO;
    _deleteGameButton.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _deleteGameButton.layer.shadowOffset = CGSizeZero;
    _deleteGameButton.layer.shadowRadius = _deleteGameButton.frame.size.width*0.007;
    _deleteGameButton.layer.shadowOpacity = 0.75;
    _deleteGameButton.layer.masksToBounds=NO;
    _deleteGameButton.layer.shadowPath =[UIBezierPath bezierPathWithRect:_deleteGameButton.bounds].CGPath;
    
    //back to Tabbar Button
    _backGamesButton.layer.cornerRadius=_backGamesButton.frame.size.width*0.1;
    _backGamesButton.clipsToBounds=NO;
    _backGamesButton.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _backGamesButton.layer.shadowOffset = CGSizeZero;
    _backGamesButton.layer.shadowRadius = _backGamesButton.frame.size.width*0.1;
    _backGamesButton.layer.shadowOpacity = 0.75;
    _backGamesButton.layer.masksToBounds=NO;
    _backGamesButton.layer.shadowPath =[UIBezierPath bezierPathWithRect:_backGamesButton.bounds].CGPath;
    // Do any additional setup after loading the view.
    [self fetchInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetchInfo{
    
    PFUser *user=[PFUser currentUser];
    NSString *admin= [_game objectForKey:@"Administrator"];
    if ([admin isEqualToString:user.username]){
        _playGameButton.hidden=YES;
        _deleteGameButton.hidden=NO;
    }else{
        _deleteGameButton.hidden=YES;
    }
    _playFieldLabel.text=[_game objectForKey:@"Game_Field"];
    _gameNameLabel.text=[_game objectForKey:@"Game_Name"];
    _invitationText.text=[_game objectForKey:@"Invitation"];
}

- (IBAction)backGamesAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)playGameAction:(id)sender {
    UIAlertView *playAlert = [[UIAlertView alloc] initWithTitle:@"Participa en este Partido" message:@"Tu perfíl será enviado para ser contactado" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:@"Cancelar", nil];
    playAlert.tag=0;
    [playAlert show];
}

- (IBAction)deleteGameAction:(id)sender {
    [_game deleteInBackground];
    [self performSegueWithIdentifier:@"BackToTab" sender:self];
    //[self dismissViewControllerAnimated:YES completion:nil];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch(buttonIndex){
        case 0:{
            if (alertView.tag==0) {
                [self sendRequest];
            }else{
                break;
            }
        }
        case 1:{}
            break;
    }
}

-(void)sendRequest{
    PFUser *user=[PFUser currentUser];
    PFObject *newPostGame = [PFObject objectWithClassName:@"Requests"];
    newPostGame[@"Admin_Username"] = [_game objectForKey:@"Administrator"];
    newPostGame[@"Recipient_Username"] = user.username;
    newPostGame[@"Recipient_Phone"] = user[@"phone"];
    newPostGame[@"Field_Name"] = [_game objectForKey:@"Game_Field"];
    [newPostGame saveInBackground];
    
    UIAlertView *postedAlert =[[UIAlertView alloc]initWithTitle:@"TuCancha" message:@"Tu información ha sido enviada" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    postedAlert.tag=1;
    [postedAlert show];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
