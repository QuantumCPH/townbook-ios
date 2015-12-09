//
//  EOverViewVC.h
//  SalamPlanet
//
//  Created by Globit on 22/10/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"
#import "SHViewPager.h"
#import "ActivitiesCollecttionVC.h"

@protocol EOverViewVCDelegate
-(void)endoreIsSelectForChat:(NSDictionary *)eDict;
@end

@interface ActivitiesMainVC : UIViewController<ActivitiesCollectionVCDelegate>
@property (weak, nonatomic) id <EOverViewVCDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *topBarBGView;
@property (weak, nonatomic) IBOutlet UIImageView *centerLogoImgV;
@property (weak, nonatomic) IBOutlet SHViewPager *pager;
@property (nonatomic)AudianceType audienceType;
@property (nonatomic) BOOL isFromChat;
@property (nonatomic) BOOL isCollectionReloading;
@property (nonatomic) BOOL isFromActivityDetail;
@property (weak, nonatomic) IBOutlet UIButton *btnMenu;
@property (weak, nonatomic) IBOutlet UIButton *btnCreate;
@property (weak, nonatomic) IBOutlet UIView *searchBGView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

- (void)showProgressView;
- (void)hideProgressView;
- (void)loadActivities;
- (IBAction)showSliderAction:(id)sender;
- (IBAction)segmentedControlChangedValue:(UISegmentedControl *)segmentedControl;
@end
