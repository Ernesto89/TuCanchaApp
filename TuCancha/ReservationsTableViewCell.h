//
//  ReservationsTableViewCell.h
//  TuCancha
//
//  Created by Ernesto Diaz on 9/9/14.
//  Copyright (c) 2014 Ernesto Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReservationsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *reservationsCellTitle;
@property (weak, nonatomic) IBOutlet UILabel *reservationsCellStatus;
@property (weak, nonatomic) IBOutlet UILabel *reservationsCellDate;

@end
