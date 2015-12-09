//
//  CalculateDiscountVC.h
//  SalamCenterApp
//
//  Created by Globit on 07/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculateDiscountVC : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *bgImgV;
@property (strong, nonatomic) IBOutlet UILabel *lblPageTitle;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UITextField *inputTF;
@property (weak, nonatomic) IBOutlet UITextField *discountTF;
@property (weak, nonatomic) IBOutlet UITextField *latestPriceTF;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UILabel *lblStartingPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblDiscount;
@property (strong, nonatomic) IBOutlet UILabel *lblYourDiscount;
@property (strong, nonatomic) IBOutlet UILabel *lblNewPrice;

- (IBAction)toolBarDoneAction:(id)sender;
- (IBAction)toolBarCancelAction:(id)sender;
- (IBAction)backBtnPressed:(id)sender;
@end
