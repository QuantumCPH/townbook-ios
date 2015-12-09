//
//  TransportHelpVC.h
//  SalamCenterApp
//
//  Created by Globit on 28/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransportInfoCell.h"
#import "RTLabel.h"

@interface TransportHelpVC : UIViewController<RTLabelDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *bgImgV;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

- (IBAction)btnBackPressed:(id)sender;
@end
