//
//  AllAvailableFieldsViewController.h
//  TuCancha
//
//  Created by Ernesto Diaz on 4/16/15.
//  Copyright (c) 2015 Ernesto Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "AllResultsCollectionViewCell.h"
#import "FieldNameHeaderView.h"

@interface AllAvailableFieldsViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource,UIActionSheetDelegate>{
    NSMutableArray *freeFieldsArray;
    NSString *markerString;
    NSNumber *reservedFieldNumber;
    NSArray *filteredReservations;
    NSString *fieldNameForReservation;
    NSArray *reservedFields;
    NSArray *reservedFieldsNumbers;
    
}
@property (copy, nonatomic) NSArray *allFields;
@property (copy, nonatomic) NSString *formatedDateString;

@property (strong, nonatomic) IBOutlet UICollectionView *allResultsCollection;
@property (strong, nonatomic) IBOutlet UIButton *closeAllResultsButton;


- (IBAction)closeAllResultsAction:(id)sender;

@end
