//
//  LCardVC.h
//  SalamCenterApp
//
//  Created by Globit on 12/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCObject.h"
#import "LCCreateVC.h"

@interface LCardVC : UIViewController<LCCreateVCDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *bgImgV;
@property (strong, nonatomic) IBOutlet UILabel *lblPageTitle;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellTopCardName;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellCardImages;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellCardDataEntry;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellCardDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblCardNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblCardTitleValue;
@property (weak, nonatomic) IBOutlet UITextView *cardDescriptionTF;
@property (weak, nonatomic) IBOutlet UILabel *lblBarCode;
@property (weak, nonatomic) IBOutlet UIImageView *barcodeImgView;
@property (weak, nonatomic) IBOutlet UILabel *lblCardNumberValue;
@property (weak, nonatomic) IBOutlet UILabel *lblBarcodeNumberValue;
@property (weak, nonatomic) IBOutlet UIImageView *imgVFront;
@property (weak, nonatomic) IBOutlet UIImageView *imgVBack;
@property (strong, nonatomic)LCObject * mainLCObj;
@property (weak, nonatomic) IBOutlet UIScrollView *cardImageScrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *cardImageCollectionView;

@property (weak, nonatomic) IBOutlet UIPageControl *cardImagePager;
@property (strong, nonatomic) IBOutlet UILabel *lblFront;
@property (strong, nonatomic) IBOutlet UILabel *lblBack;

- (IBAction)backBtnPressed:(id)sender;
- (IBAction)editBtnPressed:(id)sender;

-(id)initWithLCObject:(LCObject*)lcObject;

@end
