//
//  AvailableFieldCollectionViewCell.h
//  TuCancha
//
//  Created by Ernesto Diaz on 10/7/14.
//  Copyright (c) 2014 Ernesto Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AvailableFieldCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *fieldNumberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *fieldAvailableImage;
@property (weak, nonatomic) IBOutlet UILabel *controlLabel;

@end
