//
//  RegStepOneVC.h
//  SalamCenterApp
//
//  Created by Globit on 02/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCenterCell.h"
#import "RegStepTwoVC.h"

@interface RegStepOneVC : UIViewController<SCenterCellDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *bgImgV;
@property (strong, nonatomic) IBOutlet UILabel *lblPageTitle;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentBar;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (nonatomic)BOOL isFromEdit;

- (IBAction)btnNextPressed:(id)sender;
- (IBAction)segmentedControlChanged:(id)sender;
@end
