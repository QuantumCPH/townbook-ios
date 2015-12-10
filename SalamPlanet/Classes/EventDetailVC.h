//
//  EventDetailVC.h
//  SalamCenterApp
//
//  Created by Globit on 10/12/2015.
//  Copyright © 2015 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventItem.h"
#import <MapKit/MapKit.h>

@interface EventDetailVC : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellTop;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellActionBar;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellDetail;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellMap;

@property (strong, nonatomic) IBOutlet UILabel *lblUserName;
@property (strong, nonatomic) IBOutlet UILabel *lblPlace;
@property (strong, nonatomic) IBOutlet UILabel *lblDateHappen;
@property (strong, nonatomic) IBOutlet UILabel *lblDateCreated;
@property (strong, nonatomic) IBOutlet UIButton *btnRequest;
@property (strong, nonatomic) IBOutlet UIButton *btnComment;
@property (strong, nonatomic) IBOutlet UIButton *btnShare;
@property (strong, nonatomic) IBOutlet UILabel *lblEventTitle;
@property (strong, nonatomic) IBOutlet UIImageView *imgEvent;
@property (strong, nonatomic) IBOutlet UIImageView *imgUser;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)btnBackPressed:(id)sender;
-(id)initWithEvent:(EventItem*)item;
@end
