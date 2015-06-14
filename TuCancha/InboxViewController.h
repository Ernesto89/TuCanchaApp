//
//  InboxViewController.h
//  TuCancha
//
//  Created by Ernesto Diaz on 12/16/14.
//  Copyright (c) 2014 Ernesto Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import <Parse/Parse.h>
#import "InboxCollectionViewCell.h"

@interface InboxViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate>{
    NSArray *requestsArray;
}
@property (strong, nonatomic) IBOutlet UICollectionView *inboxCollection;

@end
