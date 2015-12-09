//
//  RestaurantMenuVC.h
//  SalamCenterApp
//
//  Created by Globit on 09/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHViewPager.h"
#import "RestMenuTableVC.h"
@class Restaurant;

@interface RestaurantMenuVC : UIViewController<SHViewPagerDataSource,SHViewPagerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *lblPageTitle;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet SHViewPager *pagerView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImgV;
@property (strong, nonatomic) Restaurant *restaurant;

- (IBAction)backBtnPressed:(id)sender;

@end
