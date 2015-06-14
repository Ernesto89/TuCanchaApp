//
//  ReservationTableViewController.h
//  TuCancha
//
//  Created by Ernesto Diaz on 9/9/14.
//  Copyright (c) 2014 Ernesto Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "ReservationsTableViewCell.h"
#import "SWRevealViewController.h"


@interface ReservationTableViewController : UITableViewController <UIActionSheetDelegate> {
    
    NSMutableArray *reservationsArray;
    PFObject *modifiedReservation;
    NSIndexPath *modifyIndex;
}
@property (strong, nonatomic) IBOutlet UITableView *reservationsTableView;

@property (weak,nonatomic) NSString *citySearch;

@end
