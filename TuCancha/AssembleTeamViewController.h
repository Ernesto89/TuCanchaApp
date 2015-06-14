//
//  AssembleTeamViewController.h
//  TuCancha
//
//  Created by Ernesto Diaz on 10/23/14.
//  Copyright (c) 2014 Ernesto Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import <Parse/Parse.h>
#import "GamesCollectionViewCell.h"
#import "PlayGameViewController.h"





@interface AssembleTeamViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource>{
    NSArray *gamesArray;
    NSString *city;
    NSString *formattedDateString;
}


@property (strong, nonatomic) IBOutlet UICollectionView *gamesCollection;
@property (strong, nonatomic) IBOutlet UIButton *createGameButton;

//New Game View
@property (strong, nonatomic) IBOutlet UIView *createNewGameView;
@property (strong, nonatomic) IBOutlet UIButton *createNewGameButton;
@property (strong, nonatomic) IBOutlet UIButton *closeNewGameButton;
@property (strong, nonatomic) IBOutlet UITextField *invitationTextField;
@property (strong, nonatomic) IBOutlet UITextField *playersTextField;
@property (strong, nonatomic) IBOutlet UITextField *fieldTextField;
@property (strong, nonatomic) IBOutlet UITextField *teamTextField;


//



- (IBAction)createNewGameAction:(id)sender;
- (IBAction)closeNewGameAction:(id)sender;
- (IBAction)createGameAction:(id)sender;





@end
