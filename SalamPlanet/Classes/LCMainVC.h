//
//  LCMainVC.h
//  SalamCenterApp
//
//  Created by Globit on 08/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCCreateMainVC.h"
#import "LCMainCollectionCell.h"

@interface LCMainVC : UIViewController<LCCreateMainVCDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *bgImgV;
@property (strong, nonatomic) IBOutlet UILabel *lblPageTitle;
//@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *btnCreate;
@property (strong, nonatomic) IBOutlet UIView *searchBarView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

- (IBAction)createBtnPressed:(id)sender;
@end
