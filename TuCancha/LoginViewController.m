//
//  LoginViewController.m
//  TuCancha
//
//  Created by Ernesto Diaz on 8/28/14.
//  Copyright (c) 2014 Ernesto Diaz. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>



@interface LoginViewController ()

@end

@implementation LoginViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Hide views
    _fieldsRegisterView.hidden=YES;
    _fieldsLoginView.hidden=YES;
    
    
    //Customize Buttons
    //-LoginButton
    _loginActionButton.layer.cornerRadius=_loginActionButton.frame.size.width*0.02;
    _loginActionButton.clipsToBounds=NO;
    _loginActionButton.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _loginActionButton.layer.shadowOffset = CGSizeZero;
    _loginActionButton.layer.shadowRadius = _loginActionButton.frame.size.width*0.007;
    _loginActionButton.layer.shadowOpacity = 0.75;
    _loginActionButton.layer.masksToBounds=NO;
    _loginActionButton.layer.shadowPath =[UIBezierPath bezierPathWithRect:_loginActionButton.bounds].CGPath;
    //-RegisterButton
    _registerActionButton.layer.cornerRadius=_registerActionButton.frame.size.width*0.02;
    _registerActionButton.clipsToBounds=NO;
    _registerActionButton.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _registerActionButton.layer.shadowOffset = CGSizeZero;
    _registerActionButton.layer.shadowRadius = _registerActionButton.frame.size.width*0.007;
    _registerActionButton.layer.shadowOpacity = 0.75;
    _registerActionButton.layer.masksToBounds=NO;
    _registerActionButton.layer.shadowPath =[UIBezierPath bezierPathWithRect:_registerActionButton.bounds].CGPath;
    //- Show Login Button
    _fieldsLoginButton.layer.cornerRadius=_fieldsLoginButton.frame.size.width*0.02;
    _fieldsLoginButton.clipsToBounds=NO;
    _fieldsLoginButton.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _fieldsLoginButton.layer.shadowOffset = CGSizeZero;
    _fieldsLoginButton.layer.shadowRadius = _fieldsLoginButton.frame.size.width*0.007;
    _fieldsLoginButton.layer.shadowOpacity = 0.75;
    _fieldsLoginButton.layer.masksToBounds=NO;
    _fieldsLoginButton.layer.shadowPath =[UIBezierPath bezierPathWithRect:_fieldsLoginButton.bounds].CGPath;
    //-CloseLoginButton
    _closeLoginViewButton.layer.cornerRadius=_closeLoginViewButton.frame.size.width*0.1;
    _closeLoginViewButton.clipsToBounds=NO;
    _closeLoginViewButton.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _closeLoginViewButton.layer.shadowOffset = CGSizeZero;
    _closeLoginViewButton.layer.shadowRadius = _closeLoginViewButton.frame.size.width*0.1;
    _closeLoginViewButton.layer.shadowOpacity = 0.75;
    _closeLoginViewButton.layer.masksToBounds=NO;
    _closeLoginViewButton.layer.shadowPath =[UIBezierPath bezierPathWithRect:_closeLoginViewButton.bounds].CGPath;
    //- Show Register Button
    _registerNewUserButton.layer.cornerRadius=_registerNewUserButton.frame.size.width*0.02;
    _registerNewUserButton.clipsToBounds=NO;
    _registerNewUserButton.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _registerNewUserButton.layer.shadowOffset = CGSizeZero;
    _registerNewUserButton.layer.shadowRadius = _registerNewUserButton.frame.size.width*0.007;
    _registerNewUserButton.layer.shadowOpacity = 0.75;
    _registerNewUserButton.layer.masksToBounds=NO;
    //-CloseRegisterButton
    _closeRegisterViewButton.layer.cornerRadius=_closeRegisterViewButton.frame.size.width*0.1;
    _closeRegisterViewButton.clipsToBounds=NO;
    _closeRegisterViewButton.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _closeRegisterViewButton.layer.shadowOffset = CGSizeZero;
    _closeRegisterViewButton.layer.shadowRadius = _closeRegisterViewButton.frame.size.width*0.1;
    _closeRegisterViewButton.layer.shadowOpacity = 0.75;
    _closeRegisterViewButton.layer.masksToBounds=NO;
    _closeRegisterViewButton.layer.shadowPath =[UIBezierPath bezierPathWithRect:_closeRegisterViewButton.bounds].CGPath;
    
    
    //Customize Views
    //-LoginView
    //_fieldsLoginView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.6];
    _fieldsLoginView.layer.cornerRadius=_fieldsLoginView.frame.size.width*0.02;
    //_fieldsLoginView.clipsToBounds=NO;
    _fieldsLoginView.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _fieldsLoginView.layer.shadowOffset = CGSizeZero;
    _fieldsLoginView.layer.shadowRadius = _fieldsLoginView.frame.size.width*0.007;
    _fieldsLoginView.layer.shadowOpacity = 0.75;
    //_fieldsLoginView.layer.masksToBounds=NO;
    _fieldsLoginView.layer.shadowPath =[UIBezierPath bezierPathWithRect:_fieldsLoginView.bounds].CGPath;
    //-RegisterView
    //_fieldsRegisterView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.6];
    _fieldsRegisterView.layer.cornerRadius=_fieldsRegisterView.frame.size.width*0.02;
    _fieldsRegisterView.clipsToBounds=NO;
    _fieldsRegisterView.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _fieldsRegisterView.layer.shadowOffset = CGSizeZero;
    _fieldsRegisterView.layer.shadowRadius = _fieldsRegisterView.frame.size.width*0.007;
    _fieldsRegisterView.layer.shadowOpacity = 0.75;
    _fieldsRegisterView.layer.masksToBounds=NO;
    _fieldsRegisterView.layer.shadowPath =[UIBezierPath bezierPathWithRect:_fieldsRegisterView.bounds].CGPath;
    _loginBlurView.hidden=YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    [self.emailLoginField resignFirstResponder];
    [self.passwordLoginField resignFirstResponder];
    [self.emailField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    [self.nameField resignFirstResponder];
    [self.confirmPasswordField resignFirstResponder];
    [self.phoneField resignFirstResponder];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)closeLoginAction:(id)sender {
    [UIView animateWithDuration:0.8 animations:^{_loginBlurView.hidden=YES;}];
    _fieldsLoginView.hidden=YES;
}

- (IBAction)closeRegisterAction:(id)sender {
    [UIView animateWithDuration:0.8 animations:^{_loginBlurView.hidden=YES;}];
    _fieldsRegisterView.hidden=YES;
}

- (IBAction)fieldsLoginAction:(id)sender {
    [UIView animateWithDuration:0.8 animations:^{_loginBlurView.hidden=NO;}];
    _fieldsLoginView.hidden=NO;
}



- (IBAction)loginAction:(id)sender {
    
    [_passwordLoginField resignFirstResponder];
    [_emailLoginField resignFirstResponder];
    
    if ([_emailLoginField.text isEqualToString:@""] || [_passwordLoginField.text isEqualToString:@""] ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oopss" message:@"Necesitas llenar todos los datos" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else {
        [PFUser logInWithUsernameInBackground:_emailLoginField.text password:_passwordLoginField.text block:^(PFUser *user, NSError *error) {
            if(error){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oopss" message:@"Hubo problemas al Ingresar" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
            }
            else{
                _emailLoginField.text = nil;
                _passwordLoginField.text = nil;
                [self performSegueWithIdentifier:@"LoginSegue" sender:self];
                
            }
        }];
    }
}

- (IBAction)passwordForgetAction:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Recupera Tu Contraseña" message:@"Ingresa tu email y un link te será enviado para recuperar tu contraseña" delegate:self cancelButtonTitle:@"Recuperar" otherButtonTitles:@"Cancelar", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

#pragma mark - UIAlertView Delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex==0){
        NSString *emailRecovery = [[alertView textFieldAtIndex:0] text];
        [PFUser requestPasswordResetForEmailInBackground:emailRecovery];
    }
}

#pragma mark - Registration

- (IBAction)registerNewUserAction:(id)sender {
    [UIView animateWithDuration:0.8 animations:^{_loginBlurView.hidden=NO;}];
    _fieldsRegisterView.hidden=NO;

}

- (IBAction)registerAction:(id)sender {
    [_nameField resignFirstResponder];
    [_emailField resignFirstResponder];
    [_passwordField resignFirstResponder];
    [_confirmPasswordField resignFirstResponder];
    [_phoneField resignFirstResponder];
    
    [self checkFieldsComplete];
}

-(void)checkFieldsComplete{
    
    if ([_nameField.text isEqualToString:@""] || [_emailField.text isEqualToString:@""] || [_passwordField.text isEqualToString:@""] || [_confirmPasswordField.text isEqualToString:@""]|| [_phoneField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oopss" message:@"Recuerda llenar todos los datos" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else {
        [self checkPasswordsMatch];
    }
}

-(void)checkPasswordsMatch{
    if (![_passwordField.text isEqualToString:_confirmPasswordField.text]){
        [[[UIAlertView alloc]initWithTitle:@"Lo Sentimos" message:@"Las contrseñas no coinciden" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }else {
        [self registerNewUser];
    }
}

-(void)registerNewUser{
    
    PFUser *newUser = [PFUser user];
    newUser.username = _emailField.text;
    newUser.email = _emailField.text;
    newUser.password = _passwordField.text;
    newUser[@"name"] = _nameField.text;
    newUser[@"phone"] = _phoneField.text;
    newUser[@"match"] = @[];
    newUser[@"trophies"] = @[];
    newUser[@"reservations"] = [NSNull null];
    newUser[@"games"] = [NSNull null];
    newUser[@"rating"] = [NSNull null];
    newUser[@"friends"] = @[];
    newUser[@"fb_friends"] = @[];
    //newUser[@"busines"] = false;
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error){
            _nameField.text = nil;
            _emailField.text = nil;
            _passwordField.text = nil;
            _confirmPasswordField.text = nil;
            _phoneField.text = nil;
            [self performSegueWithIdentifier:@"LoginSegue" sender:self];
        }
        else{
        }
    }];
}
@end
