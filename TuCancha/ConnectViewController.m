//
//  ConnectViewController.m
//  TuCancha
//
//  Created by Ernesto Diaz on 11/26/14.
//  Copyright (c) 2014 Ernesto Diaz. All rights reserved.
//

#import "ConnectViewController.h"
#import "SWRevealViewController.h"

@interface ConnectViewController ()

@end

@implementation ConnectViewController

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)facebookLikeAction:(id)sender {
    
    UIActionSheet *facebookLike = [[UIActionSheet alloc] initWithTitle:@"Facebook" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Dale Like a TuCancha", nil];
    [facebookLike setTag: 0];
    [facebookLike showInView:self.view];
}

- (IBAction)instagramFollowAction:(id)sender {
    
    UIActionSheet *instagramFollow = [[UIActionSheet alloc] initWithTitle:@"Instagram" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Síguenos en Instagram", nil];
    [instagramFollow setTag: 1];
    [instagramFollow showInView:self.view];
}

- (IBAction)twitterFollowAction:(id)sender {
    
    UIActionSheet *twitterFollow = [[UIActionSheet alloc] initWithTitle:@"Twitter" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Síguenos en Twitter", nil];
    [twitterFollow setTag: 2];
    [twitterFollow showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *) actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (actionSheet.tag){
        case 0:{
            switch (buttonIndex){
                case 0:{
                    NSURL *facebookURL = [NSURL URLWithString:@"fb://profile/308091269376784"];
                    if ([[UIApplication sharedApplication] canOpenURL:facebookURL]) {
                        [[UIApplication sharedApplication] openURL:facebookURL];
                    }
                    
                }
                    break;
                case 1:{}
                    break;
            }
        }
            break;
        case 1:{
            switch (buttonIndex){
                case 0:{
                    NSURL *instagramURL = [NSURL URLWithString:@"instagram://user?username=TUCANCHAAPP"];
                    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
                        [[UIApplication sharedApplication] openURL:instagramURL];
                    }
                }
                    break;
                case 1:{}
                    break;
            }
        }
            break;
        case 2:{
            switch (buttonIndex){
                case 0:{
                    NSURL *twitterURL = [NSURL URLWithString:@"twitter://user?id=2851799457"];
                    if ([[UIApplication sharedApplication] canOpenURL:twitterURL]) {
                        [[UIApplication sharedApplication] openURL:twitterURL];
                    }
                }
                    break;
                case 1:{}
                    break;
            }
        }
            break;
    }
}
@end
