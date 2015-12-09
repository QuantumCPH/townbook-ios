//
//  OfferDetailVC.h
//  SalamCenterApp
//
//  Created by Globit on 04/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EShareView.h"
#import "CenterBannerCell.h"
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>
//#import "KIImagePager.h"
#import "CenterObject.h"

@interface OfferDetailVC : UIViewController<MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate,UINavigationControllerDelegate,UIPageViewControllerDataSource,UIPageViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *bgImgV;
@property (strong, nonatomic) IBOutlet UILabel *lblPageTitle;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellImageContainer;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellOfferTitleHeadline;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellHeaderFeaturedProducts;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellOfferDetailText;
@property (weak, nonatomic) IBOutlet UIButton *shareOfferBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UITextView *offerDetailTV;
@property (weak, nonatomic) IBOutlet UIButton *shopNameBtn;
@property (weak, nonatomic) IBOutlet UIButton *heartBtn;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *lblRelatedOffers;
@property (weak, nonatomic) IBOutlet UILabel *lblDetailHeading;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UILabel *lblGoToShop;
@property (strong, nonatomic) IBOutlet UILabel *lblSharePoints;
@property (strong, nonatomic) id activityObject;
@property (strong, nonatomic) NSString *activityId;
@property (nonatomic,assign) BOOL isOffer;
@property (nonatomic,assign) BOOL isFromEntity;
@property (weak, nonatomic) IBOutlet UILabel *lblShare;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UIView *bannerContainer;
@property (nonatomic, strong) UIPageViewController *pagerView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSUInteger currentIndex;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailTextHeightConstraint;

- (IBAction)shareBtnAction:(id)sender;
- (IBAction)backBtnAction:(id)sender;
- (IBAction)heartBtnPressed:(id)sender;
- (IBAction)shopBtnPressed:(id)sender;

-(id)initWithOfferCreatedLocally:(NSDictionary *)offerDict ANDCenterName:(NSString*)centerName;
@end
