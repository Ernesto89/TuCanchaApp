//
//  AppDelegate.m
//  TuCancha
//
//  Created by Ernesto Diaz on 8/27/14.
//  Copyright (c) 2014 Ernesto Diaz. All rights reserved.
//

#import "AppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface AppDelegate ()
            

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //Custom Navigation Bar
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x71d91d)];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    
    
    if (![CLLocationManager locationServicesEnabled]) {
        // location services is disabled, alert user
        UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"DisabledTitle", @"DisabledTitle") message:NSLocalizedString(@"DisabledMessage", @"DisabledMessage") delegate:nil cancelButtonTitle:NSLocalizedString(@"OKButtonTitle", @"OKButtonTitle")otherButtonTitles:nil];
        [servicesDisabledAlert show];
    }
    
    
    // Custom TableView Separator Insets
    if ([UITableView instancesRespondToSelector:@selector(setLayoutMargins:)]) {
        
        [[UITableView appearance] setLayoutMargins:UIEdgeInsetsZero];
        [[UITableViewCell appearance] setLayoutMargins:UIEdgeInsetsZero];
        [[UITableViewCell appearance] setPreservesSuperviewLayoutMargins:NO];
    }

    //Enable LocalDataStore Parse

    //Register App in Parse
    [Parse setApplicationId:@"o8lhQYrP5N9xy46JShFCZzgpnzpfPGsJs2hhyD04" clientKey:@"UXR0S9Iwa4mbDwim6vrNLPh1g8QrOCO0rpgzX7IC"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    //Check if an user is already logged in - toggle Login-Mainview
    PFUser *currentUser = [PFUser currentUser];
    if (!currentUser) {
        [self showLoginScreen:YES];
    } else {
        [self noShowLoginScreen:YES];
    }

    //Handling Facebook Sessions
    [FBSession class];
    [FBLoginView class];
    [FBProfilePictureView class];
    
    //Register for Push Notifications
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    

    return YES;
}

-(void) showLoginScreen:(BOOL)animated
{
    // Get login screen from storyboard and present it
    UIViewController* loginRootController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginViewController"];
    //UINavigationController* loginNavigation = [[UINavigationController alloc] initWithRootViewController:loginRootController];
    self.window.rootViewController = loginRootController;

}

-(void) noShowLoginScreen:(BOOL)animated
{
    // Get login screen from storyboard and present it
    UIViewController* mainRootController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    UINavigationController* mainNavigation = [[UINavigationController alloc] initWithRootViewController:mainRootController];
    self.window.rootViewController = mainNavigation;
    
}


-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {

    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];

}



-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    [PFPush storeDeviceToken:deviceToken];
    [PFPush subscribeToChannelInBackground:@""];
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];

}

- (void) application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    [PFPush handlePush:userInfo];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    

}

@end
