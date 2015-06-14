//
//  LoginViewController.h
//  TuCancha
//
//  Created by Ernesto Diaz on 8/28/14.
//  Copyright (c) 2014 Ernesto Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoginViewController : UIViewController <UITextFieldDelegate,UIAlertViewDelegate>
//Blur View
@property (strong, nonatomic) IBOutlet UIVisualEffectView *loginBlurView;

//LoginView
@property (weak, nonatomic) IBOutlet UITextField *emailLoginField;
@property (weak, nonatomic) IBOutlet UITextField *passwordLoginField;
@property (strong, nonatomic) IBOutlet UIButton *loginActionButton;
@property (strong, nonatomic) IBOutlet UIButton *registerNewUserButton;
@property (strong, nonatomic) IBOutlet UIButton *passwordResetButton;
@property (strong, nonatomic) IBOutlet UIView *fieldsLoginView;
@property (strong, nonatomic) IBOutlet UIButton *closeLoginViewButton;
@property (strong, nonatomic) IBOutlet UIButton *fieldsLoginButton;


//RegisterView
@property (strong, nonatomic) IBOutlet UIView *fieldsRegisterView;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (strong, nonatomic) IBOutlet UIButton *registerActionButton;
@property (strong, nonatomic) IBOutlet UIButton *closeRegisterViewButton;


- (IBAction)closeLoginAction:(id)sender;
- (IBAction)closeRegisterAction:(id)sender;
- (IBAction)fieldsLoginAction:(id)sender;
- (IBAction)registerAction:(id)sender;

- (IBAction)loginAction:(id)sender;
- (IBAction)registerNewUserAction:(id)sender;
- (IBAction)passwordForgetAction:(id)sender;

@end
