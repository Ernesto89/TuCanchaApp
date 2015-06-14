//
//  InboxCollectionViewCell.h
//  TuCancha
//
//  Created by Ernesto Diaz on 4/27/15.
//  Copyright (c) 2015 Ernesto Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InboxCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *playerNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *playerNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *gamePlaceLabel;

@end
