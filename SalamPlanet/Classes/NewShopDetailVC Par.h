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
#import "EShareView.h"
#import "ShowMapVC.h"
#import "ShowGoogleMapVC.h"
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>
#import "CenterBannerCell.h"
#import "EDetailActionCell.h"
#import "AddressLocationCell.h"
#import <MapKit/MapKit.h>
#import "WebVC.h"
#import "TGAnnotation.h"

@interface NewShopDetailVC : UITableViewController<APParallaxViewDelegate,EShareViewDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate,UINavigationControllerDelegate,EDetailActionCellDelegate,AddressLocationCellDelegate,UIGestureRecognizerDelegate,MKMapViewDelegate,UIActionSheetDelegate>
@property (nonatomic, strong) MKMapView *map;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellShareView;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellHeadingFP;
@property (weak, nonatomic) IBOutlet UITextView *detailText;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellDetailText;

-(id)initWithOfferCreatedLocally:(NSDictionary *)offerDict ANDCenterName:(NSString*)centername;
@end
