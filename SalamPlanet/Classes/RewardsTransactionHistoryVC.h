//
//  RewardsTransactionHistoryVC.h
//  SalamCenterApp
//
//  Created by Globit on 17/02/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RewardsTransCell.h"

@interface RewardsTransactionHistoryVC : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *bgImgV;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *lblPageTitle;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

- (IBAction)btnBackPressed:(id)sender;
@end
