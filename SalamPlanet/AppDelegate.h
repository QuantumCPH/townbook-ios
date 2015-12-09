//
//  AppDelegate.h
//  SalamPlanet
//
//  Created by Saad Khan on 18/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MFSideMenuContainerViewController.h"
#import "RDVTabBarController.h"
#import "EndrMenuViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>
{
    RDVTabBarController * centerTabVC;
    EndrMenuViewController *leftMenuViewController;
    UIColor *colorScheme;
    NSMutableString * centerSelected;
}
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic)CLLocationManager * locationManager;

@property (strong, nonatomic)NSArray * categoryArray;
@property (strong, nonatomic)NSDictionary * subCategoryDict;

@property (strong, nonatomic) MFSideMenuContainerViewController *container;

@property (nonatomic) AudianceType audianceType;

//Method to push the viewcontroller on Overviewpage from sliding menu
-(void)pushToOverPageVC:(UIViewController *)vc;
-(void)initializeLocationManager;

-(void)showHideSlideMenue:(BOOL)show withCenterName:(NSString *)centerN;
-(void)changeRootViewToStartApp;
-(void)hideBottomTabBar:(BOOL)hide;
-(void)hideWithoutAnimationBottomTabBar:(BOOL)hide;
-(void)loadStartViewController;

-(void)loadRegisterationChoiceScreen;

-(NSString *)getCenterLogoWithCenterName:(NSString *)centerN;
-(NSString *)getBackgroundImageName;
-(UIColor *)getTheGeneralColor;
-(UIColor*)getTheColorAccordingToCenterName:(NSString*)centerName;
-(NSString *)getCurrentSelectedCenter;
-(void)showSlideMenuForBackAction;
-(void)popHomeOverViewPage;
-(void)popHomeOverViewPageWithClosedMenu;
-(CLLocationCoordinate2D)getCurrentLocation;
-(UIFont*)getFontOfPageTitle;
-(void)removeLoadingIndicator;
-(void)registerRemoteNotification;
@end
