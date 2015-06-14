//
//  AvailableFieldsViewController.m
//  TuCancha
//
//  Created by Ernesto Diaz on 9/29/14.
//  Copyright (c) 2014 Ernesto Diaz. All rights reserved.
//

#import "AvailableFieldsViewController.h"

//#import "SWRevealViewController.h"
// TODO: Refactor

#define METERS_PER_MILE 1609.344

@interface AvailableFieldsViewController ()

@end

@implementation AvailableFieldsViewController
@synthesize availableFieldsCollection;

- (void)viewDidLoad {
    [super viewDidLoad];
    //Customize Buttons
    _closeInfoViewButton.layer.cornerRadius=_closeInfoViewButton.frame.size.width*0.02;
    _closeInfoViewButton.clipsToBounds=NO;
    _closeInfoViewButton.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _closeInfoViewButton.layer.shadowOffset = CGSizeZero;
    _closeInfoViewButton.layer.shadowRadius = _closeInfoViewButton.frame.size.width*0.007;
    _closeInfoViewButton.layer.shadowOpacity = 0.75;
    _closeInfoViewButton.layer.masksToBounds=NO;
    _closeInfoViewButton.layer.shadowPath =[UIBezierPath bezierPathWithRect:_closeInfoViewButton.bounds].CGPath;
    
    _closeAvailableViewButton.layer.cornerRadius=_closeAvailableViewButton.frame.size.width*0.02;
    _closeAvailableViewButton.clipsToBounds=NO;
    _closeAvailableViewButton.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _closeAvailableViewButton.layer.shadowOffset = CGSizeZero;
    _closeAvailableViewButton.layer.shadowRadius = _closeAvailableViewButton.frame.size.width*0.007;
    _closeAvailableViewButton.layer.shadowOpacity = 0.75;
    _closeAvailableViewButton.layer.masksToBounds=NO;
    _closeAvailableViewButton.layer.shadowPath =[UIBezierPath bezierPathWithRect:_closeAvailableViewButton.bounds].CGPath;
    
    _closeAvailableViewButton.layer.cornerRadius=_closeAvailableViewButton.frame.size.width*0.02;
    _closeAvailableViewButton.clipsToBounds=NO;
    _closeAvailableViewButton.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _closeAvailableViewButton.layer.shadowOffset = CGSizeZero;
    _closeAvailableViewButton.layer.shadowRadius = _closeAvailableViewButton.frame.size.width*0.007;
    _closeAvailableViewButton.layer.shadowOpacity = 0.75;
    _closeAvailableViewButton.layer.masksToBounds=NO;
    _closeAvailableViewButton.layer.shadowPath =[UIBezierPath bezierPathWithRect:_closeAvailableViewButton.bounds].CGPath;
    _findFieldsAvailableButton.layer.cornerRadius=_findFieldsAvailableButton.frame.size.width*0.02;
    _findFieldsAvailableButton.clipsToBounds=NO;
    _findFieldsAvailableButton.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _findFieldsAvailableButton.layer.shadowOffset = CGSizeZero;
    _findFieldsAvailableButton.layer.shadowRadius = _findFieldsAvailableButton.frame.size.width*0.007;
    _findFieldsAvailableButton.layer.shadowOpacity = 0.75;
    _findFieldsAvailableButton.layer.masksToBounds=NO;
    _findFieldsAvailableButton.layer.shadowPath =[UIBezierPath bezierPathWithRect:_findFieldsAvailableButton.bounds].CGPath;
    //-BackMainButton
    _backMainButton.layer.cornerRadius=_backMainButton.frame.size.width*0.1;
    _backMainButton.clipsToBounds=NO;
    _backMainButton.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _backMainButton.layer.shadowOffset = CGSizeZero;
    _backMainButton.layer.shadowRadius = _backMainButton.frame.size.width*0.1;
    _backMainButton.layer.shadowOpacity = 0.75;
    _backMainButton.layer.masksToBounds=NO;
    _backMainButton.layer.shadowPath =[UIBezierPath bezierPathWithRect:_backMainButton.bounds].CGPath;
    
    
    //Customize Views
    _infoView.layer.cornerRadius =_infoView.frame.size.width*0.02;
    _infoView.layer.shadowColor = [[UIColor blackColor]CGColor];
    _infoView.layer.shadowOffset = CGSizeZero;
    _infoView.layer.shadowRadius = _infoView.frame.size.width*0.02;
    _infoView.layer.shadowOpacity = 0.75;
    _infoView.layer.shadowPath =[UIBezierPath bezierPathWithRect:_infoView.bounds].CGPath;
    
    _dimInfoView.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:0.75];
    
    _fieldLocationMap.layer.cornerRadius=_infoView.frame.size.width*0.02;
    _fieldLocationMap.clipsToBounds=NO;
    _fieldLocationMap.layer.masksToBounds=YES;
    _fieldLocationMap.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _fieldLocationMap.layer.shadowOffset = CGSizeZero;
    _fieldLocationMap.layer.shadowRadius = _closeAvailableViewButton.frame.size.width*0.007;
    _fieldLocationMap.layer.shadowOpacity = 0.75;
    _fieldLocationMap.layer.masksToBounds=NO;
    _fieldLocationMap.layer.shadowPath =[UIBezierPath bezierPathWithRect:_fieldLocationMap.bounds].CGPath;
    availableFieldsCollection.layer.cornerRadius=availableFieldsCollection.frame.size.width*0.02;
    availableFieldsCollection.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    availableFieldsCollection.layer.shadowOffset = CGSizeZero;
    availableFieldsCollection.layer.shadowRadius = availableFieldsCollection.frame.size.width*0.007;
    availableFieldsCollection.layer.shadowOpacity = 0.75;
    availableFieldsCollection.layer.shadowPath =[UIBezierPath bezierPathWithRect:availableFieldsCollection.bounds].CGPath;
    
    //Set MapKit
    _fieldLocationMap.showsUserLocation=YES;
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

    //Manage Views
    [self manageTypeOfSearch];
    //PreLoad ALL data
    [self queryForFieldsProperties];
    [self queryAvailableFields];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)manageTypeOfSearch{
    
    //Views managing
    if([_typeOfSearch isEqualToString:@"allfields"]){

    }else{
        [self fetchFieldInfo];
        //Hide/Show views
        _availableFieldsBlurView.hidden=YES;
        _dimInfoView.hidden=YES;
    }
}
-(void) fetchFieldInfo{
    
    PFFile *imageFile = [_fieldForSearch objectForKey:@"Logo"];
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            //_availableFieldLabel.text = [_fieldForSearch objectForKey:@"Name"];
            _infoFieldNameLabel.text = [_fieldForSearch objectForKey:@"Name"];
            _numberOfFieldsLabel.text = [NSString stringWithFormat:@"%@",[_fieldForSearch objectForKey:@"Fields"]];
            _fieldPhoneLabel.text = [_fieldForSearch objectForKey:@"Phone"];
            _fieldLocationLable.text =[_fieldForSearch objectForKey:@"Address"];
            _openTimeLabel.text = [_fieldForSearch objectForKey:@"Open_Time"];
            _availableFieldImage.image = [UIImage imageWithData:data];
        }
    }];
    
}

#pragma mark - CLLocationManager Delegate Methods
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    currentLocation = [locations objectAtIndex:0];
    [locationManager stopUpdatingLocation];
    
    MKCoordinateRegion localRegion= MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, 1.5*METERS_PER_MILE, 1.5*METERS_PER_MILE);

    //Locate Field on Map
    PFGeoPoint *fieldLocation=[_fieldForSearch objectForKey:@"Location"];
    
    //Annotation
    MKPointAnnotation *fieldAnnotation = [[MKPointAnnotation alloc] init];
    fieldAnnotation.coordinate = CLLocationCoordinate2DMake(fieldLocation.latitude, fieldLocation.longitude);
    fieldAnnotation.title = _searchFieldName;
    fieldAnnotation.subtitle = [_fieldForSearch objectForKey:@"Address"];

    [_fieldLocationMap setRegion:localRegion animated:YES];
    [_fieldLocationMap regionThatFits:localRegion];
    [_fieldLocationMap setCenterCoordinate:currentLocation.coordinate animated:YES];
    [_fieldLocationMap addAnnotation:fieldAnnotation];
}

-(void) queryForFieldsProperties{

        PFQuery *fieldsPropertiesQuery = [PFQuery queryWithClassName:@"Fields_List"];
    
        [fieldsPropertiesQuery whereKey:@"Name" equalTo:_searchFieldName];
        fieldsPropertiesQuery.cachePolicy=kPFCachePolicyCacheThenNetwork;
        [fieldsPropertiesQuery findObjectsInBackgroundWithBlock:^(NSArray *takenFields, NSError *error) {
            if (!error) {
                fieldProperties=[[NSArray alloc]initWithArray:takenFields];
            }
        }];
        //fieldProperties=_fieldForSearch;
        //NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"Field_Name LIKE[c] %@", [_fieldForSearch objectForKey:@"Field_Name"]];
        //fieldProperties = [_allFieldsInfo filteredArrayUsingPredicate:filterPredicate];
}

-(void) queryAvailableFields {
    //Preformat Date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd 'at' HH"];
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:162000];
    date= self.selectedDate.date;
    formattedDateString = [dateFormatter stringFromDate:date];

    //Query with date in string (Important)
    PFQuery *nonAvailableFields = [PFQuery queryWithClassName:@"Reservations_Medellin"];
    //NSString *availableFieldString = _availableFieldLabel.text;
    //nonAvailableFields.cachePolicy=kPFCachePolicyNetworkOnly;
    [nonAvailableFields whereKey:@"Field" equalTo:_searchFieldName];
    [nonAvailableFields whereKey:@"Date" equalTo:formattedDateString];
    [nonAvailableFields whereKey:@"Confirmation_Status" notEqualTo:@"Cancelled"];
    
    [nonAvailableFields findObjectsInBackgroundWithBlock:^(NSArray *takenFields, NSError *error) {
        if (!error) {
            reservedFieldsNumbers = [takenFields valueForKey:@"Field_Number"];
            reservedFields =[[NSArray alloc] initWithArray:takenFields];
            [availableFieldsCollection reloadData];
        }
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    PFObject *tempObject = [fieldProperties objectAtIndex:0];
    NSNumber *tempNumber = [tempObject valueForKey:@"Fields"];
    int tempInteger = [tempNumber intValue];
    return tempInteger;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"AvailableFieldCell";
    AvailableFieldCollectionViewCell *cell = (AvailableFieldCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSNumber *compareNumber = [[NSNumber alloc] initWithInteger:indexPath.item+1];
    
    if([reservedFieldsNumbers containsObject:compareNumber]){
        cell.fieldAvailableImage.image = [UIImage imageNamed:@"Non_Available_Field.png"];
        cell.fieldNumberLabel.text =[NSString stringWithFormat:@"%@",compareNumber];
        cell.controlLabel.text=@"Not Available";
    } else {
        cell.fieldAvailableImage.image =[UIImage imageNamed:@"Available_Field.png"];
        cell.fieldNumberLabel.text =[NSString stringWithFormat:@"%@",compareNumber];
        cell.controlLabel.text=@"Available";
    }
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    AvailableFieldCollectionViewCell *cell = (AvailableFieldCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if ([cell.controlLabel.text isEqualToString:@"Available"]) {
        UIActionSheet *fieldReservation = [[UIActionSheet alloc] initWithTitle:@"¿Deseas Reservar esta Cancha?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Realizar Reserva", nil];
        reservedFieldNumber = [[NSNumber alloc] initWithInteger:indexPath.row+1];
        [fieldReservation showInView:self.view];
        markerString=@"Available";

    }else if ([cell.controlLabel.text isEqualToString:@"Not Available"]){
        UIActionSheet *fieldReservation = [[UIActionSheet alloc] initWithTitle:@"Esta Cancha se encuentra reservada para esta fecha" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Seleccionar Otra Cancha", nil];
        reservedFieldNumber = [[NSNumber alloc] initWithInteger:indexPath.row+1];
        [fieldReservation showInView:self.view];
        markerString=@"Not Available";
    }
    
}

#pragma mark <UIActionSheetDelegate>

-(void)actionSheet:(UIActionSheet *) actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex){
        case 0:{
            if ([markerString isEqualToString:@"Available"]) {
                //Realizar Reserva
                [self saveReservation];
                [UIView animateWithDuration:0.3 animations:^{_availableFieldsBlurView.hidden=YES;}];
            }else if ([markerString isEqualToString:@"Not Available"]){
                //No se puede realizar Reserva
            }
        }
            break;
        case 1:{
        }
            break;
    }
}



-(void)saveReservation{
    //Format date for saving reservation
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd 'at' HH"];
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:162000];
    date= self.selectedDate.date;
    formattedDateString = [dateFormatter stringFromDate:date];
    
    PFUser *userForReservation = [PFUser currentUser];
    PFObject *newReservation = [PFObject objectWithClassName:@"Reservations_Medellin"];
    newReservation[@"Reservation_User"] = userForReservation.username;
    newReservation[@"Date"] = formattedDateString;
    newReservation[@"Field"] = _searchFieldName;
    newReservation[@"Confirmation_Status"] = @"Active";
    newReservation[@"Field_Number"] = reservedFieldNumber;
    newReservation[@"Reservation_Phone"] = userForReservation[@"phone"];
    [newReservation saveInBackground];
    
    UIAlertView *reservedAlert =[[UIAlertView alloc]initWithTitle:@"TuCancha" message:@"Tu reserva se realizo exitosamente" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [reservedAlert show];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)closeAvailableViewAction:(id)sender {
     [UIView animateWithDuration:0.3 animations:^{_availableFieldsBlurView.hidden=YES;}];
}

- (IBAction)findFieldsAvailable:(id)sender {
    if([_typeOfSearch isEqualToString:@"allfields"]){
    }else{
        [self queryAvailableFields];
        [UIView animateWithDuration:0.3 animations:^{_availableFieldsBlurView.hidden=NO;}];
    }
}
- (IBAction)backMainAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)infoAvailableView:(id)sender {
    //Dim InfoView for fields information
    
    //_infoView.hidden =NO;
    _dimInfoView.hidden=NO;
}

- (IBAction)closeInfoView:(id)sender {
    //_infoView.hidden=YES;
    _dimInfoView.hidden=YES;
}
@end
