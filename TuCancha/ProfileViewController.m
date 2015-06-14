//
//  ProfileViewController.m
//  TuCancha
//
//  Created by Ernesto Diaz on 9/9/14.
//  Copyright (c) 2014 Ernesto Diaz. All rights reserved.
//

#import "ProfileViewController.h"
#import "MenuViewController.h"
#import "SWRevealViewController.h"


@interface ProfileViewController ()

@end

@implementation ProfileViewController

PFUser *parseUser;
PFObject *userObject;




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
    
    
    //Set Side Menu button
    UIImage *barButtonImage = [UIImage imageNamed:@"Hamburguer-Menu.png"];
    barButtonImage = [barButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *menuBarButton = [[UIBarButtonItem alloc] initWithImage:barButtonImage style:UIBarButtonItemStylePlain target:self.revealViewController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem.width = 50.0;
    self.navigationItem.leftBarButtonItem = menuBarButton;
    
    _accountSettingsView.hidden = YES;
    
    //-CloseSettingsViewButton
    _closeSettingsViewButton.layer.cornerRadius=_closeSettingsViewButton.frame.size.width*0.1;
    _closeSettingsViewButton.clipsToBounds=NO;
    _closeSettingsViewButton.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _closeSettingsViewButton.layer.shadowOffset = CGSizeZero;
    _closeSettingsViewButton.layer.shadowRadius = _closeSettingsViewButton.frame.size.width*0.1;
    _closeSettingsViewButton.layer.shadowOpacity = 0.75;
    _closeSettingsViewButton.layer.masksToBounds=NO;
    _closeSettingsViewButton.layer.shadowPath =[UIBezierPath bezierPathWithRect:_closeSettingsViewButton.bounds].CGPath;
    //ChangeDataButton
    _changeDataButton.layer.cornerRadius=_changeDataButton.frame.size.width*0.02;
    _changeDataButton.clipsToBounds=NO;
    _changeDataButton.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _changeDataButton.layer.shadowOffset = CGSizeZero;
    _changeDataButton.layer.shadowRadius = _changeDataButton.frame.size.width*0.007;
    _changeDataButton.layer.shadowOpacity = 0.75;
    _changeDataButton.layer.masksToBounds=NO;
    //ChangePasswordButton
    _changePasswordButton.layer.cornerRadius=_changePasswordButton.frame.size.width*0.02;
    _changePasswordButton.clipsToBounds=NO;
    _changePasswordButton.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _changePasswordButton.layer.shadowOffset = CGSizeZero;
    _changePasswordButton.layer.shadowRadius = _changePasswordButton.frame.size.width*0.007;
    _changePasswordButton.layer.shadowOpacity = 0.75;
    _changePasswordButton.layer.masksToBounds=NO;
    //LogOutButton
    _logOutProfileButton.layer.cornerRadius=_logOutProfileButton.frame.size.width*0.02;
    _logOutProfileButton.clipsToBounds=NO;
    _logOutProfileButton.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _logOutProfileButton.layer.shadowOffset = CGSizeZero;
    _logOutProfileButton.layer.shadowRadius = _logOutProfileButton.frame.size.width*0.007;
    _logOutProfileButton.layer.shadowOpacity = 0.75;
    _logOutProfileButton.layer.masksToBounds=NO;
    
    
    
    //Set User Profile
    parseUser= [PFUser currentUser];
    _profileName.text=parseUser[@"name"];
    _profilePhone.text=parseUser[@"phone"];
    _profileMail.text=parseUser.email;

    [self fetchUserProfileInfo];
    [self fetchRatingUser];
    
    
    
    //Read Permisiions
    self.fbLoginView.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    
    //Make Profile image round
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
    self.profileImageView.clipsToBounds = YES;
    self.fbProfilePictureView.layer.cornerRadius = self.fbProfilePictureView.frame.size.width/2;
    self.fbProfilePictureView.clipsToBounds = YES;
    
//        if ([PFUser currentUser] && // Check if user is cached
//            [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) { // Check if user is linked to Facebook
//            // Present the next view controller without animation
//        }
//        else {
//            self.profileImageView.image = [UIImage imageNamed:@"no_user_image.png"];
//            }

    // Do any additional setup after loading the view.
}
-(void)fetchUserProfileInfo{
    
    PFQuery *userInfo = [PFQuery queryWithClassName:@"_User"];
    [userInfo whereKey:@"username" equalTo:parseUser.username];
    [userInfo findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if (!error) {
            userObject=[objects objectAtIndex:0];
            if([[userObject objectForKey:@"reservations"] isEqual:[NSNull null]]){
                _reservedFieldsLabel.text=@"0";
            }else{
                _reservedFieldsLabel.text=[[userObject objectForKey:@"reservations"] stringValue];
            }
            if([[userObject objectForKey:@"games"] isEqual:[NSNull null]]){
                _gamesPlayedLabel.text=@"0";
            }else{
                _gamesPlayedLabel.text=[[userObject objectForKey:@"games"] stringValue];
            }
            
            
        }

    }];
    
}

-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user{
    
    self.fbProfilePictureView.profileID = user.objectID;
    self.profileNameLabel.text = user.name;
}

-(void)loginView:(FBLoginView *)loginView handleError:(NSError *)error{
    
    NSString *alertMessage, *alertTitle;
    if ([FBErrorUtility userMessageForError:error]) {
        alertTitle = @"Error en Facebook";
        alertMessage = [FBErrorUtility userMessageForError:error];
    }
    else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession){
        alertTitle = @"Error de Sesión";
        alertMessage = @"La sesión dejo de estar activa, Por favor Ingresa Nuevamente";
    }
    else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled){
        alertTitle = @"Erro de Autenticación";
        alertMessage = @"La autenticación ha sido cancelada";
    }
    else {
        alertTitle = @"Algo Sucedió";
        alertMessage = @"Por favor intenta nuevamente";
    }
    if (alertMessage) {
        [[[UIAlertView alloc]initWithTitle:alertTitle message:alertMessage delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
}
-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView{
    
}

-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView{
    self.fbProfilePictureView.profileID = nil;
    self.profileNameLabel.text = parseUser[@"name"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.changeMailTextField resignFirstResponder];
    [self.changePhoneTextField resignFirstResponder];
    [self.changePasswordTextField resignFirstResponder];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

-(void)fetchRatingUser{
    
    if([parseUser[@"rating"] isEqual:[NSNull null]]){
        int tempInteger=0;
        if (tempInteger ==0){
            _starRatingImage.image = [UIImage imageNamed:@"Stars_0_Rating@2x.png"];
        }else if (tempInteger >0 && tempInteger <=1){
            _starRatingImage.image = [UIImage imageNamed:@"Stars_0,5_Rating@2x.png"];
        }else if (tempInteger >1 && tempInteger <=2){
            _starRatingImage.image = [UIImage imageNamed:@"Stars_1_Rating@2x.png"];
        }else if (tempInteger >2 && tempInteger <=3){
            _starRatingImage.image = [UIImage imageNamed:@"Stars_1,5_Rating@2x.png"];
        }else if (tempInteger >3 && tempInteger <=4){
            _starRatingImage.image = [UIImage imageNamed:@"Stars_2_Rating@2x.png"];
        }else if (tempInteger >4 && tempInteger <=5){
            _starRatingImage.image = [UIImage imageNamed:@"Stars_2,5_Rating@2x.png"];
        }else if (tempInteger >5 && tempInteger <=6){
            _starRatingImage.image = [UIImage imageNamed:@"Stars_3_Rating@2x.png"];
        }else if (tempInteger >6 && tempInteger <=7){
            _starRatingImage.image = [UIImage imageNamed:@"Stars_3,5_Rating@2x.png"];
        }else if (tempInteger >7 && tempInteger <=8){
            _starRatingImage.image = [UIImage imageNamed:@"Stars_4_Rating@2x.png"];
        }else if (tempInteger >8 && tempInteger <=9){
            _starRatingImage.image = [UIImage imageNamed:@"Stars_4,5_Rating@2x.png"];
        }else if (tempInteger ==10){
            _starRatingImage.image = [UIImage imageNamed:@"Stars_5_Rating@2x.png"];
        }
    }else{
        int tempInteger = [parseUser[@"rating"] intValue];
        if (tempInteger ==0){
            _starRatingImage.image = [UIImage imageNamed:@"Stars_0_Rating@2x.png"];
        }else if (tempInteger >0 && tempInteger <=1){
            _starRatingImage.image = [UIImage imageNamed:@"Stars_0,5_Rating@2x.png"];
        }else if (tempInteger >1 && tempInteger <=2){
            _starRatingImage.image = [UIImage imageNamed:@"Stars_1_Rating@2x.png"];
        }else if (tempInteger >2 && tempInteger <=3){
            _starRatingImage.image = [UIImage imageNamed:@"Stars_1,5_Rating@2x.png"];
        }else if (tempInteger >3 && tempInteger <=4){
            _starRatingImage.image = [UIImage imageNamed:@"Stars_2_Rating@2x.png"];
        }else if (tempInteger >4 && tempInteger <=5){
            _starRatingImage.image = [UIImage imageNamed:@"Stars_2,5_Rating@2x.png"];
        }else if (tempInteger >5 && tempInteger <=6){
            _starRatingImage.image = [UIImage imageNamed:@"Stars_3_Rating@2x.png"];
        }else if (tempInteger >6 && tempInteger <=7){
            _starRatingImage.image = [UIImage imageNamed:@"Stars_3,5_Rating@2x.png"];
        }else if (tempInteger >7 && tempInteger <=8){
            _starRatingImage.image = [UIImage imageNamed:@"Stars_4_Rating@2x.png"];
        }else if (tempInteger >8 && tempInteger <=9){
            _starRatingImage.image = [UIImage imageNamed:@"Stars_4,5_Rating@2x.png"];
        }else if (tempInteger ==10){
            _starRatingImage.image = [UIImage imageNamed:@"Stars_5_Rating@2x.png"];
        }
    }
    
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


-(IBAction) logOutProfileAction:(id)sender{
    
    [PFUser logOut];
    FBSession* session = [FBSession activeSession];
    [session closeAndClearTokenInformation];
    [session close];
    [self performSegueWithIdentifier:@"LogOutSegue" sender:self];
}

- (IBAction)settingsAction:(id)sender {
    [[self navigationController]setNavigationBarHidden:YES animated:NO];
    _accountSettingsView.hidden = NO;
    
}
- (IBAction)closeSettingsView:(id)sender {
    [[self navigationController]setNavigationBarHidden:NO animated:NO];
    _accountSettingsView.hidden = YES;
}
- (IBAction)changeDataAction:(id)sender {
    
    UIAlertView *dataAlert = [[UIAlertView alloc] initWithTitle:@"Actualización de Datos" message:@"Ingresa Tu Contraseña para Actualizar los Datos" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:@"Cancelar", nil];
    dataAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    dataAlert.tag=0;
    [dataAlert show];
    [_changePhoneTextField resignFirstResponder];
    [_changePhoneTextField resignFirstResponder];
}

- (IBAction)changePasswordAction:(id)sender {
    UIAlertView *passwordAlert = [[UIAlertView alloc] initWithTitle:@"Cambia Tu Contraseña" message:@"Ingresa tu email y un link te será enviado para cambiar tu contraseña" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:@"Cancelar", nil];
    passwordAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    passwordAlert.tag=1;
    [passwordAlert show];
    [_changePasswordTextField resignFirstResponder];

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag ==1) {
        if (buttonIndex ==0) {
            NSString *emailRecovery = [[alertView textFieldAtIndex:0] text];
            [PFUser requestPasswordResetForEmailInBackground:emailRecovery];
        }
    }else if (alertView.tag==0){
        if (buttonIndex ==0) {
            PFUser *activeUser = [PFUser currentUser];
            NSString *passwordForUpadate = [[alertView textFieldAtIndex:0] text];
            

            if([_changeMailTextField.text length]!=0 ){
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    PFUser *updateUser = [PFUser logInWithUsername:activeUser.username password:passwordForUpadate];
                    updateUser.username = _changeMailTextField.text;
                    updateUser.email =_changeMailTextField.text;
                    [updateUser save];
                    dispatch_sync(dispatch_get_main_queue(), ^{
                    });
                });
                _changeMailTextField.text=nil;
            }
            if ([_changePhoneTextField.text length] !=0){
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{PFUser *updateUser = [PFUser logInWithUsername:activeUser.username password:passwordForUpadate];
                    updateUser[@"phone"]=_changePhoneTextField.text;
                    [updateUser save];
                    dispatch_sync(dispatch_get_main_queue(), ^{
                    });
                });
                _changePhoneTextField.text=nil;
            }
        }
    }
    
    
    
    
}
@end
