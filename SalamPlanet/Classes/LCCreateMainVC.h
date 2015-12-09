//
//  LCCreateMainVC.h
//  SalamCenterApp
//
//  Created by Globit on 08/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCObject.h"
#import "LCCreateVC.h"

@protocol LCCreateMainVCDelegate
-(void)newMainLCObjectHasBeenCreated:(LCObject *)obj;
@end

@interface LCCreateMainVC : UIViewController<LCCreateVCDelegate>
@property (weak, nonatomic) id<LCCreateMainVCDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *bgImgV;
@property (strong, nonatomic) IBOutlet UILabel *lblPageTitle;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellAddCard;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UILabel *lblAddOtherCard;
@property (strong, nonatomic) IBOutlet UILabel *lblIfYouCantFindItHere;

- (IBAction)backBtnPressed:(id)sender;

@end
