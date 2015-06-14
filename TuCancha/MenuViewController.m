//
//  MenuViewController.m
//  TuCancha
//
//  Created by Ernesto Diaz on 8/27/14.
//  Copyright (c) 2014 Ernesto Diaz. All rights reserved.
//
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#import "MenuViewController.h"
#import "SWRevealViewController.h"



@interface MenuViewController ()

@end

@implementation MenuViewController

NSArray *menuFirstSection;
NSArray *menuSecondSection;
NSArray *menuThirdSection;
NSURL *pictureUrl;
NSString *fbName;
NSData *fbData;
UIImageView *fbImage;
NSString *facebookIdImage;




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
    [[self navigationController]setNavigationBarHidden:YES animated:NO];
    
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"124-03.png"]];
    [tempImageView setFrame:self.tableView.frame];
    
    self.tableView.backgroundView = tempImageView;
    //[tempImageView release];
    self.tableView.scrollEnabled = NO;
    
    [FBProfilePictureView class];
    [self fbLoadData];
    
    

    menuFirstSection = @[@"Profile"];
    menuSecondSection = @[@"Main",@"Inbox",@"Connect",@"Terms"];
    
    //Set RefreshControl
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor = [UIColor whiteColor];
    self.refreshControl.alpha=0;
    [self.refreshControl addTarget:self action:@selector(refreshTableHandler:)forControlEvents:UIControlEventValueChanged];


}

-(void)viewDidAppear{
    
    CGRect frame = self.tableView.frame;
    frame.origin.y += [UIApplication sharedApplication].statusBarFrame.size.height;
    self.tableView.frame = frame;
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return [menuFirstSection count];
            break;
        case 1:
            return [menuSecondSection count];
            break;
        case 2:
            return [menuThirdSection count];
            break;
        default:
            return 0;
            break;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Background color
    view.tintColor = UIColorFromRGB(0x3A3A3A);
    
    // Text Color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor: [UIColor grayColor]];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return @"";
            break;
        case 1:
            return @"";
            break;
        case 2:
            return @"";
            break;
        default:
            return nil;
            break;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        
        static NSString *cellIdentifier = @"Profile";
        ProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell.menuProfileImage.profileID= facebookIdImage;
        cell.menuProfileImage.layer.cornerRadius=cell.menuProfileImage.frame.size.width/2;
        cell.menuProfileImage.clipsToBounds=YES;
        cell.backgroundColor=[UIColor clearColor];
        
        //cell.menuProfileImage.layer.shadowColor = [[UIColor blackColor]CGColor];
        //cell.menuProfileImage.layer.shadowOffset = CGSizeMake(5.0f,5.0f);
        //cell.menuProfileImage.layer.shadowRadius = cell.frame.size.width*0.007;
        //cell.menuProfileImage.layer.shadowOpacity = 1;
        //cell.menuProfileImage.layer.masksToBounds=NO;
        //cell.menuProfileImage.layer.shadowPath =[UIBezierPath bezierPathWithRect:cell.bounds].CGPath;
        //cell.menuProfileImage.layer.borderWidth=4.0f;
        //cell.menuProfileImage.layer.borderColor=UIColorFromRGB(0xffffff).CGColor;
//        if(FBSession.activeSession.state == FBSessionStateOpen ||FBSession.activeSession.state ==FBSessionStateCreatedOpening ||FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded){
//            //Request Server
//            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:pictureUrl];
//            
//            //Run network request asynchronously
//            [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//                if (connectionError == nil && data != nil) {
//                    // Set the image in the header imageView
//                    cell.imageView.image= [UIImage imageWithData:[NSData dataWithContentsOfURL:pictureUrl]];
//                    cell.imageView.layer.cornerRadius = cell.imageView.frame.size.width/2;
//                    cell.imageView.clipsToBounds =YES;
//                    cell.textLabel.text = fbName;
//                }
//            }];
//        }else if(FBSession.activeSession.state == FBSessionStateClosed || FBSession.activeSession.state == FBSessionStateClosedLoginFailed ||FBSession.activeSession.state == FBSessionStateCreated ||FBSession.activeSession.state == FBSessionStateCreated){
//            cell.imageView.image = [UIImage imageNamed:@"No_User_Icon.png"];
//            PFUser *tempUser =[PFUser currentUser];
//            cell.textLabel.text = tempUser[@"name"];
//            
//        };
        
        return cell;
    }else if (indexPath.section == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[menuSecondSection objectAtIndex:indexPath.row] forIndexPath:indexPath];
        cell.backgroundColor=[UIColor clearColor];
        return cell;
    }else if (indexPath.section == 2){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[menuThirdSection objectAtIndex:indexPath.row] forIndexPath:indexPath];
        cell.backgroundColor=[UIColor clearColor];
        return cell;
    }else {
        return nil;
    };
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    // This will create a "invisible" footer
    return 0.01f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section ==0){
        return 200;
    }else{
        return 44;
    }
}

- (void)fbLoadData {

    [FBSession openActiveSessionWithReadPermissions:nil allowLoginUI:NO completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
        
        if(FBSession.activeSession.isOpen|| FBSession.activeSession.state== FBSessionStateCreatedTokenLoaded){
            
            FBRequest *request = [FBRequest requestForMe];
            [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                if (!error) {
                    // result is a dictionary with the user's Facebook data
                    NSDictionary *userData = (NSDictionary *)result;
                    NSString *facebookID = userData[@"id"];
                    facebookIdImage =userData[@"id"];
                    fbName = userData[@"name"];
                    pictureUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
                }
            }];
        }
    }];
}


- (void)refreshTableHandler:(id)sender {
    __weak UIRefreshControl *refreshControl = (UIRefreshControl *)sender;
    if(refreshControl.refreshing) {
        [self.tableView reloadData];
        [refreshControl endRefreshing];
    }
}
- (void)pushFrontViewController:(UIViewController *)frontViewController animated:(BOOL)animated {
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue isKindOfClass:[SWRevealViewControllerSegue class]]){
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc,UIViewController* dvc) {
            UINavigationController* navController = (UINavigationController*) self.revealViewController.frontViewController;
            [navController setViewControllers:@[dvc] animated:NO];
            [self.revealViewController setFrontViewPosition:FrontViewPositionLeft animated:YES];
        };
    }
}


@end
