//
//  BarcodeTypesVC.h
//  SalamCenterApp
//
//  Created by Globit on 19/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BarcodeType.h"

@protocol BarcodeTypesVCDelegate
-(void)barcodeHasBeenSelected:(BarcodeType *)obj;
@end

@interface BarcodeTypesVC : UIViewController
@property (weak, nonatomic) id<BarcodeTypesVCDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UILabel *lblPageTitle;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)backBtnPressed:(id)sender;
@end
