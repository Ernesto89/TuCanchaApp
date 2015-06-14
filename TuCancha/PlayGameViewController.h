//
//  PlayGameViewController.h
//  TuCancha
//
//  Created by Ernesto Diaz on 4/27/15.
//  Copyright (c) 2015 Ernesto Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PlayGameViewController : UIViewController <UIAlertViewDelegate>

@property (copy, nonatomic) NSString *string1;
@property (copy, nonatomic) NSString *string2;
@property (copy, nonatomic) NSString *string3;
@property (strong, nonatomic) PFObject *game;

@property (strong, nonatomic) IBOutlet UIButton *playGameButton;
@property (strong, nonatomic) IBOutlet UIButton *backGamesButton;
@property (strong, nonatomic) IBOutlet UILabel *playFieldLabel;
@property (strong, nonatomic) IBOutlet UILabel *gameNameLabel;
@property (strong, nonatomic) IBOutlet UITextView *invitationText;
@property (strong, nonatomic) IBOutlet UIButton *deleteGameButton;

- (IBAction)backGamesAction:(id)sender;
- (IBAction)playGameAction:(id)sender;
- (IBAction)deleteGameAction:(id)sender;
@end
