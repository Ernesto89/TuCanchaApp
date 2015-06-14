//
//  TermsViewController.h
//  TuCancha
//
//  Created by Ernesto Diaz on 1/29/15.
//  Copyright (c) 2015 Ernesto Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TermsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *privacyTextView;
@property (weak, nonatomic) IBOutlet UITextView *termstextView;
@property (strong, nonatomic) IBOutlet UIButton *termsButton;
@property (strong, nonatomic) IBOutlet UIButton *privacyButton;
@property (strong, nonatomic) IBOutlet UIView *aboutUsView;

- (IBAction)privacyAction:(id)sender;
- (IBAction)termsAction:(id)sender;

@end
