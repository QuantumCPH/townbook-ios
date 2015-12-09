//
//  BookmarkVC.h
//  SalamCenterApp
//
//  Created by Globit on 09/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookmarkVC : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *bgImgV;
@property (strong, nonatomic) IBOutlet UILabel *lblPageTitle;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentBar;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UIView *searchBarView;
@property (nonatomic) BOOL isFromChat;

- (IBAction)backBtnPressed:(id)sender;
- (IBAction)segmentBarValueChanged:(id)sender;

@end
