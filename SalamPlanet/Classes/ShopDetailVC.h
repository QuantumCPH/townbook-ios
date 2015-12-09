//
//  ShopDetailVC.h
//  SalamCenterApp
//
//  Created by Globit on 01/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "TGAnnotation.h"
#import "ShowMapVC.h"
#import "AddressLocationCell.h"
#import "WebVC.h"

@interface ShopDetailVC : UIViewController<AddressLocationCellDelegate,UIGestureRecognizerDelegate,UIActionSheetDelegate,MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *bgImgV;
@property (nonatomic, strong) MKMapView *map;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellTopContainer;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellCenterContainer;
@property (weak, nonatomic) IBOutlet UITextView *shopTagTextV;
@property (weak, nonatomic) IBOutlet UIImageView *shopImgV;
@property (weak, nonatomic) IBOutlet UILabel *shopDetailTitle;
@property (weak, nonatomic) IBOutlet UITextView *shopDetailTV;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;


- (IBAction)goBackAction:(id)sender;
@end
