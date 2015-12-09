//
//  ParkingHelpVC.h
//  SalamCenterApp
//
//  Created by Globit on 27/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParkingHelpVC : UIViewController<UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *bgImgV;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellOne;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellTwo;
@property (weak, nonatomic) IBOutlet UILabel *lblTopCellTwo;
@property (weak, nonatomic) IBOutlet UIButton *btnAddPicture;
@property (weak, nonatomic) IBOutlet UIImageView *imgVPicture;
@property (weak, nonatomic) IBOutlet UITextView *detailTF;
@property (weak, nonatomic) IBOutlet UILabel *lblTopCellOne;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *popOverImgV;
@property (weak, nonatomic) IBOutlet UIButton *BtnPopOver;
@property (strong, nonatomic) IBOutlet UIView *viewPopOver;
@property (weak, nonatomic) IBOutlet UIButton *btnGetDirections;

- (IBAction)btnAddPicturePressed:(id)sender;
- (IBAction)btnBackPressed:(id)sender;
- (IBAction)btnPopOverPressed:(id)sender;
- (IBAction)btnGetDirectionsPressed:(id)sender;

-(id)initWithParkingDescription:(NSString *)desc ANDParkingPicture:(UIImage *)img ANDParkLocation:(CLLocationCoordinate2D)loc;
@end
