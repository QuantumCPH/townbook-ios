//
//  ShopsVC.h
//  SalamCenterApp
//
//  Created by Globit on 29/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ShopCell.h"
//#import "CenterBannerCell.h"
#import "MJNIndexView.h"
#import "ShopCell.h"

@protocol ShopsVCDelegate
-(void)shopIsSelectedForChat:(NSDictionary *)sDict;
@end

@interface ShopsVC : UIViewController<MJNIndexViewDataSource,ShopCellDelegate>

@property (weak, nonatomic) id <ShopsVCDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *bgImgV;
@property (strong, nonatomic) IBOutlet UILabel *lblPageTitle;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentBar;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) MJNIndexView *indexView;// MJNIndexView
@property (nonatomic) BOOL isFromChat;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

- (IBAction)backBtnPressed:(id)sender;
- (IBAction)segmentBarValueChanged:(id)sender;
@end
