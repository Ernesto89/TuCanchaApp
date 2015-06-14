//
//  ProfileViewController.h
//  TuCancha
//
//  Created by Ernesto Diaz on 9/9/14.
//  Copyright (c) 2014 Ernesto Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import <Parse/Parse.h>

@interface ProfileViewController : UIViewController <FBLoginViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>


//Profile View
@property (weak, nonatomic) IBOutlet UILabel *gamesPlayedLabel;
@property (weak, nonatomic) IBOutlet UILabel *reservedFieldsLabel;
@property (weak, nonatomic) IBOutlet UILabel *profileNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *starRatingImage;

//Acccount Settings View
@property (weak, nonatomic) IBOutlet UILabel *profileMail;
@property (weak, nonatomic) IBOutlet UILabel *profilePhone;
@property (weak, nonatomic) IBOutlet UILabel *profileName;
@property (weak, nonatomic) IBOutlet UIView *accountSettingsView;
@property (weak, nonatomic) IBOutlet UITextField *changeMailTextField;
@property (weak, nonatomic) IBOutlet UITextField *changePhoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *changePasswordTextField;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UIButton *logOutProfileButton;
@property (strong, nonatomic) IBOutlet UIButton *changeDataButton;
@property (strong, nonatomic) IBOutlet UIButton *changePasswordButton;
@property (strong, nonatomic) IBOutlet UIButton *closeSettingsViewButton;

//Facebook connect View
@property (weak, nonatomic) IBOutlet FBLoginView *fbLoginView;
@property (strong, nonatomic) IBOutlet UIView *fbProfileView;
@property (weak, nonatomic) IBOutlet FBProfilePictureView *fbProfilePictureView;


- (IBAction)logOutProfileAction:(id)sender;
- (IBAction)changeDataAction:(id)sender;
- (IBAction)changePasswordAction:(id)sender;
- (IBAction)closeSettingsView:(id)sender;

- (IBAction)settingsAction:(id)sender;

@end
