//
//  EndrViewPageVC.h
//  TGFoursquareLocationDetail-Demo
//
//  Created by Thibault Guégan on 15/12/2013.
//  Copyright (c) 2013 Thibault Guégan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "TGFoursquareLocationDetail.h"
#import "EDetailActionCell.h"
#import "AddressLocationCell.h"
#import "TGAnnotation.h"
#import "EndorsementViewCell.h"
#import "EndrCommentsViewController.h"
#import "DemoChatViewController.h"
#import "ShowMapVC.h"
#import "SocialSahreVC.h"
#import "WebVC.h"
#import "RatingDetailView.h"
#import "UserProfileVC.h"
#import "EShareView.h"
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>

@interface EndrViewPageVC : UIViewController <UITableViewDataSource,UITableViewDelegate,MKMapViewDelegate,TGFoursquareLocationDetailDelegate,EDetailActionCellDelegate,EndorsementCellDelegate,UIGestureRecognizerDelegate,AddressLocationCellDelegate,UIActionSheetDelegate,EShareViewDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) TGFoursquareLocationDetail *locationDetail;
@property (nonatomic, strong) MKMapView *map;

@property (weak, nonatomic) IBOutlet UIView *headerBGView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIImageView *moonImgOne;
@property (weak, nonatomic) IBOutlet UIImageView *moonImgTwo;
@property (weak, nonatomic) IBOutlet UIImageView *moonImgThree;
@property (weak, nonatomic) IBOutlet UIImageView *moonImgFour;
@property (weak, nonatomic) IBOutlet UIImageView *moonImgFive;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellOverallRatingInfo;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellRatingDetail;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellShowShareView;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellOfferDetailText;
@property (weak, nonatomic) IBOutlet UILabel *headingTitle;
@property (weak, nonatomic) IBOutlet UITextView *detailText;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@property (weak, nonatomic) IBOutlet UILabel *endrTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *catSubCatLbl;
@property (weak, nonatomic) IBOutlet UILabel *tagLbl;

- (IBAction)backBtnAction:(id)sender;
-(id)initWithEndorsementCreatedLocally:(NSDictionary *)edoreDict;
@end
