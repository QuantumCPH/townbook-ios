//
//  CodeVerificationViewController.h
//  SalamPlanet
//
//  Created by Saad Khan on 18/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIUnderlinedButton.h"

@interface CodeVerificationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIImageView *verifyImg;
@property (weak, nonatomic) IBOutlet UIButton *continueBtn;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIUnderlinedButton *noCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UILabel *lblPleaseEnterCode;
@property (strong, nonatomic) IBOutlet UILabel *lblIfYouDoNotRecieve;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *toolBarDone;

@property (strong,nonatomic) NSString* verificationCode;

- (IBAction)backAction:(id)sender;
- (IBAction)hideKeyboard:(id)sender;
- (IBAction)continueAction:(id)sender;
- (IBAction)noCodeAction:(id)sender;

@end
