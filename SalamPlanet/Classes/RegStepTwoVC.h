//
//  RegStepTwoVC.h
//  SalamCenterApp
//
//  Created by Globit on 02/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InterestCell.h"

@interface RegStepTwoVC : UIViewController<InterestCellDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *bgImgV;
@property (strong, nonatomic) IBOutlet UILabel *lblPageTitle;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *seleactAllBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UILabel *lblSelectAll;
@property (strong, nonatomic) IBOutlet UIButton *btnContinue;
@property (nonatomic)BOOL isFromEdit;

- (IBAction)backBtnAction:(id)sender;
- (IBAction)doneBtnAction:(id)sender;
- (IBAction)selectAllAction:(id)sender;
@end
