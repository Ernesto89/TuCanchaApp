//
//  MainTabBarViewController.m
//  TuCancha
//
//  Created by Ernesto Diaz on 4/13/15.
//  Copyright (c) 2015 Ernesto Diaz. All rights reserved.
//

#import "MainTabBarViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Custom Tab Bar
    [[UITabBar appearance] setBarTintColor:UIColorFromRGB(0x71d91d)];
    [[UITabBar appearance] setTranslucent:NO];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x185400)} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0xffffff)} forState:UIControlStateSelected];

    item0 = [self.tabBar.items objectAtIndex:0];
    item1 = [self.tabBar.items objectAtIndex:1];
    item2 = [self.tabBar.items objectAtIndex:2];
    item3 = [self.tabBar.items objectAtIndex:3];
    item4 = [self.tabBar.items objectAtIndex:4];
    
    //Set Images for TabBar Items
    item0.selectedImage = [[UIImage imageNamed:@"Selected_Games-TabBar-Icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [item0 setImage:[[UIImage imageNamed:@"Unselected_Games-TabBar-Icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    item1.selectedImage = [[UIImage imageNamed:@"Selected_Reservations-TabBar-Icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [item1 setImage:[[UIImage imageNamed:@"Unselected_Reservations-TabBar-Icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    item2.selectedImage = [[UIImage imageNamed:@"Selected_Search-TabBar-Icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [item2 setImage:[[UIImage imageNamed:@"Unselected_Search-TabBar-Icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    item3.selectedImage = [[UIImage imageNamed:@"Selected_Fields-TabBar-Icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [item3 setImage:[[UIImage imageNamed:@"Unselected_Fields-TabBar-Icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    item4.selectedImage = [[UIImage imageNamed:@"Selected_Profile-TabBar-Icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [item4 setImage:[[UIImage imageNamed:@"Unselected_Profile-TabBar-Icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

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

@end
