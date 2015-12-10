//
//  AppDelegate.m
//  SalamPlanet
//
//  Created by Saad Khan on 18/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "AppDelegate.h"
#import "RegisterationChoiceVC.h"
#import "ActivitiesMainVC.h"
#import "SplashViewController.h"
#import "MFSideMenuContainerViewController.h"
#import "RDVTabBarController.h"
#import "ProfileViewController.h"
//#import "ContactsHomeVC.h"
#import "RewardsHomeVC.h"
#import "ChatHomeViewController.h"
#import "SettingHomeViewController.h"
#import "LCMainVC.h"
#import "RDVTabBarItem.h"
#import "MainObject.h"
#import "UtilsFunctions.h"
#import "Constants.h"
#import "RegStepOneVC.h"
#import "LangaugeManager.h"
#import "DataManager.h"
#import "MBProgressHUD.h"
#import "RegStepOneVC.h"
#import "OfferDetailVC.h"
#import "MyTownHomeVC.h"
#import "EventsHomeVC.h"

@import FBSDKCoreKit;


#define kGoogle_API_KEY @"AIzaSyDeC4D6n8ci1i_DSboVF4YxrTL_pbEAhRQ"

@implementation AppDelegate
@synthesize locationManager;
@synthesize categoryArray;
@synthesize subCategoryDict;
@synthesize container;
@synthesize audianceType;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    if(GetStringWithKey(kAppLangauge) && GetStringWithKey(kAppLangauge).length>0)//Make the Language as Saved.
    {
        [NSBundle setLanguage:GetStringWithKey(kAppLangauge)];//@"en"];//da
    }
    NSDictionary *remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (remoteNotification)
    {
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        //NSLog(@"REMOTE :%@",remoteNotification);
        NSString *activityId = remoteNotification[@"ActivityId"];
        [self loadStartViewController];
        [self redirectToOfferDetailWithActivityId:activityId];
        
    }
    else
    {
        [self loadStartViewController];
        //[self redirectToOfferDetailVC];
    }
    
    //[self initializeLocationManager];
    [self defualtSettingsCustomization];
    
    //For Google Map Kit
    //[GMSServices provideAPIKey:kGoogle_API_KEY];
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
}
-(void)loadRegisterationChoiceScreen
{
    RegisterationChoiceVC * regChoiceVC =[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"RegistrationChoice"];
    UINavigationController * navController=[[UINavigationController alloc]initWithRootViewController:regChoiceVC];
    [navController.navigationBar setHidden:YES];
    self.window.rootViewController = navController;
}

-(void)loadStartViewController{
    [self initAndSaveTheDummyDataAndLocallySaveIt];
    if([GetStringWithKey(kisLoggedIn) isEqualToString:@"YES"]){
        [self changeRootViewToStartApp];
    }
    else{
        UIImage * splashImage = nil;
        UIScreen *mainScreen = [UIScreen mainScreen];
        if(mainScreen.bounds.size.height ==  480.0)
            splashImage = [UIImage imageNamed:@"splash-4"];
        else if (mainScreen.bounds.size.height ==568.0)
            splashImage = [UIImage imageNamed:@"splash-5"];
        else if (mainScreen.bounds.size.height == 667.0)
            splashImage = [UIImage imageNamed:@"splash-6"];
        else
            splashImage = [UIImage imageNamed:@"splash-6-plus"];
        SplashViewController *splashVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SplashVC"];
        splashVC.mainImage = splashImage;
        UINavigationController * navController=[[UINavigationController alloc]initWithRootViewController:splashVC];
        [navController.navigationBar setHidden:YES];
        self.window.rootViewController=navController;
    }
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[DataManager sharedInstance] saveContext];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

#pragma mark:Custom Methods
- (UINavigationController*)viewControllerForPresentation
{
    if (!centerTabVC)
        return nil;
    UINavigationController *controller =  [[centerTabVC viewControllers] objectAtIndex:0];
    
    NSAssert(controller||[controller isKindOfClass:[UINavigationController class]], @"Expected navigation controller not found");
    return controller;
}
- (void)redirectToOfferDetailWithActivityId:(NSString*)activityId
{
    UINavigationController *navController = [self viewControllerForPresentation];
    
    if (navController) {
        OfferDetailVC *offerDetailVC = [[OfferDetailVC alloc] init];
        offerDetailVC.activityId = activityId;
        [centerTabVC setSelectedViewController:navController];
        [centerTabVC setSelectedIndex:0];
        [navController pushViewController:offerDetailVC animated:YES];
    }
}
-(void)initAndSaveTheDummyDataAndLocallySaveIt{
    NSMutableArray * arrayMainObjects=[[NSMutableArray alloc]init];
    for (NSInteger i=0; i<17; i++) {
        MainObject * mainObj=[[MainObject alloc]initWithID:i];
        [arrayMainObjects addObject:[mainObj getDictionaryOfObject]];
    }
        
    NSMutableArray *archiveArray = [NSMutableArray arrayWithCapacity:arrayMainObjects.count];
    for (NSDictionary * di in arrayMainObjects) {
        NSData *personEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:di];
        [archiveArray addObject:personEncodedObject];
    }
    NSUserDefaults *userData = [NSUserDefaults standardUserDefaults];
    [userData setObject:archiveArray forKey:kArrayEndorsementCreatedLocally];
    SaveStringWithKey(@"YES",@"DummyDataSave");

//    NSArray * array=@[@"Waves",@"Galleri K"];
//    SaveArrayWithKey(array,kArrayFavouriteCatSubCat);
}
-(void)defualtSettingsCustomization{
    [[UIButton appearance] setTintColor:[UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1]];
    
    [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1]];
    colorScheme=[UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1];
}
-(void)changeRootViewToStartApp{
    [self setupTabViewControllers];
    leftMenuViewController = (EndrMenuViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LeftMenuVC"];
    container = [MFSideMenuContainerViewController
                                                    containerWithCenterViewController:centerTabVC
                                                    leftMenuViewController:leftMenuViewController
                                                    rightMenuViewController:nil];
    container.menuWidth = [UIScreen mainScreen].bounds.size.width - 60.0;
    self.window.rootViewController=container;
}
- (void)setupTabViewControllers {
    ActivitiesMainVC *firstViewController = [[ActivitiesMainVC alloc] init];
    UINavigationController *firstNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
    EventsHomeVC *eventsVC = [[EventsHomeVC alloc] init];
    UINavigationController *secondNavigationController = [[UINavigationController alloc]
                                                         initWithRootViewController:eventsVC];
    
    MyTownHomeVC *thirdViewController = [[MyTownHomeVC alloc] init];
    UINavigationController *thirdNavigationController = [[UINavigationController alloc]
                                                          initWithRootViewController:thirdViewController];
    
//    RewardsHomeVC *fourthViewController = [[RewardsHomeVC alloc] init];
//    UINavigationController *fourthNavigationController = [[UINavigationController alloc]
//                                                         initWithRootViewController:fourthViewController];
    ChatHomeViewController *fourthViewController = [[ChatHomeViewController alloc] init];
    UINavigationController *fourthNavigationController = [[UINavigationController alloc]
                                                          initWithRootViewController:fourthViewController];
    ProfileViewController *fifthViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"ProfileVC"];
    UINavigationController *fifthNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:fifthViewController];
    
    [firstNavigationController.navigationBar setHidden:YES];
    [secondNavigationController.navigationBar setHidden:YES];
    [thirdNavigationController.navigationBar setHidden:YES];
    [fourthNavigationController.navigationBar setHidden:YES];
    [fifthNavigationController.navigationBar setHidden:YES];
    
    
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    [tabBarController setViewControllers:@[firstNavigationController, secondNavigationController,thirdNavigationController,fourthNavigationController,fifthNavigationController]];
    
    centerTabVC = tabBarController;
    [self customizeTabBarForController:tabBarController];
    centerSelected=[[NSMutableString alloc]init];
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    UIImage *finishedImage = [UIImage imageNamed:@"bottom-bar"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"bottom-bar"];
    NSArray *tabBarItemImages = @[@"latest", @"event",@"towninfo",@"chat",@"profile"];
    NSArray * titleArray=[NSArray arrayWithObjects:NSLocalizedString(@"Latest", nil),NSLocalizedString(@"Event", nil),NSLocalizedString(@"My Town", nil),NSLocalizedString(@"Chat", nil),NSLocalizedString(@"Profile", nil), nil];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@B",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        item.selectedTitleAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:9],NSForegroundColorAttributeName:[UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1]};
        item.title=[titleArray objectAtIndex:index];
        item.titlePositionAdjustment=UIOffsetMake(0, 2);
        index++;
    }
    [tabBarController tabBar].backgroundColor=[UIColor clearColor];
    tabBarController.view.backgroundColor=[UIColor clearColor];
}
-(void)hideBottomTabBar:(BOOL)hide{
    RDVTabBarController * rdTaBBarVC=(RDVTabBarController*)centerTabVC;
    [rdTaBBarVC setTabBarHidden:hide animated:YES];

}
-(void)hideWithoutAnimationBottomTabBar:(BOOL)hide{
    RDVTabBarController * rdTaBBarVC=(RDVTabBarController*)centerTabVC;
    [rdTaBBarVC setTabBarHidden:hide animated:NO];
    
}

-(void)showHideSlideMenue:(BOOL)show withCenterName:(NSString *)centerN{
    [leftMenuViewController changeTheCenterLogoWithImageName:centerN];
    if(container.menuState==MFSideMenuStateClosed){
        [container setMenuState:1];
    }
    else{
        [container setMenuState:0];
    }
    if (centerN) {
        [centerSelected setString:centerN];
    }
}
-(void)showSlideMenuForBackAction{
//    if(container.menuState==MFSideMenuStateClosed){
    [container setMenuState:1];
//    }
}

-(void)pushToOverPageVC:(UIViewController *)vc{
    NSArray *arrayOfVC=centerTabVC.viewControllers;
    UINavigationController * eOverviewNavC=[arrayOfVC objectAtIndex:0];
    [eOverviewNavC pushViewController:vc animated:YES];
    [self showHideSlideMenue:NO withCenterName:nil];
}
-(void)popHomeOverViewPage{//For pop the main Home screen showing the Home Page
    NSArray *arrayOfVC=centerTabVC.viewControllers;
    UINavigationController * eOverviewNavC=[arrayOfVC objectAtIndex:0];
    [eOverviewNavC popToRootViewControllerAnimated:NO];
    [self showHideSlideMenue:NO withCenterName:nil];
}
- (void)popHomeOverViewPageWithClosedMenu{//For pop the main Home screen showing the Home Page
    NSArray *arrayOfVC=centerTabVC.viewControllers;
    UINavigationController * eOverviewNavC=[arrayOfVC objectAtIndex:0];
    [eOverviewNavC popToRootViewControllerAnimated:NO];
    [container setMenuState:0];
}
-(UIColor*)getTheColorAccordingToCenterName:(NSString*)centerName{
    if ([centerName isEqualToString:kLyngbyStorcenter]) {
        colorScheme=[UIColor blackColor];
    }
    else if ([centerName isEqualToString:kRCentrum]) {
        colorScheme=[UIColor redColor];
    }
    else if ([centerName isEqualToString:kWaves]) {
        colorScheme=[UIColor blueColor];
    }
    else if ([centerName isEqualToString:kACentret]) {
        colorScheme=[UIColor magentaColor];
    }
    else if ([centerName isEqualToString:kBCentret]) {
        colorScheme=[UIColor greenColor];
    }
    else if ([centerName isEqualToString:kGalleriK]) {
        colorScheme=[UIColor yellowColor];
    }
    else if ([centerName isEqualToString:kWaterfront]) {
        colorScheme=[UIColor orangeColor];
    }
    else{
        colorScheme=[UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1];
    }
    return colorScheme;
}
-(UIColor *)getTheGeneralColor{
    return [UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1];
}
-(NSString *)getBackgroundImageName{
    return @"BGGrey";
    //return @"BG2";
}
-(NSString *)getCenterLogoWithCenterName:(NSString *)centerN{
    if ([centerN isEqualToString:kLyngbyStorcenter]) {
        return @"rest-logo1";//@"logo_LyngbyStorcenter";
    }
    else if ([centerN isEqualToString:kRCentrum]) {
        return @"rest-logo2";//@"logo_RCentrum";
    }
    else if ([centerN isEqualToString:kWaves]) {
        return @"rest-logo3";//@"logo_Waves";
    }
    else if ([centerN isEqualToString:kACentret]) {
        return @"rest-logo4";//@"logo_ACentret";
    }
    else if ([centerN isEqualToString:kBCentret]) {
        return @"rest-logo5";//@"logo_BCentret";
    }
    else if ([centerN isEqualToString:kGalleriK]) {
        return @"rest-logo6";//@"logo_GalleriK";
    }
    else if ([centerN isEqualToString:kWaterfront]) {
        return @"rest-logo7";//@"logo_Waterfront";
    }
    else{
        return @"rest-logo8";//@"logo_ACentret";
    }
}
-(NSString *)getCurrentSelectedCenter{
    return centerSelected;
}
-(UIFont*)getFontOfPageTitle{
    return [UIFont fontWithName:@"Designosaur" size:17.0];
}
-(CLLocationCoordinate2D)getCurrentLocation{
    if (!locationManager) {
        [self initializeLocationManager];
    }
    [locationManager startUpdatingLocation];
    return locationManager.location.coordinate;
}
- (void)removeLoadingIndicator
{
    if([self.window.rootViewController isKindOfClass:[UINavigationController class]])
    {
        UIViewController *topVC = [(UINavigationController*)self.window.rootViewController topViewController];
        [MBProgressHUD hideAllHUDsForView:topVC.view animated:YES];
    }
}
#pragma mark:Initializing Methods
-(void)initializeLocationManager{
    //Location Manager
    locationManager=[[CLLocationManager alloc]init];
    locationManager.distanceFilter=kCLDistanceFilterNone;
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
    locationManager.delegate=self;
}
#pragma mark - RemoteNotification

///Register app for Remote Notifications
- (void)registerRemoteNotification
{
    UIApplication *application = [UIApplication sharedApplication];
    //-- Set Notification
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
    
    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
    {
        // iOS 8 Notifications
        [application registerForRemoteNotifications];
    }
    else
    {
        // iOS < 8 Notifications
        [application registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
    }
}
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSString* pushToken = [[[[deviceToken description]
                                stringByReplacingOccurrencesOfString: @"<" withString: @""]
                               stringByReplacingOccurrencesOfString: @">" withString: @""]
                            stringByReplacingOccurrencesOfString: @" " withString: @""];
    NSLog(@"My token is: %@", pushToken);
    [[NSUserDefaults standardUserDefaults] setObject:pushToken forKey:kDeviceToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
     //NSLog(@"DID Recieve Remote Notification: %@",userInfo);
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    NSString *activityId = userInfo[@"ActivityId"];
    [self redirectToOfferDetailWithActivityId:activityId];
}
#pragma mark: CLLocationManager Delegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    if(status==kCLAuthorizationStatusAuthorized){
       // [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationCLLocationManagerAuthentication object:nil];
    }
    else if (status == kCLAuthorizationStatusDenied)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationCLLocationManagerNotAuthentication object:nil];
    }
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    [[NSNotificationCenter defaultCenter] postNotificationName:kLocationManagerLocationUpdateNotification object:nil];
    [locationManager stopUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:kAppName message:NSLocalizedString(@"Please enable Location Services from settings", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
    [errorAlert show];
}
@end
