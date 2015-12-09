//
//  EntityMapAddressVC.h
//  SalamCenterApp
//
//  Created by Waseem Asif on 21/10/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

@class Shop;
@class Restaurant;
@class MAService;

@interface EntityMapAddressVC : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *bgImgV;
@property (strong, nonatomic) IBOutlet UILabel *lblPageTitle;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextView *addressTextView;
@property (nonatomic) BOOL isForRestaurent;
@property (nonatomic) BOOL isForService;
@property (strong,nonatomic) Shop *shop;
@property (strong,nonatomic) Restaurant *restaurant;
@property (strong,nonatomic) MAService *service;

@end
