//
//  InboxViewController.m
//  TuCancha
//
//  Created by Ernesto Diaz on 12/16/14.
//  Copyright (c) 2014 Ernesto Diaz. All rights reserved.
//

#import "InboxViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface InboxViewController ()

@end

@implementation InboxViewController
@synthesize inboxCollection;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController]setNavigationBarHidden:YES animated:NO];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) queryRequests {
    PFUser *user =[PFUser currentUser];
    //Query and Cache games
    PFQuery *requests = [PFQuery queryWithClassName:@"Requests"];
    [requests whereKey:@"Admin_Username" equalTo:user.username];
    [requests findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            requestsArray = [[NSArray alloc] initWithArray:objects];
        }
        [inboxCollection reloadData];
    }];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    // Return the number of sections.
    if(requestsArray){
        return 1;
    } else {
        // Display a message when the table is empty
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        messageLabel.text = @"No tienes mensajes";
        messageLabel.textColor = UIColorFromRGB(0x1D4A00);
        messageLabel.numberOfLines = 1;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
        messageLabel.alpha = 0.4;
        [messageLabel sizeToFit];
        self.inboxCollection.backgroundView = messageLabel;
        return 0;
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [requestsArray count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"InboxCell";
    InboxCollectionViewCell *cell = (InboxCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    //PFObject *tempObject = [gamesArray objectAtIndex:indexPath.row ];
    //cell.field.text=[tempObject valueForKey:@"Game_Field"];
    //cell.gameName.text=[tempObject valueForKey:@"Game_Name"];
    //cell.football.text=[tempObject valueForKey:@"Game_Players"];
    
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
