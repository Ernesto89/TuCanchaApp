//
//  ProfileTableViewCell.h
//  TuCancha
//
//  Created by Ernesto Diaz on 3/31/15.
//  Copyright (c) 2015 Ernesto Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface ProfileTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet FBProfilePictureView *menuProfileImage;
@property (strong, nonatomic) IBOutlet UILabel *menuNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *menuPositionLabel;

@end
