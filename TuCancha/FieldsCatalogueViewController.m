//
//  FieldsCatalogueViewController.m
//  TuCancha
//
//  Created by Ernesto Diaz on 4/13/15.
//  Copyright (c) 2015 Ernesto Diaz. All rights reserved.
//

#import "FieldsCatalogueViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface FieldsCatalogueViewController ()


@end

@implementation FieldsCatalogueViewController

@synthesize fieldsImagesCollection,filteredFields,searchController;

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [[UINavigationBar appearance] setTranslucent:NO];
    
    //Set Side Menu button
    UIImage *barButtonImage = [UIImage imageNamed:@"Hamburguer-Menu.png"];
    barButtonImage = [barButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *menuBarButton = [[UIBarButtonItem alloc] initWithImage:barButtonImage style:UIBarButtonItemStylePlain target:self.revealViewController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem.width = 50.0;
    self.navigationItem.leftBarButtonItem = menuBarButton;
    
    [self queryFieldsMethod];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) queryFieldsMethod{
    //Query All fields in Parse
    PFQuery *fieldQuery = [PFQuery queryWithClassName:@"Fields_List"];
    fieldQuery.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [fieldQuery orderByDescending:@"Relevance"];
    [fieldQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            imagesFilesArray = [[NSArray alloc] initWithArray:objects];
            self.filterControlArray = imagesFilesArray;
            [fieldsImagesCollection reloadData];
        }
    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [fieldsImagesCollection resignFirstResponder];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch(section){
        case 0:{
            if (filteredFields != 0){
                imagesFilesArray= filteredFields;
            }else{
                imagesFilesArray = self.filterControlArray;
            }
            return [imagesFilesArray count];
        }
        default:{
            if (filteredFields != 0){
                imagesFilesArray= filteredFields;
            }else{
                imagesFilesArray = self.filterControlArray;
            }
            return [imagesFilesArray count];
        }
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch(indexPath.section){
        case 0:{
            static NSString *cellIdentifier = @"fieldCell";
            FieldsCollectionViewCell *cell = (FieldsCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
            
            PFObject *imageObject = [imagesFilesArray objectAtIndex:indexPath.row ];
            PFFile *imageFile = [imageObject objectForKey:@"Logo"];
            if (imageFile && ![imageFile isEqual:[NSNull null]]){
                [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    if (!error) {
                        cell.fieldImage.image = [UIImage imageWithData:data];
                        //cell.fieldName.text = [imageObject objectForKey:@"Field_Name"];
                    }
                }];
            }else{
                cell.fieldImage.image = nil;
            }
            //Shadow on the item
            //cell.layer.cornerRadius =cell.frame.size.width*0.008;
            cell.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
            cell.layer.shadowOffset = CGSizeMake(0,0);
            cell.layer.shadowRadius = cell.frame.size.width*0.007;
            cell.layer.shadowOpacity = 0.75;
            cell.layer.masksToBounds=NO;
            cell.layer.shadowPath =[UIBezierPath bezierPathWithRect:cell.bounds].CGPath;
            return cell;
        }
        default:{
            return nil;
        }
    }
}


-(UICollectionReusableView*) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    switch(indexPath.section){
        case 0:{
            //Search Bar Header
            CollectionReusableHeaderView * searchHeader = [fieldsImagesCollection dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FieldsHeader" forIndexPath:indexPath];
            
            return searchHeader;
        }
        default:{
            //Normal Header
            CollectionReusableHeaderView * searchHeader = [fieldsImagesCollection dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FieldsHeader" forIndexPath:indexPath];
            
            return searchHeader;
        }
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(fieldsImagesCollection.bounds.size.width, 44);
    }else{
        return CGSizeMake(0,0);
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return CGSizeMake(fieldsImagesCollection.bounds.size.width, 50);
    }else{
        return CGSizeMake(fieldsImagesCollection.bounds.size.width-20,100);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 1) {
        return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
    }else{
        return UIEdgeInsetsMake(10, 10, 10, 10); // top, left, bottom, right
    }
    
}


#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

#pragma mark - Search Controller


-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
    [searchBar setShowsCancelButton:YES animated:NO];
    return YES;
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    if ([searchBar.text length] !=0) {
        NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"Name CONTAINS[cd] %@", searchBar.text];
        filteredFields = [imagesFilesArray filteredArrayUsingPredicate:filterPredicate];
    }else{
        filteredFields=0;
    }
    searchBar.showsCancelButton = NO;
    [searchBar setShowsCancelButton:NO animated:NO];
    [searchBar resignFirstResponder];
    [fieldsImagesCollection reloadData];
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    
    return YES;
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = NO;
    [searchBar setShowsCancelButton:NO animated:NO];
    [searchBar resignFirstResponder];
    filteredFields = 0;
    [fieldsImagesCollection reloadData];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowAvailableField"]) {
        AvailableFieldsViewController *destViewController = segue.destinationViewController;
        destViewController.typeOfSearch =@"thisfield";
        NSArray *indexPaths = [self.fieldsImagesCollection indexPathsForSelectedItems];
        NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
        PFObject *imageObject = [imagesFilesArray objectAtIndex:indexPath.row];
        destViewController.searchFieldName= [imageObject objectForKey:@"Name"];
        destViewController.fieldForSearch=imageObject;
    }
}

#pragma mark iAd Delegate Method

-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:1];
    [UIView commitAnimations];
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:0];
    [UIView commitAnimations];
}

@end
