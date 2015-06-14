//
//  TermsViewController.m
//  TuCancha
//
//  Created by Ernesto Diaz on 1/29/15.
//  Copyright (c) 2015 Ernesto Diaz. All rights reserved.
//

#import "TermsViewController.h"
#import "SWRevealViewController.h"

@interface TermsViewController ()

@end

@implementation TermsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Customize Buttons
    //PrivacyButton
    _privacyButton.layer.cornerRadius=_privacyButton.frame.size.width*0.02;
    _privacyButton.clipsToBounds=NO;
    _privacyButton.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _privacyButton.layer.shadowOffset = CGSizeZero;
    _privacyButton.layer.shadowRadius = _privacyButton.frame.size.width*0.007;
    _privacyButton.layer.shadowOpacity = 0.75;
    _privacyButton.layer.masksToBounds=NO;
    _privacyButton.layer.shadowPath =[UIBezierPath bezierPathWithRect:_privacyButton.bounds].CGPath;
    //TermsButton
    _termsButton.layer.cornerRadius=_termsButton.frame.size.width*0.02;
    _termsButton.clipsToBounds=NO;
    _termsButton.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _termsButton.layer.shadowOffset = CGSizeZero;
    _termsButton.layer.shadowRadius = _termsButton.frame.size.width*0.007;
    _termsButton.layer.shadowOpacity = 0.75;
    _termsButton.layer.masksToBounds=NO;
    _termsButton.layer.shadowPath =[UIBezierPath bezierPathWithRect:_termsButton.bounds].CGPath;
    
    //Customize Views
    
    //Terms TextView
    _termstextView.layer.cornerRadius=_termstextView.frame.size.width*0.02;
    _termstextView.clipsToBounds=YES;
    _termstextView.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _termstextView.layer.shadowOffset = CGSizeZero;
    _termstextView.layer.shadowRadius = _termstextView.frame.size.width*0.007;
    _termstextView.layer.shadowOpacity = 0.75;
    _termstextView.layer.masksToBounds=YES;
    _termstextView.layer.shadowPath =[UIBezierPath bezierPathWithRect:_termstextView.bounds].CGPath;
    
    //Privacy textView
    _privacyTextView.layer.cornerRadius=_privacyTextView.frame.size.width*0.02;
    _privacyTextView.clipsToBounds=YES;
    _privacyTextView.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _privacyTextView.layer.shadowOffset = CGSizeZero;
    _privacyTextView.layer.shadowRadius = _privacyTextView.frame.size.width*0.007;
    _privacyTextView.layer.shadowOpacity = 0.75;
    _privacyTextView.layer.masksToBounds=YES;
    _privacyTextView.layer.shadowPath =[UIBezierPath bezierPathWithRect:_privacyTextView.bounds].CGPath;
    
    //About Us textView
    _aboutUsView.hidden=NO;
    _aboutUsView.layer.cornerRadius=_aboutUsView.frame.size.width*0.02;
    _aboutUsView.clipsToBounds=YES;
    _aboutUsView.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _aboutUsView.layer.shadowOffset = CGSizeZero;
    _aboutUsView.layer.shadowRadius = _aboutUsView.frame.size.width*0.007;
    _aboutUsView.layer.shadowOpacity = 0.75;
    _aboutUsView.layer.masksToBounds=YES;
    _aboutUsView.layer.shadowPath =[UIBezierPath bezierPathWithRect:_aboutUsView.bounds].CGPath;
    
    
    
    //SWRevealViewController Set Up
    [[self navigationController]setNavigationBarHidden:YES animated:NO];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    
    //Subviews Set Up
    _privacyTextView.hidden=YES;
    _termstextView.hidden=NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)privacyAction:(id)sender {
    _aboutUsView.hidden=YES;
    _privacyTextView.hidden=NO;
    _termstextView.hidden=YES;
}

- (IBAction)termsAction:(id)sender {
    _aboutUsView.hidden=YES;
    _privacyTextView.hidden=YES;
    _termstextView.hidden=NO;
}
@end
