//
//  DirectioanAndParkingMainVC.h
//  SalamCenterApp
//
//  Created by Globit on 30/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface DirectioanAndParkingMainVC : UIViewController<UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *bgImgV;
@property (strong, nonatomic) IBOutlet UILabel *lblPageTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnBusMap;
@property (weak, nonatomic) IBOutlet UIButton *btnParking;
@property (weak, nonatomic) IBOutlet UIButton *btnMenu;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *goMapDirectionBtn;


- (IBAction)goMapDirectionBtnPressed:(id)sender;
- (IBAction)btnBusMapPressed:(id)sender;
- (IBAction)btnParkingPressed:(id)sender;
- (IBAction)btnMenuPressed:(id)sender;
@end
