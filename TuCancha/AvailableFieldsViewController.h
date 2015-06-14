//
//  AvailableFieldsViewController.h
//  TuCancha
//
//  Created by Ernesto Diaz on 9/29/14.
//  Copyright (c) 2014 Ernesto Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MapKit/MapKit.h>
#import "AvailableFieldCollectionViewCell.h"
#import "FieldsCatalogueViewController.h"
#import <CoreLocation/CoreLocation.h>


@interface AvailableFieldsViewController : UIViewController<UIActionSheetDelegate,MKMapViewDelegate,CLLocationManagerDelegate>{
    NSArray *fieldProperties;
    NSArray *reservedFields;
    NSString *marker;
    NSNumber *reservedFieldNumber;
    NSArray *reservedFieldsNumbers;
    NSString *formattedDateString;
    NSString *markerString;
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
}
@property (retain,nonatomic) NSString *typeOfSearch;
@property (retain,nonatomic) PFObject *fieldForSearch;
@property (retain,nonatomic) NSArray *allFieldsInfo;
@property (retain,nonatomic) NSString *searchFieldName;

@property (strong,nonatomic) IBOutlet UIButton *closeInfoViewButton;
@property (strong, nonatomic) IBOutlet UIButton *closeAvailableViewButton;
@property (strong, nonatomic) IBOutlet MKMapView *fieldLocationMap;
@property (strong, nonatomic) IBOutlet UIButton *backMainButton;
@property (strong, nonatomic) IBOutlet UIButton *findFieldsAvailableButton;

@property (weak, nonatomic) IBOutlet UIView *dimInfoView;
@property (weak, nonatomic) IBOutlet UIButton *infoAvailableView;
@property (weak, nonatomic) IBOutlet UILabel *openTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *fieldPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *fieldLocationLable;
@property (weak, nonatomic) IBOutlet UILabel *infoFieldNameLabel;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UILabel *numberOfFieldsLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *selectedDate;
@property (weak, nonatomic) IBOutlet UIImageView *availableFieldImage;
//@property (weak, nonatomic) IBOutlet UILabel *availableFieldLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *availableFieldsCollection;
@property (strong, nonatomic) IBOutlet UIVisualEffectView *availableFieldsBlurView;

- (IBAction)closeAvailableViewAction:(id)sender;
- (IBAction)findFieldsAvailable:(id)sender;
- (IBAction)backMainAction:(id)sender;
- (IBAction)infoAvailableView:(id)sender;
- (IBAction)closeInfoView:(id)sender;

@end
