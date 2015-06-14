//
//  FieldsCatalogueViewController.h
//  TuCancha
//
//  Created by Ernesto Diaz on 4/13/15.
//  Copyright (c) 2015 Ernesto Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <iAd/iAd.h>
#import "FieldsCollectionViewCell.h"
#import <Parse/Parse.h>
#import "SWRevealViewController.h"
#import "AvailableFieldsViewController.h"
#import "CollectionReusableHeaderView.h"

@interface FieldsCatalogueViewController : UIViewController <ADBannerViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate>{
    NSArray *imagesFilesArray;
    NSMutableArray *imagesArray;
    
}
@property (strong, nonatomic) IBOutlet UICollectionView *fieldsImagesCollection;
@property (strong, nonatomic) NSArray *array;
@property (nonatomic,copy) NSArray *filteredFields;
@property (nonatomic,copy) NSArray *filterControlArray;
@property (strong,nonatomic) UISearchController *searchController;

@end
