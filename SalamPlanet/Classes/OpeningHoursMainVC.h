//
//  OpeningHoursMainVC.h
//  SalamCenterApp
//
//  Created by Globit on 12/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
//#import "HTHorizontalSelectionList.h"
//#import "TransportHelpVC.h"
#import "SHViewPager.h"

@interface OpeningHoursMainVC : UIViewController<UIActionSheetDelegate,SHViewPagerDataSource,SHViewPagerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *bgImgV;
@property (strong, nonatomic) IBOutlet UILabel *lblPageTitle;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIView *buttonView;
@property (weak, nonatomic) IBOutlet UIImageView *timeImgV;
@property (weak, nonatomic) IBOutlet UILabel *timeLblOne;
@property (weak, nonatomic) IBOutlet UILabel *timeLblTwo;
@property (weak, nonatomic) IBOutlet UIButton *btnBusMap;
@property (weak, nonatomic) IBOutlet UIButton *btnParking;
@property (weak, nonatomic) IBOutlet SHViewPager *pagerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *goMapDirectionBtn;


- (IBAction)backBtnPressed:(id)sender;
- (IBAction)goMapDirectionBtnPressed:(id)sender;
- (IBAction)btnBusMapPressed:(id)sender;
- (IBAction)btnParkingPressed:(id)sender;

@end
