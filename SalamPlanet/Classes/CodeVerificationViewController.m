//
//  CodeVerificationViewController.m
//  SalamPlanet
//
//  Created by Saad Khan on 18/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "CodeVerificationViewController.h"
#import "EditProfileViewController.h"
#import "WebManager.h"
#import "MBProgressHUD.h"

@interface CodeVerificationViewController ()

@end

@implementation CodeVerificationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self dolocalizationText];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.codeTF.leftView = paddingView;
    self.codeTF.leftViewMode = UITextFieldViewModeAlways;
    //self.codeTF.text = self.verificationCode;
    
    [self.codeTF setInputAccessoryView:_toolBar];
    [self.codeTF becomeFirstResponder];
//
//    [self sendVerificationCodeSMS];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.continueBtn setSelected:NO];
}
-(void)dolocalizationText{
    self.lblIfYouDoNotRecieve.text=NSLocalizedString(@"If you do not receive your access code within 60 seconds. Let us...", nil);
    self.lblPleaseEnterCode.text=NSLocalizedString(@"Please enter the verification code", nil);
    [self.toolBarDone setTitle:NSLocalizedString(@"Done", nil)];
    
    [self.continueBtn setTitle:NSLocalizedString(@"Continue", nil) forState:UIControlStateNormal];
    [self.continueBtn setTitle:NSLocalizedString(@"Continue", nil) forState:UIControlStateHighlighted];
    [self.continueBtn setTitle:NSLocalizedString(@"Continue", nil) forState:UIControlStateSelected];
    [self.noCodeBtn setTitle:NSLocalizedString(@"Resend code", nil) forState:UIControlStateNormal];
    [self.noCodeBtn setTitle:NSLocalizedString(@"Resend code", nil) forState:UIControlStateHighlighted];
    [self.noCodeBtn setTitle:NSLocalizedString(@"Resend code", nil) forState:UIControlStateSelected];
}

#pragma mark:Custom Methods
-(void)sendVerificationCodeSMS{
//    [smsApi sendSMSWebserviceOnNumber:GetStringWithKey(kUserPhone)];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WebManager sharedInstance] registerUserByPhoneNumber:GetStringWithKey(kUserPhone) success:^(NSString *verifCode){
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ShowMessage(kAppName,[error localizedDescription]);
    }];

}
#pragma mark:SMSAPIDelegate
-(void)smsSentSuccessfully{
    
}
-(void)smsSentFailed{
    
}
- (void)pushEditProfileScreen
{
    EditProfileViewController * editProfileVC =[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"EditProfile"];
    [self.navigationController pushViewController:editProfileVC animated:YES];
}
#pragma mark:IBAction and Selector Methods
- (IBAction)continueAction:(id)sender {
    if (self.codeTF.text.length < 4) {
        ShowMessage(kAppName, NSLocalizedString(@"Verification code should be 4 digits",nil));
        return;
    }
    [self.continueBtn setSelected:YES];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString * number = GetStringWithKey(kUserPhone);
    [[WebManager sharedInstance] verifyCode:self.codeTF.text withPhoneNumber:number
                                   success:^(id response){
                                       
                                       [[WebManager sharedInstance] getCurrentUserProfile:^(id response) {
                                           [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                           [self pushEditProfileScreen];
                                       } failure:^(NSError *error) {
                                           [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                           [self pushEditProfileScreen];
                                       }];
                                      
                                   } failure:^(NSString *error) {
                                       [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                        ShowMessage(kAppName,error);
                                   }];
}

- (IBAction)noCodeAction:(id)sender {
    [self sendVerificationCodeSMS];
}
- (IBAction)hideKeyboard:(id)sender {
    [self.codeTF resignFirstResponder];
}
- (IBAction)backAction:(id)sender {
    [self.backBtn setSelected:YES];    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma TextField Delegates
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
//    if ((newLength ==4) ? YES : NO) {
//        [self continueAction:nil];
//    }
    return (newLength > 4) ? NO : YES;
}
@end
