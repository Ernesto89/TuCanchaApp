//
//  ReservationTableViewController.m
//  TuCancha
//
//  Created by Ernesto Diaz on 9/9/14.
//  Copyright (c) 2014 Ernesto Diaz. All rights reserved.
//

#import "ReservationTableViewController.h"


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ReservationTableViewController ()

@end

@implementation ReservationTableViewController

@synthesize reservationsTableView;

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Geolocalization
    _citySearch=@"Reservations_Medellin";
    
    //Set Side Menu button
    UIImage *barButtonImage = [UIImage imageNamed:@"Hamburguer-Menu.png"];
    barButtonImage = [barButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *menuBarButton = [[UIBarButtonItem alloc] initWithImage:barButtonImage style:UIBarButtonItemStylePlain target:self.revealViewController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem.width = 50.0;
    self.navigationItem.leftBarButtonItem = menuBarButton;
    
    //Row Heigt
    self.tableView.rowHeight = 70;
    
    //Retrieve Reservations from Parse
    [self retrieveReservationsFromParse];
    
    //Set RefreshControl
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor whiteColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self action:@selector(refreshTableHandler:)forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void) retrieveReservationsFromParse {
    //Query and Cache reservations
    PFUser *reservationsUserMade = [PFUser currentUser];
    PFQuery *retrieveReservations = [PFQuery queryWithClassName:_citySearch];
    [retrieveReservations whereKey:@"Reservation_User" equalTo:reservationsUserMade.username];
    [retrieveReservations findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            reservationsArray = [[NSMutableArray alloc] initWithArray:objects];
        }
        [self.reservationsTableView reloadData];
    }];
}

- (void)reloadReservationsData
{
    // Reload table data
    [self retrieveReservationsFromParse];
    
    // End the refreshing
    if (self.refreshControl) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Última Actualización: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
        
        [self.refreshControl endRefreshing];
    }
}
- (void)refreshTableHandler:(id)sender {
    __weak UIRefreshControl *refreshControl = (UIRefreshControl *)sender;
    if(refreshControl.refreshing) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self reloadReservationsData];
            dispatch_sync(dispatch_get_main_queue(), ^{
                [refreshControl endRefreshing];
               [self.reservationsTableView reloadData];
            });
        });
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    if (reservationsArray) {
        self.tableView.backgroundView = nil;
        return 1;
    } else {
        
        // Display a message when the table is empty
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        messageLabel.text = @"No se encontraron reservas";
        messageLabel.textColor = UIColorFromRGB(0x1D4A00);
        messageLabel.numberOfLines = 1;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
        messageLabel.alpha = 0.4;
        [messageLabel sizeToFit];
        
        self.tableView.backgroundView = messageLabel;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [reservationsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ReservationCell";
    ReservationsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    PFObject *tempObject = [reservationsArray objectAtIndex:indexPath.row];
    cell.reservationsCellTitle.text = [tempObject objectForKey:@"Field"];
   
    cell.reservationsCellStatus.text = [tempObject objectForKey:@"Confirmation_Status"];
    //NSNumber *tempNumber = [tempObject objectForKey:@"Field_Number" ];
    
    if ([cell.reservationsCellStatus.text isEqualToString:@"Active"]) {
        cell.reservationsCellStatus.backgroundColor = [UIColor greenColor];
        cell.reservationsCellStatus.textColor = [UIColor whiteColor];
    }else {
        cell.reservationsCellStatus.backgroundColor = [UIColor redColor];
        cell.reservationsCellStatus.textColor =[UIColor whiteColor];
    }
    cell.reservationsCellDate.text = [tempObject objectForKey:@"Date"];
    
    cell.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(0,0);
    cell.layer.shadowRadius = cell.frame.size.width*0.007;
    cell.layer.shadowOpacity = 0.75;
    cell.layer.masksToBounds=NO;
    cell.layer.shadowPath =[UIBezierPath bezierPathWithRect:cell.bounds].CGPath;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ReservationsTableViewCell *cell = (ReservationsTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell.reservationsCellStatus.text isEqualToString:@"Active"]) {
        UIActionSheet *fieldReservation = [[UIActionSheet alloc] initWithTitle:@"¿Deseas Confirmar/Cancelar esta Reserva?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Confirmar Reserva",@"Cancelar Reserva",nil];
        modifiedReservation = [reservationsArray objectAtIndex:indexPath.section];
        modifyIndex=indexPath;
        [fieldReservation showInView:self.view];
    }
}

-(void)actionSheet:(UIActionSheet *) actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex){
        case 0:{
            PFQuery *query = [PFQuery queryWithClassName:_citySearch];
            // Retrieve the object by id
            [query getObjectInBackgroundWithId:[modifiedReservation objectId] block:^(PFObject *modify, NSError *error) {
                // Now let's update it with some new data. In this case, only cheatMode and score
                // will get sent to the cloud. playerName hasn't changed.
                modify[@"Confirmation_Status"] = @"Confirmado";
                [modify saveInBackground];
                
            }];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self retrieveReservationsFromParse];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self.reservationsTableView reloadData];
                });
            });
        }
            break;
        case 1:{
            [modifiedReservation deleteInBackground];
            [reservationsArray removeObjectAtIndex:modifyIndex.row];
            [reservationsTableView reloadData];
        }
            break;
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
