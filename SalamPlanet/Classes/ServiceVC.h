//
//  ServiceVC.h
//  SalamCenterApp
//
//  Created by Globit on 29/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceCell.h"
#import "ServiceDetailCell.h"
#import "MJNIndexView.h"

@interface ServiceVC : UIViewController<MJNIndexViewDataSource,ServiceDetailCellDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *bgImgV;
@property (strong, nonatomic) IBOutlet UILabel *lblPageTitle;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (nonatomic, strong) MJNIndexView *indexView;// MJNIndexView

@property (strong, nonatomic) NSIndexPath *indexPathSelected;

- (IBAction)backBtnPressed:(id)sender;
@end
