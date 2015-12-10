//
//  NewShopDetailVC.m
//  SalamPlanet
//
//  Created by Globit on 12/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "NewShopDetailVC.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "FBUserSelf.h"
#import "Constants.h"
#import "UtilsFunctions.h"
#import "SGActionView.h"
#import "OfferObject.h"
#import "RestaurantMenuVC.h"
#import "OfferDetailVC.h"
#import "WebManager.h"
#import "DataManager.h"
#import "User.h"
#import "Offer.h"
#import "Activity.h"
#import "Constants.h"
#import "UIImageView+WebCache.h"
#import "EntityMapAddressVC.h"
#import "BannerImage.h"
#import "SDWebImageManager.h"
#import "Timing.h"
#import "MallCenter.h"
#import "EntityInfoCell.h"
#import "BDVCountryNameAndCode.h"
#import "BannerVC.h"
#import "DetailTextCell.h"


#define kCellImageContainer @"cellImageContainer"
#define kCellDetailText @"cellDetailText"
#define kCellHeadingPF  @"cellHeadingPF"
#define kCellFeatureProduct @"cellFeaturedProduct"
#define kCellTabOptions    @"cellTabOptions"
#define kCellScrollOffers   @"cellScrollOffers"
#define kCellOpeningTime    @"cellOpeningTime"
#define kCellShareEntity    @"cellShareEntity"
#define kCellMap            @"cellMap"
#define kCellInfo           @"cellInfo"
#define kCellWebsite        @"cellWebsite"
#define kCellInfoAddress    @"cellInfoAddress"
#define kCellInfoPhone      @"cellInfoPhone"
#define kCellInfoEmail      @"cellInfoEmail"
@interface NewShopDetailVC ()
{
    NSMutableArray * mainArray;
    NSMutableArray * mainArrayOffers;
    AppDelegate * appDelegate;
    FBLogin * fbLogin;
    NSDictionary * offerDictMain;
    NSMutableArray * mainFeaturedProductArray;
    NSMutableArray *bannerImages;
    NSMutableArray *shopTimings;
    NSString * centerName;
    KIImagePager * imagePagerShop;
    DMCircularScrollView * offerCircularScrollView;
    
    BOOL isBookMarked;
    BOOL shouldExpandMap;
    UIBarButtonItem *leftItem;
    UIBarButtonItem *rightItem;
    NSURL *url;
    BOOL isSlided;
}
@property (nonatomic, strong) UIPageViewController *pagerView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSUInteger currentIndex;

@end

@implementation NewShopDetailVC
- (id)init
{
    self = [super initWithNibName:@"NewShopDetailVC" bundle:nil];
    if (self) {
        mainArray=[[NSMutableArray alloc]init];
        mainArrayOffers=[[NSMutableArray alloc]init];
        mainFeaturedProductArray=[[NSMutableArray alloc]init];
        appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return self;
}

-(id)initWithOfferCreatedLocally:(NSDictionary *)offerDict ANDCenterName:(NSString*)centername{
    self = [super initWithNibName:@"NewShopDetailVC" bundle:nil];
    if (self) {
        offerDictMain=[[NSDictionary alloc]initWithDictionary:offerDict];
        mainArray=[[NSMutableArray alloc]init];
        mainArrayOffers=[[NSMutableArray alloc]init];
        mainFeaturedProductArray=[[NSMutableArray alloc]init];
        if (centername) {
            centerName=[[NSString alloc]initWithString:centername];
        }
        appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
        if ([offerDictMain valueForKey:kTempObjImgName]) {
//            profileImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:[offerDictMain valueForKey:kTempObjImgName]]];
        }
        else{
//            profileImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shop_avatar"]];
        }
        
        isBookMarked=NO;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.isForShop && !self.isForRestaurent)
    {
        [self.backBtn setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
        self.btnBookmark.hidden = YES;
        isSlided = NO;
    }
    [appDelegate hideBottomTabBar:YES];
    //[self configureMap];
    _mapView.userInteractionEnabled = YES;
    _mapView.showsUserLocation = NO;
    [self dolocalizationText];
    self.lblPageTitle.font=[appDelegate getFontOfPageTitle];
    self.btnHomeMenu.hidden = YES;
    self.tableView.tableHeaderView=nil;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self loadMainArray];
    //[self initializeImagePager];
    self.pageControl.hidden = YES;
    self.bannerBottomImgView.hidden = YES;
   self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:[appDelegate getBackgroundImageName]]];//[UIColor colorWithRed:84.0/255.0 green:200.0/255.0 blue:163.0/255.0 alpha:1];
    
    [self updateFonts];
    _mapImageScrollView.hidden = YES;
    
    if (_isForShop) {
//        [self.btnMenu setHidden:YES];
//        CGFloat buttonWidth = screenWidth/3;
//        self.locationBtnWidthConstraint.constant = buttonWidth;
//        self.timingBtnLeftPadding.constant = (screenWidth /2 )-(buttonWidth/2);
        [self  displayAvailableShopDetails];
        //[self loadFeaturedEntities];
        [self loadShopDetails];
    }
    else if(_isForRestaurent)
    {
//        CGFloat buttonWidth = screenWidth/4;
//        self.locationBtnWidthConstraint.constant = buttonWidth;
//        self.timingBtnLeftPadding.constant = buttonWidth*2;
        [self displayAvailableRestaurantDetails];
        [self loadRestaurantDetails];
    }
    else
    {
        [self displayAvailableMallDetails];
        [self loadMallDetails];
    }
    self.shrinkBtn.hidden = YES;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    [self.navigationController.navigationBar setHidden:NO];
    //    [self customizeTheNavigationBar];
    //[self updateTopView];
    self.offerScrollView.delegate=self;
    self.tableView.delegate=self;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    [self.navigationController.navigationBar setHidden:YES];
    self.tableView.delegate=nil;
}
- (void)addMoreTimingLabels
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width-168;
    UIFont *font = [UIFont systemFontOfSize:12];
    UIColor *textColor = [UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1];
    for (int i = 2; i < shopTimings.count; i++)
    {
        CGFloat yOrigin = 8 + (15*i);
        UILabel *timingLbl = [[UILabel alloc] initWithFrame:CGRectMake(168, yOrigin, width, 14)];
        timingLbl.font = font;
        timingLbl.textColor = textColor;
        timingLbl.tag = i;
        timingLbl.text = [self getformattedTimingStringFromTiming:shopTimings[i]];
        [self.cellOpeningTime addSubview:timingLbl];
        
        UILabel *dayLbl = [[UILabel alloc] initWithFrame:CGRectMake(37, yOrigin, 126, 14)];
        dayLbl.font = font;
        dayLbl.textColor = textColor;
        dayLbl.tag = i;
        dayLbl.text = [self dayIntervalFromTimng:shopTimings[i]];
        [self.cellOpeningTime addSubview:dayLbl];
        
    }
}-(void)configureMap
{
//    _mapView.userInteractionEnabled = YES;
//    _mapView.showsUserLocation = YES;
//    entityRegion.center.latitude = 55.6761;
//    entityRegion.center.longitude = 12.5683;
    MKCoordinateRegion entityRegion;

    MallCenter *mallCenter = [[DataManager sharedInstance] currentMall];
    if(mallCenter && mallCenter.latitude !=0.0 && mallCenter.longitude !=0.0)
    {
        entityRegion.center.latitude = mallCenter.latitude;
        entityRegion.center.longitude = mallCenter.longitude;
    }
    else if(!mallCenter)
    {
        if (!_isForRestaurent) {
            entityRegion.center.latitude = _shop.latitude;
            entityRegion.center.longitude = _shop.longitude;
        }
        else{
            entityRegion.center.latitude = _restaurant.latitude;
            entityRegion.center.longitude = _restaurant.longitude;
        }
    }
    else
    {
        entityRegion.center.latitude = appDelegate.locationManager.location.coordinate.latitude;
        entityRegion.center.longitude = appDelegate.locationManager.location.coordinate.longitude;
    }
    
    entityRegion.span.latitudeDelta = 0.015;
    entityRegion.span.longitudeDelta = 0.015;
    
    // move the map to our location
    [_mapView setRegion:entityRegion animated:NO];
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = entityRegion.center;
    [_mapView addAnnotation:point];
    //    CLLocationCoordinate2D entiyCenter = entityRegion.center;
    //    _mapView.camera.altitude = 700;
    //    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(entityRegion.center, 400, 400);
    //    [self.mapView setRegion:region animated:NO];
    //[_mapView setCenterCoordinate:entityRegion.center animated:NO];
}
#pragma mark:Shop
- (void)addBanners
{
    NSArray *banners;
    if (_isForRestaurent) {
        banners = _restaurant.bannerImages.allObjects;
    }
    else
        banners = _shop.bannerImages.allObjects;
    
    bannerImages = [[NSMutableArray alloc] init];
    for (BannerImage *banner in banners) {
        [bannerImages addObject:banner.imageURL];
    }
    if (bannerImages.count>1)
    {
        self.bannerBottomImgView.hidden = NO;
        self.pageControl.hidden = NO;
        [self setUpTimer];
    }

    self.pageControl.numberOfPages = bannerImages.count;
    [self initializeImagePager];
    //[imagePagerShop reloadData];
}
- (void)displayAvailableShopDetails
{
    User * user = [[DataManager sharedInstance] currentUser];

    if ([user.favouriteShops containsObject:self.shop])
        [self.btnBookmark setSelected:YES];
    else
        [self.btnBookmark setSelected:NO];
    
    self.lblPageTitle.text = self.shop.name? self.shop.name :@"Shop";
    //[self.imgShopLogo setImageWithURL:[NSURL URLWithString:_shop.logoURL] placeholderImage:[UIImage imageNamed:@"place-holder"]];
    url = [NSURL URLWithString:_shop.logoURL];
}
- (void)displayShopDetails
{
    self.lblPageTitle.text = self.shop.name? self.shop.name :@"Shop";
    //[self.imgShopLogo setImageWithURL:[NSURL URLWithString:_shop.logoURL] placeholderImage:[UIImage imageNamed:@"place-holder"]];
    self.detailText.text = self.shop.aboutText;
    if(_shop.mapActive)
    {
        _mapImageScrollView.hidden = NO;
        [_mapImageView setImageWithURL:[NSURL URLWithString:_shop.siteMapURL]];
        
    }
    else
        [self configureMap];
    [self displayShopTimings];
    //[self configureInfoCellForShop];
    [self loadMainArray];
    [self setOffersInScrollView];
    [self.tableView reloadData];
}
//- (void)configureInfoCellForShop
//{
//    _addressLbl.text = _shop.address;
//    _phoneLbl.text = _shop.phone;
//    _mailLbl.text = _shop.email;
//    _websiteTextView.linkTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1], NSUnderlineStyleAttributeName: [NSNumber numberWithInt:NSUnderlineStyleSingle]};
//    _websiteTextView.text = _shop.webURL;
//}

- (NSString*)getformattedTimingStringFromTiming:(Timing*)firstInterval
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString * openingHour = [dateFormatter stringFromDate:firstInterval.openingTime];
    NSString * closingHour = [dateFormatter stringFromDate:firstInterval.closingTime];
    NSString * timingString = nil;
    timingString = [NSString stringWithFormat:@"%@-%@",openingHour,closingHour];
    return timingString;
}
- (NSString*)dayIntervalFromTimng:(Timing*)firstInterval
{
    NSString *dayInterval = nil;
    if ([firstInterval.fromDay isEqualToString: firstInterval.toDay])
    {
        dayInterval = firstInterval.fromDay;
    }
    else
    {
        dayInterval = [NSString stringWithFormat:@"%@-%@",firstInterval.fromDay,firstInterval.toDay];
    }
    return dayInterval;
}
- (void)displayShopTimings
{
    shopTimings = [[NSMutableArray alloc] initWithArray:self.shop.timings.allObjects];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES];
    [shopTimings sortUsingDescriptors:@[sortDescriptor]];
    if (shopTimings.count>0)
    {
        if (self.shop.timings.count == 1)
        {
            Timing * firstInterval = shopTimings.firstObject;
            self.weekDayTimingLbl.text = [self getformattedTimingStringFromTiming:firstInterval];
            self.weekdayLbl.text = [self dayIntervalFromTimng:firstInterval];
        }
        else if (self.shop.timings.count == 2)
        {
            Timing * firstInterval = shopTimings.firstObject;
            self.weekDayTimingLbl.text = [self getformattedTimingStringFromTiming:firstInterval];
            self.weekdayLbl.text = [self dayIntervalFromTimng:firstInterval];
            
            Timing * secondInterval = shopTimings.lastObject;
            self.weekEndTimmingLbl.text = [self getformattedTimingStringFromTiming:secondInterval];
            self.weekdayLbl2.text = [self dayIntervalFromTimng:secondInterval];
        }
        else
        {
            Timing * firstInterval = shopTimings.firstObject;
            self.weekDayTimingLbl.text = [self getformattedTimingStringFromTiming:firstInterval];
            self.weekdayLbl.text = [self dayIntervalFromTimng:firstInterval];
            
            Timing * secondInterval = shopTimings[1];
            self.weekEndTimmingLbl.text = [self getformattedTimingStringFromTiming:secondInterval];
            self.weekdayLbl2.text = [self dayIntervalFromTimng:secondInterval];
            [self addMoreTimingLabels];
        }
    }
}
- (void)loadShopDetails
{
//    if (!self.shop.isEntityDetailLoaded)
//    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[WebManager sharedInstance] loadDetailsOfShop:_shop.entityId success:^(Shop *shop,NSString *message) {
             [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            if (!message)
            {
                _shop = shop;
                [self displayShopDetails];
                if (_shop.bannerImages.count>0)
                    [self addBanners];
            }
            else
                ShowMessage(kAppName, message);
            
        } failure:^(NSString *errorString) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            ShowMessage(kAppName,errorString);
        }];
//    }
//    else
//    {
//        [self displayShopDetails];
//        if (_shop.bannerImages.count>0)
//        {
//            [self performSelector:@selector(addBanners) withObject:nil afterDelay:0.1];
//        }
//    }
}
#pragma mark:Restaurant
- (void)loadRestaurantDetails
{
    //if (!self.restaurant.isEntityDetailLoaded) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[WebManager sharedInstance] loadDetailsOfRestaurant:_restaurant.entityId success:^(Restaurant *restaurant,NSString *message) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            if (!message)
            {
                _restaurant = restaurant;
                [self displayRestaurantDetails];
                if (_restaurant.bannerImages.count>0)
                    [self addBanners];
            }
            else
                ShowMessage(kAppName, message);
            
        } failure:^(NSString *errorString) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            ShowMessage(kAppName,errorString);
        }];
//    }
//    else
//    {
//        [self displayRestaurantDetails];
//        if (_restaurant.bannerImages.count>0)
//        {
//            [self performSelector:@selector(addBanners) withObject:nil afterDelay:0.1];
//        }
//
//    }
}
- (void)displayAvailableRestaurantDetails
{
    User * user = [[DataManager sharedInstance] currentUser];
    
    if ([user.favouriteRestaurants containsObject:self.restaurant])
        [self.btnBookmark setSelected:YES];
    else
        [self.btnBookmark setSelected:NO];
    
    self.lblPageTitle.text = self.restaurant.name? self.restaurant.name :@"Restaurant";
    //[self.imgShopLogo setImageWithURL:[NSURL URLWithString:self.restaurant.logoURL] placeholderImage:[UIImage imageNamed:@"place-holder"]];
    url = [NSURL URLWithString:_restaurant.logoURL];
}

- (void)displayRestaurantDetails
{
    self.lblPageTitle.text = self.restaurant.name? self.restaurant.name :@"Restaurant";
    //[self.imgShopLogo setImageWithURL:[NSURL URLWithString:self.restaurant.logoURL] placeholderImage:[UIImage imageNamed:@"place-holder"]];
    self.detailText.text = self.restaurant.aboutText;
    if(_restaurant.mapActive)
    {
        _mapImageScrollView.hidden = NO;
        [_mapImageView setImageWithURL:[NSURL URLWithString:_restaurant.siteMapURL]];
        
    }
    else
        [self configureMap];

    [self displayRestaurantTimings];
    //[self configureInfoCellForRestaurant];
    [self loadMainArray];
    [self setOffersInScrollView];
    [self.tableView reloadData];
}
- (void)displayRestaurantTimings
{
    shopTimings = [[NSMutableArray alloc] initWithArray:self.restaurant.timings.allObjects];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES];
    [shopTimings sortUsingDescriptors:@[sortDescriptor]];
    if (shopTimings.count>0)
    {
        if (self.restaurant.timings.count == 1)
        {
            Timing * firstInterval = shopTimings.firstObject;
            self.weekDayTimingLbl.text = [self getformattedTimingStringFromTiming:firstInterval];
            self.weekdayLbl.text = [self dayIntervalFromTimng:firstInterval];
        }
        else if (self.restaurant.timings.count == 2)
        {
            Timing * firstInterval = shopTimings.firstObject;
            self.weekDayTimingLbl.text = [self getformattedTimingStringFromTiming:firstInterval];
            self.weekdayLbl.text = [self dayIntervalFromTimng:firstInterval];
            
            Timing * secondInterval = shopTimings.lastObject;
            self.weekEndTimmingLbl.text = [self getformattedTimingStringFromTiming:secondInterval];
            self.weekdayLbl2.text = [self dayIntervalFromTimng:secondInterval];
        }
        else
        {
            Timing * firstInterval = shopTimings.firstObject;
            self.weekDayTimingLbl.text = [self getformattedTimingStringFromTiming:firstInterval];
            self.weekdayLbl.text = [self dayIntervalFromTimng:firstInterval];
            
            Timing * secondInterval = shopTimings[1];
            self.weekEndTimmingLbl.text = [self getformattedTimingStringFromTiming:secondInterval];
            self.weekdayLbl2.text = [self dayIntervalFromTimng:secondInterval];
            
            [self addMoreTimingLabels];
        }
    }
}
#pragma mark:Mall
- (void)loadMallDetails
{
     [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WebManager sharedInstance] loadDetailsOfMall:_mall.mallPlaceId success:^(MallCenter *mall, NSString *message) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (mall) {
            _mall = mall;
            [self displayMallDetails];
        }
    } failure:^(NSString *errorString) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ShowMessage(kAppName,errorString);
    }];
}
- (void)displayAvailableMallDetails
{
    self.lblPageTitle.text = self.mall.name? self.mall.name :@"Mall";
    self.detailText.text = self.mall.aboutText;
    [self configureMap];
    [self loadMainArray];
    [self.tableView reloadData];
 
}
- (void)displayMallDetails
{
    self.lblPageTitle.text = self.mall.name? self.mall.name :@"Mall";
    self.detailText.text = self.mall.aboutText;
    bannerImages = [[NSMutableArray alloc ] init];
    [bannerImages addObject:_mall.logoURL];
    [self initializeImagePager];
    [self displayMallTimings];
    [self loadMainArray];
    [self.tableView reloadData];
    
}
- (void)displayMallTimings
{
    shopTimings = [[NSMutableArray alloc] initWithArray:self.mall.mallTimings.allObjects];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES];
    [shopTimings sortUsingDescriptors:@[sortDescriptor]];
    if (shopTimings.count>0)
    {
        if (self.mall.mallTimings.count == 1)
        {
            Timing * firstInterval = shopTimings.firstObject;
            self.weekDayTimingLbl.text = [self getformattedTimingStringFromTiming:firstInterval];
            self.weekdayLbl.text = [self dayIntervalFromTimng:firstInterval];
        }
        else if (self.mall.mallTimings.count == 2)
        {
            Timing * firstInterval = shopTimings.firstObject;
            self.weekDayTimingLbl.text = [self getformattedTimingStringFromTiming:firstInterval];
            self.weekdayLbl.text = [self dayIntervalFromTimng:firstInterval];
            
            Timing * secondInterval = shopTimings.lastObject;
            self.weekEndTimmingLbl.text = [self getformattedTimingStringFromTiming:secondInterval];
            self.weekdayLbl2.text = [self dayIntervalFromTimng:secondInterval];
        }
        else
        {
            Timing * firstInterval = shopTimings.firstObject;
            self.weekDayTimingLbl.text = [self getformattedTimingStringFromTiming:firstInterval];
            self.weekdayLbl.text = [self dayIntervalFromTimng:firstInterval];
            
            Timing * secondInterval = shopTimings[1];
            self.weekEndTimmingLbl.text = [self getformattedTimingStringFromTiming:secondInterval];
            self.weekdayLbl2.text = [self dayIntervalFromTimng:secondInterval];
            
            [self addMoreTimingLabels];
        }
    }
}
#pragma mark:Custom Methods
-(NSString*)getFormattedPhoneNumber:(NSString*)num
{
    NSString * number = num;
    NSString * country = [[[DataManager sharedInstance] currentMall] country];
    BDVCountryNameAndCode * bdvNameAndCode = [[BDVCountryNameAndCode alloc] init];
    NSNumber *prefix =  [bdvNameAndCode getPrefixFromCountryShortName:country];
    
    if (prefix) {
        NSString * formatterPrefix = @"+";
        formatterPrefix = [formatterPrefix stringByAppendingString:prefix.stringValue];
        if (![num hasPrefix:formatterPrefix]) {
            number = [NSString stringWithFormat:@"%@ %@",formatterPrefix,num];
        }
    }
    return number;
}
//-(void)customizeTheNavigationBar{
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"euserInfo-background"]
//                                                  forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    self.navigationController.navigationBar.translucent = YES;
//    
//    if (!leftItem) {
//        leftItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back-button"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleBordered target:self action:@selector(leftNavBarBtnPressed:)];
//        leftItem.tintColor=[UIColor clearColor];
//    }
//    if (!rightItem) {
//        NSString * imgName;
//        if (isBookMarked) {
//            imgName=@"heart_large_p";
//        }
//        else{
//            imgName=@"heart_large";
//        }
//        rightItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleBordered target:self action:@selector(rightNavBarBtnPressed:)];
//    }
//    [[self navigationItem] setLeftBarButtonItem:leftItem];
//    [[self navigationItem] setRightBarButtonItem:rightItem];
//    
//    if ([offerDictMain valueForKey:kTempObjShop]) {
//        [[self navigationItem] setTitle:[offerDictMain valueForKey:kTempObjShop]];
//    }
//    else{
//        [[self navigationItem] setTitle:@"Shop"];
//    }
//    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
//}
-(void)dolocalizationText{
    self.lblRelatedShopsHeading.text=NSLocalizedString(@"Featured Shops", nil);
    self.lblShopOfferTitle.text=NSLocalizedString(@"The Shop Offers", nil);
    [self.websiteBtn setTitle:NSLocalizedString(@"Go to homepage", nil) forState:UIControlStateNormal];
    [self.websiteBtn setTitle:NSLocalizedString(@"Go to homepage", nil) forState:UIControlStateSelected];
}

-(void)setOffersInScrollView{
    [mainArrayOffers removeAllObjects];
    
    if (!_isForRestaurent)
        _offers = [self.shop.entityActivities allObjects];
    else
        _offers = [self.restaurant.entityActivities allObjects];
    
    CGSize size=self.offerScrollView.contentSize;
    if (_offers.count>0)
        size.width = _offers.count*95;
    else
        size.width = 2*95;
    self.offerScrollView.contentSize=size;
    for (int i = 0; i< _offers.count;i++)
    {
        Offer *offer = _offers[i];
        ShopOfferView * shopOfferView=[[ShopOfferView alloc]initWithOffer:offer];
        shopOfferView.frame = CGRectMake(i*95, 0, 95, 122);
        shopOfferView.delegate = self;
        [self.offerScrollView addSubview:shopOfferView];
    }
    
    [self.imgBackwardArrow setHidden:YES];
    if (_offers.count<3)
    {
        [self.imgForwardArrow setHidden:YES];
    }
//    for (NSInteger i=0; i<5; i++) {
//        OfferObject * obj=[[OfferObject alloc]initWithID:i];
//        ShopOfferView * shopOfferView=[[ShopOfferView alloc]initWithOfferObj:obj];
//        shopOfferView.frame=CGRectMake(i*95, 0, 95, 122);
//        shopOfferView.delegate=self;
//        [self.offerScrollView addSubview:shopOfferView];
//    }
//    self.offerScrollView.delegate=self;
}
-(void)initializeOfferCircularView{
    [mainArrayOffers removeAllObjects];
    for (NSInteger i=0; i<5; i++) {
        OfferObject * obj=[[OfferObject alloc]initWithID:i];
        ShopOfferView * shopOfferView=[[ShopOfferView alloc]initWithOfferObj:obj];
        shopOfferView.delegate=self;
        [mainArrayOffers addObject:shopOfferView];
    }
    
    __unsafe_unretained typeof(self) weakSelf = self;
    offerCircularScrollView = [[DMCircularScrollView alloc] initWithFrame:CGRectMake(10,20,300,122)];
    offerCircularScrollView.pageWidth = 100;
    [offerCircularScrollView setPageCount:[mainArrayOffers count]
                       withDataSource:^UIView *(NSUInteger pageIndex) {
                           return [weakSelf->mainArrayOffers objectAtIndex:pageIndex];
                       }];
    [self.cellScrollOffers.contentView addSubview:offerCircularScrollView];
}
-(void)updateFonts{
    [self.detailText setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:14.0]];
    [self.lblShopOfferTitle setFont:[UIFont fontWithName:@"Designosaur" size:17.0]];
    if (_isForRestaurent) {
        self.lblShopOfferTitle.text=@"The Restaurant Offers";
        self.lblRelatedShopsHeading.text=@"Related Restaurants";
    }
}
-(void)initializeImagePager{
    ;
//    imagePagerShop = [[KIImagePager alloc] initWithFrame:CGRectMake(0,0,self.imgContainerView.frame.size.width, self.imgContainerView.frame.size.height)];
//    imagePagerShop.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    
//    
//    imagePagerShop.indicatorDisabled = YES;
//    imagePagerShop.isForEntityDetails = YES;
//    imagePagerShop.dataSource=self;//Saad
//    imagePagerShop.delegate=self;//Saad
//    imagePagerShop.slideshowTimeInterval= 3.0;
//    [self.cellImageContainer.contentView addSubview:imagePagerShop];
    //[self.imgContainerView addSubview:imagePagerShop];
    
    _pagerView = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    _pagerView.dataSource = self;
    _pagerView.delegate = self;
    _pagerView.view.backgroundColor = [UIColor clearColor];
    [_pagerView.view setFrame:CGRectMake(0, 0,_imgContainerView.frame.size.width, _imgContainerView.frame.size.height)];
    _pagerView.view.userInteractionEnabled = NO;
    BannerVC *initialViewController = [self viewControllerAtIndex:0];
    _currentIndex = 0;
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    [_pagerView setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:_pagerView];
    [_imgContainerView addSubview:_pagerView.view];
    [_pagerView didMoveToParentViewController:self];
}
-(BannerVC *)viewControllerAtIndex:(NSUInteger)index {
    
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BannerVC *childVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"BannerVC"];
    childVC.indexNumber = index;
    childVC.imageUrl = bannerImages[index];
    return childVC;
}

-(CGSize)calculateSizeForText:(NSString *)txt{
    
    CGSize maximumLabelSize = CGSizeMake(290, 600);
    CGSize expectedSectionSize = [txt sizeWithFont:self.detailText.font//self.commentView.font
                                 constrainedToSize:maximumLabelSize
                                     lineBreakMode:NSLineBreakByTruncatingTail];
    return expectedSectionSize;
}

-(void)hideProgresshud{
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
}
-(void)loadMainArray{
    [mainArray removeAllObjects];
    if (shouldExpandMap)
    {
        [mainArray addObject:kCellMap];
    }
    else
    {
        [mainArray addObject:kCellImageContainer];
        
        NSArray *offers;
        NSString * detailText;
        if (_isForShop)
        {
            offers = [self.shop.entityActivities allObjects];
            detailText = self.shop.aboutText;
        }
        else if(_isForRestaurent)
        {
            offers = [self.restaurant.entityActivities allObjects];
            detailText = self.restaurant.aboutText;
        }
        else
        {
            detailText = self.mall.aboutText;
        }
        
        if (detailText && ![detailText isEqualToString:@""])
            [mainArray addObject:kCellDetailText];
        
        [mainArray addObject:kCellMap];
        //[mainArray addObject:kCellInfo];
        [mainArray addObject:kCellInfoAddress];
        [mainArray addObject:kCellInfoPhone];
        [mainArray addObject:kCellInfoEmail];
       
        if ((_isForShop && _shop.webURL && ![_shop.webURL isEqualToString:@""])||(_isForRestaurent && _restaurant.webURL && [_restaurant.webURL isEqualToString:@""]) || ( _mall.webURL && ![_mall.webURL isEqualToString:@""]))
            [mainArray addObject:kCellWebsite];
        
        
        [mainArray addObject:kCellOpeningTime];
        
        if (offers.count>0)
            [mainArray addObject:kCellScrollOffers];
    }
    
//    if (mainFeaturedProductArray.count>0)
//    {
//        [mainArray addObject:kCellHeadingPF];
//        for (int i=0; i<mainFeaturedProductArray.count; i++)
//        {
//            [mainArray addObject:kCellFeatureProduct];
//        }
//    }
}
-(void)loadFeaturedProductsArrayWithDummy{
    [mainFeaturedProductArray removeAllObjects];
    
    NSArray * savedObjects=GetArrayWithKey(kArrayEndorsementCreatedLocally);
    for (NSData * item in savedObjects) {
        NSDictionary * dictnry=[NSKeyedUnarchiver unarchiveObjectWithData:item];
        [mainFeaturedProductArray addObject:dictnry];
        if (mainFeaturedProductArray.count==3) {
            break;
        }
    }
}
- (void)loadFeaturedEntities
{
    [[WebManager sharedInstance] getFeaturedEntitiesForShop:_shop.entityId success:^(NSArray *resultArray, NSString *message) {
        [mainFeaturedProductArray addObjectsFromArray:resultArray];
        [self loadMainArray];
        [self.tableView reloadData];
    } failure:^(NSString *errorString) {
        NSLog(@"%@",errorString);
    }];
}
- (void)setUpTimer
{
    if (self.timer) {
        [self.timer invalidate];
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.6
                                                  target:self
                                                selector:@selector(scrollToNextPage)
                                                userInfo:nil
                                                 repeats:YES];
}
- (void)scrollToNextPage
{
    _currentIndex++;
    if (_currentIndex == bannerImages.count)
        _currentIndex = 0;
    
    self.pageControl.currentPage = _currentIndex;
    BannerVC *vcObject = [self viewControllerAtIndex:_currentIndex];
    NSArray *viewControllers  = [[NSMutableArray alloc] initWithArray:[NSArray arrayWithObject:vcObject]];
    [_pagerView setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}
- (void)showEmailComposer
{
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    if ([MFMailComposeViewController canSendMail]) {
        mc.mailComposeDelegate = self;
        NSString *email;
        if(_isForRestaurent)
            email = self.restaurant.email;
        else if (_isForShop)
            email = self.shop.email;
        else
            email = self.mall.email;
        
        [mc setToRecipients:[NSArray arrayWithObject:email]];
        [mc setSubject:[NSString stringWithFormat:@"Town Book App"]];
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
    }
    else{
        ShowMessage(kAppName,NSLocalizedString(@"You can't send email", nil));
    }
}
#pragma mark - PageView Datasource
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(BannerVC *)viewController indexNumber];
    //NSUInteger index = _currentIndex;
    if (index == 0) {
        
        return [self viewControllerAtIndex:bannerImages.count-1];
    }
    index--;
    return [self viewControllerAtIndex:index];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(BannerVC *)viewController indexNumber];
    //NSUInteger index = _currentIndex;
    index++;
    if (index == bannerImages.count) {
        return [self viewControllerAtIndex:0];
    }
    return [self viewControllerAtIndex:index];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [mainArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellTabOptions]) {
//        return 36.0;
//    }
    if([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellImageContainer]){
        return 204.0;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellDetailText]) {
        NSString *aboutText;
        if (_isForShop)
            aboutText = self.shop.aboutText;
        else if (_isForRestaurent)
            aboutText = self.restaurant.aboutText;
        else
            aboutText = self.mall.aboutText;
        
        if (aboutText && ![aboutText isEqualToString:@""])
        {
            CGSize size=[self calculateSizeForText:aboutText];
            CGRect frame=self.detailText.frame;
            frame.size.height=size.height+20;
            self.detailText.frame=frame;
            return size.height+25+48;
        }
        else
        {
            return 0;
        }
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellHeadingPF]) {
        return 21.0;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellScrollOffers]) {
        return 170.0;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellOpeningTime]) {
        if (shopTimings.count<3) {
            return 44.0;
        }
        else{
            return 8+ (shopTimings.count*14)+5;
        }
    }
//    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellShareEntity]) {
//        return 70.0;
//    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellMap]) {
        if (!shouldExpandMap)
            return 171.0;
        else
            return UIScreen.mainScreen.bounds.size.height - 80;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellInfo]) {
        return 147.0;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellWebsite]) {
        return 36.0;
    }
    else
    {
        return 36.0;
    }
//    else//kCellFeatureProduct
//    {
//        return 100.0;//80.0;
//    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellImageContainer]){
//        if (!_isForRestaurent)
//            [self.imgShopLogo setImageWithURL:[NSURL URLWithString:_shop.logoURL] placeholderImage:[UIImage imageNamed:@"place-holder"]];
//        else
//            [self.imgShopLogo setImageWithURL:[NSURL URLWithString:_restaurant.logoURL] placeholderImage:[UIImage imageNamed:@"place-holder"]];
//        if ([offerDictMain valueForKey:kTempObjShopLogoImgName]) {
//            self.imgShopLogo.image=[UIImage imageNamed:[offerDictMain valueForKey:kTempObjShopLogoImgName]];
//        }
        self.cellImageContainer.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellImageContainer;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellDetailText]) {
        //self.detailText.text=[offerDictMain valueForKey:kTempObjDetail];

        if (_isForShop)
            self.detailText.text = self.shop.aboutText;
        else if(_isForRestaurent)
            self.detailText.text = self.restaurant.aboutText;
        else
            self.detailText.text = self.mall.aboutText;
        
        self.cellDetailText.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellDetailText;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellHeadingPF]) {
        self.cellHeadingFP.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellHeadingFP;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellScrollOffers]) {
        self.cellScrollOffers.selectionStyle=UITableViewCellSelectionStyleNone;
        return  self.cellScrollOffers;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellMap]) {
        self.mapCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return self.mapCell;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellInfo]) {
        self.infoCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return self.infoCell;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellOpeningTime]) {
        self.cellOpeningTime.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return self.cellOpeningTime;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellInfoAddress])
    {
        EntityInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EntityInfoCell"];
        if (cell == nil) {
            NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"EntityInfoCell" owner:self options:nil];
            cell=[array objectAtIndex:0];
        }
        cell.infoImageView.image = [UIImage imageNamed:@"services_detail_location.png"];
        if (_isForShop)
            cell.textLbl.text = _shop.address;
        else if(_isForRestaurent)
            cell.textLbl.text = _restaurant.address;
        else
            cell.textLbl.text = _mall.address;
    
        return cell;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellInfoPhone])
    {
        EntityInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EntityInfoCell"];
        if (cell == nil) {
            NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"EntityInfoCell" owner:self options:nil];
            cell=[array objectAtIndex:0];
        }
        cell.infoImageView.image = [UIImage imageNamed:@"call"];
        NSString *phone;
        if (_isForShop)
            phone = _shop.phone;
        else if(_isForRestaurent)
            phone = _restaurant.phone;
        else
            phone = _mall.phone;
        
        if (phone)
            cell.textLbl.text = [self getFormattedPhoneNumber:phone];
        
        return cell;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellInfoEmail])
    {
        EntityInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EntityInfoCell"];
        if (cell == nil) {
            NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"EntityInfoCell" owner:self options:nil];
            cell=[array objectAtIndex:0];
        }
        cell.infoImageView.image = [UIImage imageNamed:@"mailIcon"];
        if (_isForShop)
            cell.textLbl.text = _shop.email;
        else if(_isForRestaurent)
            cell.textLbl.text = _restaurant.email;
        else
            cell.textLbl.text = _mall.email;
        cell.entityInfoBtn.tag = 500;
        [cell.entityInfoBtn addTarget:self action:@selector(showEmailComposer) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellWebsite]) {
        self.websiteCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return self.websiteCell;
    }
//    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellShareEntity]) {
//        self.cellShare.selectionStyle=UITableViewCellSelectionStyleNone;
//        
//        return self.cellShare;
//    }
    else//kCellFeatureProduct
    {
        ShopCell * cell = [tableView dequeueReusableCellWithIdentifier:@"shopCell"];
        if (cell == nil) {
            NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"ShopCell" owner:self options:nil];
            cell=[array objectAtIndex:0];
        }
        id entity;

        if(indexPath.row>=(mainArray.count-mainFeaturedProductArray.count)){
            NSInteger ind=(indexPath.row-(mainArray.count-mainFeaturedProductArray.count));
            entity = [mainFeaturedProductArray objectAtIndex:ind];
        }else{
            NSInteger ind=indexPath.row-1;
            entity = [mainFeaturedProductArray objectAtIndex:ind];
        }
        if ([entity isKindOfClass:[Shop class]]) {
            [cell setShop:entity];
            cell.delegate = self;
        }
        else
        {
            [cell setRestaurant:entity];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
}

        //cell.delegate = self;
        
//        cell.objNameLbl.text=[dict valueForKey:kTempObjTitle];
//        cell.objDetail.text=[dict valueForKey:kTempObjDetail];
////        cell.objDetail.textColor=[UIColor whiteColor];
//        cell.objPlaceLbl.text=[dict valueForKey:kTempObjPlace];
//        cell.objShopLbl.text=[dict valueForKey:kTempObjShop];
//        
//        cell.objImgV.image=[UtilsFunctions imageWithImage:[UIImage imageNamed:[dict valueForKey:kTempObjImgName]] scaledToSize:CGSizeMake(cell.objImgV.frame.size.width*2,cell.objImgV.frame.size.height*2)];
//        cell.tag=[[dict valueForKey:kTempObjID]integerValue];
//        
//        if ([[dict valueForKey:kTempObjIsBookmarked]isEqualToString:@"YES"]) {
//            [cell makeHearPressed:YES];
//        }
//        else{
//            [cell makeHearPressed:NO];
//        }
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row>=(mainArray.count-mainFeaturedProductArray.count)) {
        NewShopDetailVC *shopDetailVC=[[NewShopDetailVC alloc]initWithOfferCreatedLocally:nil ANDCenterName:centerName];
        shopDetailVC.isForRestaurent=_isForRestaurent;
        shopDetailVC.shop = [mainFeaturedProductArray objectAtIndex:indexPath.row-(mainArray.count-mainFeaturedProductArray.count)];
        [self.navigationController pushViewController:shopDetailVC animated:YES];
    }
    return;
}

#pragma mark - KIImagePager DataSource
- (NSArray *) arrayWithImages
{
    return [NSArray arrayWithArray:bannerImages];
}
- (UIImage *) placeHolderImageForImagePager
{
    return [UIImage imageNamed:@"place-holder"];
}
- (UIViewContentMode) contentModeForImage:(NSUInteger)image
{
    return UIViewContentModeScaleToFill;
}

- (NSString *) captionForImageAtIndex:(NSUInteger)index
{
    return nil;
}

#pragma mark - KIImagePager Delegate
- (void) imagePager:(KIImagePager *)imagePager didScrollToIndex:(NSUInteger)index
{
    //    NSLog(@"%s %lu", __PRETTY_FUNCTION__, (unsigned long)index);
    self.pageControl.currentPage=index;
}

- (void) imagePager:(KIImagePager *)imagePager didSelectImageAtIndex:(NSUInteger)index
{
    //    NSLog(@"%s %lu", __PRETTY_FUNCTION__, (unsigned long)index);
}

#pragma mark - APParallaxViewDelegate

- (void)parallaxView:(APParallaxView *)view willChangeFrame:(CGRect)frame {
    // Do whatever you need to do to the parallaxView or your subview before its frame changes
//    NSLog(@"parallaxView:willChangeFrame: %@", NSStringFromCGRect(frame));
}

- (void)parallaxView:(APParallaxView *)view didChangeFrame:(CGRect)frame {
    // Do whatever you need to do to the parallaxView or your subview after its frame changed
//    NSLog(@"parallaxView:didChangeFrame: %@", NSStringFromCGRect(frame));
}
#pragma mark:Mapkit
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    //    if (annotation == mapView.userLocation)
    //        return nil;
    
    static NSString *MyPinAnnotationIdentifier = @"Pin";
    MKPinAnnotationView *pinView =
    (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:MyPinAnnotationIdentifier];
    if (!pinView){
        MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                                        reuseIdentifier:MyPinAnnotationIdentifier];
        
        annotationView.image = [UIImage imageNamed:@"map"];
        
        return annotationView;
        
    }else{
        
        pinView.image = [UIImage imageNamed:@"map"];//pin_map_blue
        
        return pinView;
    }
    
    return nil;
}

#pragma mark: SGShareView
-(NSString*) createShareString
{
    NSString *title;
    NSString *messageBody;
    if (_isForRestaurent)
    {
        title = self.restaurant.name;
        messageBody = self.restaurant.briefText;
    }
    else
    {
        title = self.shop.name;
        messageBody = self.shop.briefText;
    }
    NSString * message = [NSString stringWithFormat:@"Town Book App: %@: %@",title,messageBody];
    return message;
}

//-(void)showSGShareView{
//    [SGActionView sharedActionView].style=SGActionViewStyleDark;
//    SGMenuActionHandler handler=^(NSInteger index){
//        NSLog(@"selected index= %li",(long)index);
//        [self.btnShare setSelected:NO];
//        switch (index) {
//            case 1:
//                [self shareTheShopOnFacebook];
//                break;
//            case 2:
//                [self shareTheShopOnTwitter];
//                break;
//            case 3:
//                [self shareTheShopOnSMS];
//                break;
//            case 4:
//                [self shareTheShopOnEmail];
//                break;
//                
//            default:
//                break;
//        }
//    };
//    NSString * shareTitle = _isForRestaurent ? @"Share Restaurant":@"Share Shop";
//    [SGActionView showGridMenuWithTitle:shareTitle
//                             itemTitles:@[ @"Facebook", @"Twitter", @"SMS", @"Email"]
//                                 images:@[ [UIImage imageNamed:@"share-facebook-button"],
//                                           [UIImage imageNamed:@"share-twitter-button"],
//                                           [UIImage imageNamed:@"share-sms-button"],
//                                           [UIImage imageNamed:@"share-email-button"]]
//                         selectedHandle:handler];
//}

-(void)shareTheShopOnFacebook{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *fbPostSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [fbPostSheet addImage:[[SDWebImageManager sharedManager] imageWithURL:url]];
        [fbPostSheet setInitialText:[self createShareString]];
        [self presentViewController:fbPostSheet animated:YES completion:nil];
    } else
    {
        ShowMessage(kAppName,NSLocalizedString(@"You can't post right now, make sure your device has an internet connection and you have at least one facebook account setup", nil));
    }
}
-(void)shareTheShopOnTwitter{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet addImage:[[SDWebImageManager sharedManager] imageWithURL:url]];
        [tweetSheet setInitialText:[self createShareString]];
        [self presentViewController:tweetSheet animated:YES completion:nil];
        
    }
    else
    {
        ShowMessage(kAppName,NSLocalizedString(@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup", nil));
    }
}
-(void)shareTheShopOnSMS{
    MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc] init];
    if ([MFMessageComposeViewController canSendText]) {
        
        NSString *smsString = [self createShareString];
        messageVC.body = smsString;
        
        messageVC.messageComposeDelegate = self;
        [self presentViewController:messageVC animated:YES completion:nil];
    }
    else{
        ShowMessage(kAppName,NSLocalizedString(@"Your device doesn't support SMS!", nil));
    }
}
-(void)shareTheShopOnEmail{
    // Email Subject
    NSString *emailTitle ;
    // Email Content
    NSString *messageBody ;
    if (_isForRestaurent)
    {
        emailTitle = self.restaurant.name;
        messageBody = self.restaurant.briefText;
    }
    else
    {
        emailTitle = self.shop.name;
        messageBody = self.shop.briefText;
    }
    // To address
    //    NSArray *toRecipents = [NSArray arrayWithObject:@"support@appcoda.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    if ([MFMailComposeViewController canSendMail]) {
        mc.mailComposeDelegate = self;
        [mc setSubject:[NSString stringWithFormat:@"Town Book App: %@",emailTitle]];
        [mc setMessageBody:messageBody isHTML:NO];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
    }
    else{
        ShowMessage(kAppName,NSLocalizedString(@"You can't send email", nil));
    }
}
#pragma mark - MFMessageComposeViewControllerDelegate methods
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            ShowMessage(kAppName,NSLocalizedString(@"Failed to send SMS!", nil));
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - MFMailComposeViewControllerDelegate methods
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}
#pragma mark-ShopOfferViewDelegate
- (void)shopOfferHasBeenTappedWithOffer:(Offer *)offer
{
//    NSDictionary * dict=[mainFeaturedProductArray objectAtIndex:1];
//    OfferDetailVC *offerVC=[[OfferDetailVC alloc]initWithOfferCreatedLocally:dict ANDCenterName:centerName];
    OfferDetailVC *offerVC = [[OfferDetailVC alloc] init];
    offerVC.activityObject = offer;
    offerVC.isFromEntity = YES;
    [self.navigationController pushViewController:offerVC animated:YES];
}
#pragma mark- ShopCellDelegate
- (void)shopCellBookmarkButtonPressedWithOption:(BOOL)isBM forShop:(Shop *)shop
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    User * user = [[DataManager sharedInstance] currentUser];
    if(isBM)
    {
        [[WebManager sharedInstance] markEntity:shop.entityId isShop:YES
                               favouriteDeleted:NO success:^(id response) {
                                   [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                   if (response!= nil)
                                   {
                                       [user addFavouriteShopsObject:shop];
                                       [[DataManager sharedInstance] saveContext];
                                       ShowMessage(kAppName, NSLocalizedString(@"This shop added to your favourities", nil));
                                   }
                               } failure:^(NSString *errorString) {
                                   [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                   ShowMessage(kAppName,errorString);
                               }];
    }
    else
    {
        [[WebManager sharedInstance] markEntity:shop.entityId isShop:YES
                               favouriteDeleted:YES success:^(id response) {
                                   [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                   if (response!= nil)
                                   {
                                       [user removeFavouriteShopsObject:shop];
                                       [[DataManager sharedInstance] saveContext];
                                       ShowMessage(kAppName, NSLocalizedString(@"This shop removed from your favourities", nil));
                                   }
                               } failure:^(NSString *errorString) {
                                   [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                   ShowMessage(kAppName,errorString);
                               }];
    }
}

#pragma mark-UIScrolViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag == 0)
    {
        CGPoint point=scrollView.contentOffset;
        if (point.x==0) {
            [self.imgBackwardArrow setHidden:YES];
        }
        else{
            [self.imgBackwardArrow setHidden:NO];
        }
        if (point.x==self.offerScrollView.contentSize.width-self.offerScrollView.frame.size.width || _offers.count<3) {
            [self.imgForwardArrow setHidden:YES];
        }
        else{
            [self.imgForwardArrow setHidden:NO];
        }
    }
}
#pragma mark:IBActions and Selectors
- (IBAction)leftMenuBtnTapped:(id)sender {
    [appDelegate popHomeOverViewPageWithClosedMenu];
}

//-(void)leftNavBarBtnPressed:(id)sender{
//    [self.navigationController popViewControllerAnimated:YES];
//}
//-(void)rightNavBarBtnPressed:(id)sender{
//    isBookMarked=!isBookMarked;
//    NSString * imgName;
//    if (isBookMarked) {
//        imgName=@"heart_large_p";
//    }
//    else{
//        imgName=@"heart_large";
//    }
//    rightItem.image=[[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//}
-(void)mapHasBeenTapped:(id)sender{
    UIActionSheet * actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Apple Maps",@"Google Maps", nil];
    [actionSheet showInView:self.view];
}

- (IBAction)btnOpeningPressed:(id)sender {
    [self.btnOpeningTime setSelected:!self.btnOpeningTime.selected];
    [self.btnDirection setSelected:NO];
    [self.btnShare setSelected:NO];
    [self loadMainArray];
    [self.tableView reloadData];
}
- (IBAction)btnDirectionPressed:(id)sender {
    [self.btnOpeningTime setSelected:NO];
    [self.btnDirection setSelected:!self.btnDirection.selected];
    EntityMapAddressVC *entityMapVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"EntityMapVC"];
    if (!_isForRestaurent)
    {
        entityMapVC.shop = self.shop;
    }
    else
    {
        entityMapVC.restaurant = self.restaurant;
        entityMapVC.isForRestaurent = YES;
    }
    [self.navigationController pushViewController:entityMapVC animated:YES];
    [self.btnShare setSelected:NO];
}
- (IBAction)btnSharePressed:(id)sender {
    //[self showSGShareView];
    [self.btnOpeningTime setSelected:NO];
    [self.btnDirection setSelected:NO];
    [self.btnShare setSelected:!self.btnShare.selected];
    [self loadMainArray];
    [self.tableView reloadData];
}

- (IBAction)btnMenuPressed:(id)sender {
    if (self.restaurant.menuCategories.count == 0)
    {
        ShowMessage(kAppName,NSLocalizedString(@"No menu available for this restaurant", nil));
    }
    else
    {
        RestaurantMenuVC * restMenuVC =[ [RestaurantMenuVC alloc] init];
        restMenuVC.restaurant = _restaurant;
        [self.navigationController pushViewController:restMenuVC animated:YES];
    }
}

- (IBAction)backBtnPressed:(id)sender {
    if (!self.isForShop && !self.isForRestaurent)
    {
        if(isSlided){
            [appDelegate showHideSlideMenue:YES withCenterName:nil];
            isSlided=NO;
        }
        else{
            [appDelegate showHideSlideMenue:YES withCenterName:nil];
            isSlided=YES;
        }
    }
    else
    {
        [self.backBtn setSelected:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)bookmarkBtnPressed:(id)sender {
    [self.btnBookmark setSelected:!self.btnBookmark.selected];
    isBookMarked=!isBookMarked;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    User * user = [[DataManager sharedInstance] currentUser];
    if (!_isForRestaurent)
    {
        if(self.btnBookmark.selected)
        {
            [[WebManager sharedInstance] markEntity:self.shop.entityId isShop:YES
                                   favouriteDeleted:NO success:^(id response) {
                                       [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                       if (response!= nil)
                                       {
                                           [user addFavouriteShopsObject:self.shop];
                                           [[DataManager sharedInstance] saveContext];
                                           ShowMessage(kAppName, NSLocalizedString(@"This shop added to your favourities", nil));
                                       }
                                   } failure:^(NSString *errorString) {
                                       [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                       ShowMessage(kAppName,errorString);
                                   }];
        }
        else
        {
            [[WebManager sharedInstance] markEntity:self.shop.entityId isShop:YES
                                   favouriteDeleted:YES success:^(id response) {
                                       [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                       if (response!= nil)
                                       {
                                           [user removeFavouriteShopsObject:self.shop];
                                           [[DataManager sharedInstance] saveContext];
                                           ShowMessage(kAppName, NSLocalizedString(@"This shop removed from your favourities", nil));
                                       }
                                   } failure:^(NSString *errorString) {
                                       [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                       ShowMessage(kAppName,errorString);
                                   }];
        }
    }
    else
    {
        if(self.btnBookmark.selected)
        {
            [[WebManager sharedInstance] markEntity:self.restaurant.entityId isShop:NO
                                   favouriteDeleted:NO success:^(id response) {
                                       [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                       if (response!= nil)
                                       {
                                           [user addFavouriteRestaurantsObject:self.restaurant];
                                           [[DataManager sharedInstance] saveContext];
                                           ShowMessage(kAppName, NSLocalizedString(@"This restaurant added to your favourities", nil));
                                       }
                                   } failure:^(NSString *errorString) {
                                       [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                       ShowMessage(kAppName,errorString);
                                   }];
        }
        else
        {
            [[WebManager sharedInstance] markEntity:self.restaurant.entityId isShop:NO
                                   favouriteDeleted:YES success:^(id response) {
                                       [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                       if (response!= nil)
                                       {
                                           [user removeFavouriteRestaurantsObject:self.restaurant];
                                           [[DataManager sharedInstance] saveContext];
                                           ShowMessage(kAppName, NSLocalizedString(@"This restaurant removed from your favourities", nil));
                                       }
                                   } failure:^(NSString *errorString) {
                                       [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                       ShowMessage(kAppName,errorString);
                                   }];
        }
    }
}

- (IBAction)websiteBtnTapped:(id)sender {

    NSString *urlString ;
    if (_isForShop)
        urlString = _shop.webURL;
    else if(_isForRestaurent)
        urlString = _restaurant.webURL;
    else
        urlString = _mall.webURL;

    WebVC * webVC=[[WebVC alloc]initWithUrl:urlString];
    [self.navigationController pushViewController:webVC animated:YES];
}
- (IBAction)mapExpandBtnTapped:(id)sender {
    shouldExpandMap = YES;
    [self loadMainArray];
    [UIView transitionWithView: self.tableView duration: 0.7f options: UIViewAnimationOptionTransitionCrossDissolve animations: ^(void)
     {
         self.expandBtn.hidden = YES;
         [self.tableView reloadData];
     }completion:^(BOOL finished){
         self.shrinkBtn.hidden = NO;
    }];

    //[self.tableView reloadData];
}
- (IBAction)mapShrinkBtnTapped:(id)sender {
    shouldExpandMap = NO;
    [self loadMainArray];
    [UIView transitionWithView: self.tableView duration:0.4f options: UIViewAnimationOptionTransitionCrossDissolve animations: ^(void)
     {
         self.shrinkBtn.hidden = YES;
         
         [self.tableView reloadData];
     }completion:^(BOOL finished){
         self.expandBtn.hidden = NO;
    }];
}

#pragma mark-Sharing IBActions
- (IBAction)facebookTapped:(id)sender {
    [self shareTheShopOnFacebook];
    
}
- (IBAction)twitterTapped:(id)sender {
    [self shareTheShopOnTwitter];
}
- (IBAction)smsTapped:(id)sender {
    [self shareTheShopOnSMS];
}
- (IBAction)emailTapped:(id)sender {
    [self shareTheShopOnEmail];
}

@end
