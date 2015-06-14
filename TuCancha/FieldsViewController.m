//
//  FieldsViewController.m
//  TuCancha
//
//  Created by Ernesto Diaz on 4/7/15.
//  Copyright (c) 2015 Ernesto Diaz. All rights reserved.
//

#import "FieldsViewController.h"

#define METERS_PER_MILE 1609.344

@interface FieldsViewController ()

@end

@implementation FieldsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Customize Buttons
    _searchAllFieldsButton.hidden=NO;
    _searchAllFieldsButton.layer.cornerRadius=_searchAllFieldsButton.frame.size.width*0.02;
    _searchAllFieldsButton.clipsToBounds=NO;
    _searchAllFieldsButton.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _searchAllFieldsButton.layer.shadowOffset = CGSizeZero;
    _searchAllFieldsButton.layer.shadowRadius = _searchAllFieldsButton.frame.size.width*0.007;
    _searchAllFieldsButton.layer.shadowOpacity = 0.75;
    _searchAllFieldsButton.layer.masksToBounds=NO;
    _searchAllFieldsButton.layer.shadowPath =[UIBezierPath bezierPathWithRect:_searchAllFieldsButton.bounds].CGPath;
    _searchAllFieldsButton.hidden=NO;
    _selectDateButton.layer.cornerRadius=_selectDateButton.frame.size.width*0.02;
    _selectDateButton.clipsToBounds=NO;
    _selectDateButton.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _selectDateButton.layer.shadowOffset = CGSizeZero;
    _selectDateButton.layer.shadowRadius = _selectDateButton.frame.size.width*0.007;
    _selectDateButton.layer.shadowOpacity = 0.75;
    _selectDateButton.layer.masksToBounds=NO;
    _selectDateButton.layer.shadowPath =[UIBezierPath bezierPathWithRect:_selectDateButton.bounds].CGPath;
    _closeDatePickerButton.layer.cornerRadius=_closeDatePickerButton.frame.size.width*0.1;
    _closeDatePickerButton.clipsToBounds=NO;
    _closeDatePickerButton.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _closeDatePickerButton.layer.shadowOffset = CGSizeZero;
    _closeDatePickerButton.layer.shadowRadius = _closeDatePickerButton.frame.size.width*0.1;
    _closeDatePickerButton.layer.shadowOpacity = 0.75;
    _closeDatePickerButton.layer.masksToBounds=NO;
    _closeDatePickerButton.layer.shadowPath =[UIBezierPath bezierPathWithRect:_closeDatePickerButton.bounds].CGPath;
    //Customize Views
    _fieldsDatePickerView.hidden=YES;
    _fieldsDatePickerView.layer.cornerRadius=_fieldsDatePickerView.frame.size.width*0.02;
    _fieldsDatePickerView.clipsToBounds=NO;
    _fieldsDatePickerView.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _fieldsDatePickerView.layer.shadowOffset = CGSizeZero;
    _fieldsDatePickerView.layer.shadowRadius = _fieldsDatePickerView.frame.size.width*0.007;
    _fieldsDatePickerView.layer.shadowOpacity = 0.75;
    _fieldsDatePickerView.layer.masksToBounds=NO;
    _fieldsDatePickerView.layer.shadowPath =[UIBezierPath bezierPathWithRect:_fieldsDatePickerView.bounds].CGPath;
    
    //Set Map
    _fieldsMap.showsUserLocation=YES;
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [locationManager requestWhenInUseAuthorization];
        [locationManager startUpdatingLocation];
    }else{
        [locationManager startUpdatingLocation];
    }
    
    //Set Side Menu button
    UIImage *barButtonImage = [UIImage imageNamed:@"Hamburguer-Menu.png"];
    barButtonImage = [barButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *menuBarButton = [[UIBarButtonItem alloc] initWithImage:barButtonImage style:UIBarButtonItemStylePlain target:self.revealViewController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem.width = 50.0;
    self.navigationItem.leftBarButtonItem = menuBarButton;
    
    //Query for fields in Parse
    [self queryFieldsMethod];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// TODO: Move to Tabbar Controller
-(void) queryFieldsMethod{
    //IMPROVE!!! delete pics!
    //Query All fields from Parse
    PFQuery *fieldQuery = [PFQuery queryWithClassName:@"Fields_Medellin"];
    fieldQuery.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [fieldQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            fieldsArray = [[NSArray alloc] initWithArray:objects];
        }
    }];
}
-(void) queryReservations {
    //IMPROVE!!!
    //Preformat Date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd 'at' HH"];
    NSDate *currentDate = [NSDate dateWithTimeIntervalSinceReferenceDate:162000];
    currentDate= self.selectDatePicker.date;
    formattedDateString = [dateFormatter stringFromDate:currentDate];

    
    //Query ALL Reservations from Parse
    PFQuery *reservationsQuery = [PFQuery queryWithClassName:@"Reservations_Medellin"];
    [reservationsQuery whereKey:@"Date" equalTo:formattedDateString];
    reservationsQuery.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [reservationsQuery findObjectsInBackgroundWithBlock:^(NSArray *takenFields, NSError *error) {
        if (!error) {
            reservedFieldsNumbers = [takenFields valueForKey:@"Field_Number"];
            reservedFields =[[NSArray alloc] initWithArray:takenFields];
            [self performSegueWithIdentifier:@"ShowFreeField" sender:self];
        }else{
            if([error code] == kPFErrorConnectionFailed) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"TuCancha App" message:@"Lo sentimos, no tienes conexión" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
            }
            
        }
    }];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"ShowFreeField"]) {
        AllAvailableFieldsViewController *destViewController = segue.destinationViewController;
        //destViewController.reservedFields =reservedFields;
        destViewController.allFields =fieldsArray;
        //destViewController.reservedFieldsNumbers=reservedFieldsNumbers;
        destViewController.formatedDateString=formattedDateString;
    }
}



- (IBAction)searchAllFieldsAction:(id)sender {
    _fieldsDatePickerView.hidden=NO;
    _searchAllFieldsButton.hidden=YES;
}

- (IBAction)selectDateAction:(id)sender {
    [self queryReservations];
    _fieldsDatePickerView.hidden=YES;
    _searchAllFieldsButton.hidden=NO;
}

- (IBAction)closeDatePickerAction:(id)sender {
    _fieldsDatePickerView.hidden=YES;
    _searchAllFieldsButton.hidden=NO;
}


#pragma mark - CLLocationManager Delegate Methods
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    currentLocation = [locations objectAtIndex:0];
    [locationManager stopUpdatingLocation];
    MKCoordinateRegion localRegion= MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, 1.5*METERS_PER_MILE, 1.5*METERS_PER_MILE);
    [_fieldsMap setRegion:localRegion animated:YES];
    
}

@end
