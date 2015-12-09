//
//  NewShopDetailVC.h
//  SalamPlanet
//
//  Created by Globit on 12/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+APParallaxHeader.h"
#import "FBLogin.h"
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>
#import "CenterBannerCell.h"
#import "EDetailActionCell.h"
#import <MapKit/MapKit.h>
#import "WebVC.h"
#import "TGAnnotation.h"
#import "KIImagePager.h"
#import "DMCircularScrollView.h"
#import "ShopOfferView.h"
#import "Shop.h"
#import "Restaurant.h"
#import "ShopCell.h"

@interface NewShopDetailVC : UIViewController<APParallaxViewDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate,UIActionSheetDelegate,UIScrollViewDelegate,UITableViewDelegate,ShopOfferViewDelegate,ShopCellDelegate,UIPageViewControllerDataSource,UIPageViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *lblPageTitle;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellImageContainer;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellShareView;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellHeadingFP;
@property (weak, nonatomic) IBOutlet UITextView *detailText;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellDetailText;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellShare;

@property (weak, nonatomic) IBOutlet UIButton *btnShare;
@property (weak, nonatomic) IBOutlet UIButton *btnOpeningTime;
@property (weak, nonatomic) IBOutlet UIButton *btnDirection;
@property (weak, nonatomic) IBOutlet UIButton *btnMenu;
@property (weak, nonatomic) IBOutlet UIButton *btnHomeMenu;

@property (weak, nonatomic) IBOutlet UIView *imgContainerView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIImageView *mapImageView;
@property (weak, nonatomic) IBOutlet UIView *mapContainerView;

@property (weak, nonatomic) IBOutlet UIScrollView *mapImageScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *bannerBottomImgView;

@property (strong, nonatomic) IBOutlet UITableViewCell *mapCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *infoCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *websiteCell;


@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UIScrollView *offerScrollView;
@property (weak, nonatomic) IBOutlet UILabel *lblShopOfferTitle;
@property (weak, nonatomic) IBOutlet UIButton *imgForwardArrow;
@property (weak, nonatomic) IBOutlet UIButton *imgBackwardArrow;
@property (weak, nonatomic) IBOutlet UILabel *lblRelatedShopsHeading;

@property (weak, nonatomic) IBOutlet UILabel *addressLbl;
@property (weak, nonatomic) IBOutlet UILabel *phoneLbl;
@property (weak, nonatomic) IBOutlet UILabel *mailLbl;


@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *expandBtn;
@property (weak, nonatomic) IBOutlet UIButton *shrinkBtn;

@property (strong, nonatomic) Shop * shop;
@property (strong,nonatomic) Restaurant* restaurant;
@property (strong,nonatomic) MallCenter* mall;
@property (nonatomic)BOOL isForRestaurent;
@property (nonatomic)BOOL isForShop;
@property (strong, nonatomic) NSArray *offers;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *locationBtnWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timingBtnLeftPadding;

@property (weak, nonatomic) IBOutlet UILabel *weekDayTimingLbl;
@property (weak, nonatomic) IBOutlet UILabel *weekEndTimmingLbl;
@property (weak, nonatomic) IBOutlet UILabel *weekdayLbl;
@property (weak, nonatomic) IBOutlet UILabel *weekdayLbl2;


@property (strong, nonatomic) IBOutlet UITableViewCell *cellTopTabBar;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellScrollOffers;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellOpeningTime;
@property (weak, nonatomic) IBOutlet UIButton *btnBookmark;
@property (weak, nonatomic) IBOutlet UIButton *websiteBtn;

- (IBAction)btnOpeningPressed:(id)sender;
- (IBAction)btnDirectionPressed:(id)sender;
- (IBAction)btnSharePressed:(id)sender;
- (IBAction)btnMenuPressed:(id)sender;
- (IBAction)backBtnPressed:(id)sender;
- (IBAction)bookmarkBtnPressed:(id)sender;
- (IBAction)websiteBtnTapped:(id)sender;

-(id)initWithOfferCreatedLocally:(NSDictionary *)offerDict ANDCenterName:(NSString*)centername;
@end
