//
//  EOverViewFeaturedVC.h
//  SalamPlanet
//
//  Created by Globit on 22/10/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"
#import "ActivitiesCollecttionVC.h"
#import "CenterBannerCell.h"

@interface EOverViewFeaturedVC : UIViewController<ActivitiesCollectionVCDelegate,CenterBannerCellDelegate>

@property (nonatomic)AudianceType audianceSegment;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *topBarBGView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellPlaceholder;

- (IBAction)backAction:(id)sender;
- (id)initWIthOption:(NSString * )option ANDisCatSubCat:(BOOL)isCat;
@end
