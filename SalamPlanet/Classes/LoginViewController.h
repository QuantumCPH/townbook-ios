//
//  LoginViewController.h
//  SalamPlanet
//
//  Created by Saad Khan on 18/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"

@interface LoginViewController : UIViewController<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *countryCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTF;
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *continueBtn;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIButton *tickBtn;
@property (strong, nonatomic) IBOutlet UILabel *lblSelectYourCountry;
@property (strong, nonatomic) IBOutlet UILabel *lblCountry;
@property (strong, nonatomic) IBOutlet UILabel *lblPhoneNumber;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *toolBarDone;
@property (strong, nonatomic) IBOutlet UILabel *lblAnAccessCodeWillBeSent;
@property (strong, nonatomic) IBOutlet UILabel *lblRecievePush;
- (IBAction)getCountryCodeBtnAction:(id)sender;
- (IBAction)tickAction:(id)sender;
- (IBAction)hideKeyboard:(id)sender;
- (IBAction)continueAction:(id)sender;
@end
