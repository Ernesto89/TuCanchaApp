//
//  AllAvailableFieldsViewController.m
//  TuCancha
//
//  Created by Ernesto Diaz on 4/16/15.
//  Copyright (c) 2015 Ernesto Diaz. All rights reserved.
//

#import "AllAvailableFieldsViewController.h"


@interface AllAvailableFieldsViewController ()

@end

@implementation AllAvailableFieldsViewController
@synthesize allResultsCollection;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //Set Side Menu button
    UIImage *barButtonImage = [UIImage imageNamed:@"Hamburguer-Menu.png"];
    barButtonImage = [barButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *menuBarButton = [[UIBarButtonItem alloc] initWithImage:barButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(goBackView)];
    self.navigationItem.leftBarButtonItem.width = 50.0;
    self.navigationItem.leftBarButtonItem = menuBarButton;
    
    _closeAllResultsButton.layer.cornerRadius=_closeAllResultsButton.frame.size.width*0.02;
    _closeAllResultsButton.clipsToBounds=NO;
    _closeAllResultsButton.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    _closeAllResultsButton.layer.shadowOffset = CGSizeZero;
    _closeAllResultsButton.layer.shadowRadius = _closeAllResultsButton.frame.size.width*0.007;
    _closeAllResultsButton.layer.shadowOpacity = 0.75;
    _closeAllResultsButton.layer.masksToBounds=NO;
    _closeAllResultsButton.layer.shadowPath =[UIBezierPath bezierPathWithRect:_closeAllResultsButton.bounds].CGPath;
    allResultsCollection.layer.cornerRadius=allResultsCollection.frame.size.width*0.02;

    allResultsCollection.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    allResultsCollection.layer.shadowOffset = CGSizeZero;
    allResultsCollection.layer.shadowRadius = allResultsCollection.frame.size.width*0.007;
    allResultsCollection.layer.shadowOpacity = 0.75;

    allResultsCollection.layer.shadowPath =[UIBezierPath bezierPathWithRect:allResultsCollection.bounds].CGPath;
    
    [self queryReservations];
    [allResultsCollection reloadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) queryReservations {
    
    //Query ALL Reservations from Parse
    PFQuery *reservationsQuery = [PFQuery queryWithClassName:@"Reservations_Medellin"];
    [reservationsQuery whereKey:@"Date" equalTo:_formatedDateString];
    reservationsQuery.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [reservationsQuery whereKey:@"Confirmation_Status" notEqualTo:@"Cancelled"];
    [reservationsQuery findObjectsInBackgroundWithBlock:^(NSArray *takenFields, NSError *error) {
        if (!error) {
            reservedFields =[[NSArray alloc] initWithArray:takenFields];
            [allResultsCollection reloadData];
        }else{
        }
    }];
    
}

-(void)goBackView{
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)freeFields{
    freeFieldsArray= [[NSMutableArray alloc]initWithArray:_allFields];
    //for ([_allFields count]; ;1){
        //if (2==2) {
            //[freeFieldsArray removeObjectAtIndex:0];
        //}else{
        //}
    //}
    
    
    // For # fields in ALL Fields
    //Ask # of reservations
    //Compare to # of fields
    //if statement
    // Return # of free fields
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [_allFields count];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    PFObject *tempObject = [_allFields objectAtIndex:section];
    NSNumber *tempNumber = [tempObject valueForKey:@"Fields_Number"];
    int tempInteger = [tempNumber intValue];
    return tempInteger;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"freeFieldCell";
    AllResultsCollectionViewCell *cell = (AllResultsCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSNumber *compareNumber = [[NSNumber alloc] initWithInteger:indexPath.item+1];
    PFObject *tempObject = [_allFields objectAtIndex:indexPath.section];
    NSString *tempString = [tempObject valueForKey:@"Field_Name"];
    NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"Field CONTAINS[cd] %@", tempString];
    filteredReservations = [reservedFields filteredArrayUsingPredicate:filterPredicate];
    reservedFieldsNumbers = [filteredReservations valueForKey:@"Field_Number"];
    if([reservedFieldsNumbers containsObject:compareNumber]){
        cell.freefieldImage.image = [UIImage imageNamed:@"Non_Available_Field.png"];
        cell.freeFieldNumber.text =[NSString stringWithFormat:@"%@",compareNumber];
        cell.controlLabel.text=@"Not Available";
    } else {
        cell.freefieldImage.image =[UIImage imageNamed:@"Available_Field.png"];
        cell.freeFieldNumber.text =[NSString stringWithFormat:@"%@",compareNumber];
        cell.controlLabel.text=@"Available";
    }
    // Configure the cell
    cell.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(0,0);
    cell.layer.shadowRadius = cell.frame.size.width*0.007;
    cell.layer.shadowOpacity = 0.75;
    cell.layer.masksToBounds=NO;
    cell.layer.shadowPath =[UIBezierPath bezierPathWithRect:cell.bounds].CGPath;
    
    //Availability
    //
    
    return cell;
}

-(UICollectionReusableView*) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    FieldNameHeaderView *fieldNameHeader = [allResultsCollection dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"AllResultsHeader" forIndexPath:indexPath];
    PFObject *tempObject = [_allFields objectAtIndex:indexPath.section];
    NSString *tempString = [tempObject valueForKey:@"Field_Name"];
    fieldNameHeader.fieldNameLabel.text=tempString;
    return fieldNameHeader;
}



#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AllResultsCollectionViewCell *cell = (AllResultsCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if ([cell.controlLabel.text isEqualToString:@"Available"]) {
        UIActionSheet *fieldReservation = [[UIActionSheet alloc] initWithTitle:@"¿Deseas Reservar esta Cancha?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Realizar Reserva", nil];
        PFObject *tempObject = [_allFields objectAtIndex:indexPath.section];
        reservedFieldNumber = [[NSNumber alloc] initWithInteger:indexPath.row+1];
        fieldNameForReservation= [[NSString alloc] initWithString:[tempObject valueForKey:@"Field_Name"]];
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
                [self dismissViewControllerAnimated:YES completion:nil];
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
    
    PFUser *userForReservation = [PFUser currentUser];
    PFObject *newReservation = [PFObject objectWithClassName:@"Reservations_Medellin"];
    newReservation[@"Reservation_User"] = userForReservation.username;
    newReservation[@"Date"] = _formatedDateString;
    newReservation[@"Field"] = fieldNameForReservation;
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

- (IBAction)closeAllResultsAction:(id)sender {
    
    //[self performSegueWithIdentifier:@"BackToTabBar" sender:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
