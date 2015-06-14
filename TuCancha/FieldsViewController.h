//
//  FieldsViewController.h
//  TuCancha
//
//  Created by Ernesto Diaz on 4/7/15.
//  Copyright (c) 2015 Ernesto Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>
#import "SWRevealViewController.h"
#import "AllAvailableFieldsViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface FieldsViewController : UIViewController <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    NSArray *reservedFields;
    NSString *formattedDateString;
    NSArray *fieldsArray;
    NSArray *reservedFieldsNumbers;
}
@property (weak, nonatomic) IBOutlet MKMapView *fieldsMap;
@property (strong, nonatomic) IBOutlet UIButton *searchAllFieldsButton;
@property (strong, nonatomic) IBOutlet UIButton *selectDateButton;
@property (strong, nonatomic) IBOutlet UIButton *closeDatePickerButton;
@property (strong, nonatomic) IBOutlet UIView *fieldsDatePickerView;
@property (strong, nonatomic) IBOutlet UIDatePicker *selectDatePicker;



- (IBAction)searchAllFieldsAction:(id)sender;
- (IBAction)selectDateAction:(id)sender;
- (IBAction)closeDatePickerAction:(id)sender;


@end
