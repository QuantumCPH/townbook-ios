//
//  RewardsHomeVC.h
//  SalamCenterApp
//
//  Created by Globit on 16/02/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopOfferView.h"
#import "OfferDetailVC.h"

@interface RewardsHomeVC : UIViewController<ShopOfferViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *bgImgV;
@property (strong, nonatomic) IBOutlet UILabel *lblPageTitle;
@property (weak, nonatomic) IBOutlet UIScrollView *offerScrollView;
@property (weak, nonatomic) IBOutlet UIButton *imgForwardArrow;
@property (weak, nonatomic) IBOutlet UIButton *imgBackwardArrow;
@property (weak, nonatomic) IBOutlet UILabel *lblShopOfferTitle;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellScrollOffers;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellInfo;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellGotoHistory;
@property (strong, nonatomic) IBOutlet UILabel *lblTransactionHistory;
@property (strong, nonatomic) IBOutlet UILabel *lblPoints;
@property (strong, nonatomic) IBOutlet UILabel *lblCardNumber;
@property (strong, nonatomic) IBOutlet UILabel *lblMembershipNumber;
@property (strong, nonatomic) IBOutlet UITextField *cardNumberValeTF;
@property (strong, nonatomic) IBOutlet UITextField *membershipNumberValeTF;
@property (strong, nonatomic) IBOutlet UITextField *pointsValueTF;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *popOverView;
@property (strong, nonatomic) IBOutlet UITextField *popOverCardNumberValeTF;
@property (strong, nonatomic) IBOutlet UITextField *popOverMembershipNumberValeTF;
@property (strong, nonatomic) IBOutlet UILabel *lblPopOverTitle;
@property (strong, nonatomic) IBOutlet UIButton *btnClosePopOver;
@property (strong, nonatomic) IBOutlet UILabel *lblPopOverMembershipNumber;
@property (strong, nonatomic) IBOutlet UILabel *lblPopOverCardNumber;
@property (strong, nonatomic) IBOutlet UILabel *lblFeaturedProducts;


- (IBAction)btnClosePopOverPressed:(id)sender;
- (IBAction)gotoDBDemo:(id)sender;

@end
