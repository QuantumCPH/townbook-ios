//
//  LoginViewController.m
//  SalamPlanet
//
//  Created by Saad Khan on 18/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "LoginViewController.h"
#import "BDVCountryNameAndCode.h"
#import "CountryList.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "CountryList.h"
#import "CodeVerificationViewController.h"
#import "CountryListViewController.h"
#import "UtilsFunctions.h"
#import "WebManager.h"

@interface LoginViewController ()
{
    AppDelegate * appDelegate;
    NSMutableDictionary * countriesCode;
}
@end

@implementation LoginViewController
@synthesize scrollView;

- (id)init
{
    self = [super initWithNibName:@"LoginViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self dolocalizationText];
    appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    //set content size of scroll view
    [scrollView setScrollEnabled:YES];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.countryCodeTF.leftView = paddingView;
    self.countryCodeTF.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.phoneNumberTF.leftView = paddingView2;
    self.phoneNumberTF.leftViewMode = UITextFieldViewModeAlways;
    
    scrollView.scrollEnabled=YES;
    scrollView.contentSize=CGSizeMake(scrollView.frame.size.width,self.continueBtn.frame.origin.y + self.continueBtn.frame.size.height + 10);

    
//    CountryList *obj = [[CountryList alloc] init];
//    countriesCode = [[NSMutableDictionary alloc] initWithDictionary:obj.countryCodes];
//    [self doGeoCode];
    
    [self.phoneNumberTF setInputAccessoryView:_toolBar];
    
   
    
    [self.tickBtn setSelected:YES];
    
    [self.lblRecievePush setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:16.0f]];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kSelectedCountryCode]) {
        NSString *codeName = [NSString stringWithFormat:@"%@ (+%@)",[[NSUserDefaults standardUserDefaults] objectForKey:kSelectedCountryName],[[NSUserDefaults standardUserDefaults] objectForKey:kSelectedCountryCode]];
        [self.countryCodeTF setText:codeName];
    }
    else
    {
        [self getCountryFromPhoneLocale];
    }
    
    [self.continueBtn setSelected:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}
- (void)getCountryFromPhoneLocale
{
    CountryList *obj = [[CountryList alloc] init];
    countriesCode = [[NSMutableDictionary alloc] initWithDictionary:obj.countryCodes];
    BDVCountryNameAndCode *bdvCountryNameAndCode = [[BDVCountryNameAndCode alloc] init];
    NSString *prefixOfCurrentLocale = [bdvCountryNameAndCode prefixForCurrentLocale]; // Returns "+1" for Canada
    NSString *nameOfCurrentLocale = [bdvCountryNameAndCode countryNameForCurrentLocale]; // Returns "Canada"
    if (prefixOfCurrentLocale && nameOfCurrentLocale) {
        
        NSDictionary *codeDict = [[NSDictionary alloc] initWithDictionary:[countriesCode objectForKey:nameOfCurrentLocale]];
        
        [[NSUserDefaults standardUserDefaults] setObject:nameOfCurrentLocale forKey:kSelectedCountryName];
        [[NSUserDefaults standardUserDefaults] setObject:prefixOfCurrentLocale forKey:kSelectedCountryCode];
        [[NSUserDefaults standardUserDefaults] setObject:[codeDict objectForKey:@"Abbr"]forKey:kSelectedCountryShortName];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.countryCodeTF setText:[NSString stringWithFormat:@"%@ (+%@)",nameOfCurrentLocale,prefixOfCurrentLocale]];
        
    }
}

-(void)dolocalizationText{
    self.lblRecievePush.text=NSLocalizedString(@"Recieve push notifications/SMS", nil);
    self.lblAnAccessCodeWillBeSent.text=NSLocalizedString(@"An access code will be sent to you by SMS", nil);
    self.lblCountry.text=NSLocalizedString(@"Country", nil);
    self.lblPhoneNumber.text=NSLocalizedString(@"Phone Number", nil);
    self.lblSelectYourCountry.text=NSLocalizedString(@"Select your country, enter your phone number and press continue", nil);
    self.phoneNumberTF.placeholder=NSLocalizedString(@"Number without the country code", nil);
    self.countryCodeTF.placeholder=NSLocalizedString(@"Select country", nil);
    [self.toolBarDone setTitle:NSLocalizedString(@"Done", nil)];
    
    [self.continueBtn setTitle:NSLocalizedString(@"Continue", nil) forState:UIControlStateNormal];
    [self.continueBtn setTitle:NSLocalizedString(@"Continue", nil) forState:UIControlStateHighlighted];
    [self.continueBtn setTitle:NSLocalizedString(@"Continue", nil) forState:UIControlStateSelected];
}
-(NSString*)getCorrectFormattedPhoneNumber:(NSString*)num
{
    NSString * countryCode = GetStringWithKey(kSelectedCountryCode);
    if ([num hasPrefix:@"0"])
    {
        num = [num substringFromIndex:1];
    }
    NSString * phone=[NSString stringWithFormat:@"%@%@",countryCode,num];
    return phone;
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (!(alertView.tag == 400)) {
        return;
    }
    else if(buttonIndex != alertView.cancelButtonIndex){
        NSString *phone = [self getCorrectFormattedPhoneNumber:self.phoneNumberTF.text];
//        NSString * countryCOde=GetStringWithKey(kSelectedCountryCode);
//        NSString * num=self.phoneNumberTF.text;
//        if ([num hasPrefix:@"0"])
//        {
//            num = [num substringFromIndex:1];
//        }
//        NSString * phone=[NSString stringWithFormat:@"%@%@",countryCOde,num];
     
        SaveStringWithKey(phone, kUserPhone);

        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [[WebManager sharedInstance] registerUserByPhoneNumber:phone success:^(NSString *verifCode){
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            CodeVerificationViewController * codeVerfVC=[[CodeVerificationViewController alloc]init];
            //codeVerfVC.verificationCode = verifCode;
            [self.navigationController pushViewController:codeVerfVC animated:YES];
        } failure:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            ShowMessage(kAppName, NSLocalizedString([error localizedDescription],nil));
        }];
        
    }
    else{
        [self.phoneNumberTF becomeFirstResponder];
        [self.continueBtn setSelected:NO];
    }
}

#pragma mark:IBAction and Selector Methods
- (IBAction)continueAction:(id)sender {
    if (self.countryCodeTF.text.length==0) {
        ShowMessage(kAppName,NSLocalizedString(@"Please select your country", nil));
        return;
    }
    if (self.phoneNumberTF.text.length==0) {
        ShowMessage(kAppName,NSLocalizedString(@"Please enter your phone number", nil));
        return;
    }
    
    if (!self.tickBtn.selected) {
        ShowMessage(kAppName,NSLocalizedString(@"Please accept receiving push notifications/SMS", nil));
        return;
    }
    [self.continueBtn setSelected:YES];
    [self resignFields];
    UIAlertView *ask = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Phone Number Verification", nil) message:[NSString stringWithFormat:NSLocalizedString(@"Is this your correct number?\n +%@ \nA SMS with your access code will be sent to this number.", nil),[self getCorrectFormattedPhoneNumber:self.phoneNumberTF.text]] delegate:self cancelButtonTitle:@"Edit" otherButtonTitles:@"YES", nil];
    ask.tag = 400;
    [ask show];
}
- (IBAction)getCountryCodeBtnAction:(id)sender {
    CountryListViewController *cvc  = [[CountryListViewController alloc] initWithNibName:@"CountryListViewController" bundle:nil];
    [self.navigationController pushViewController:cvc animated:YES];
}

- (IBAction)tickAction:(id)sender {
    self.tickBtn.selected=!self.tickBtn.selected;
}

- (IBAction)hideKeyboard:(id)sender {
    [self.phoneNumberTF resignFirstResponder];
}
#pragma TextField Delegates
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString * countryCode = GetStringWithKey(kSelectedCountryCode);
    if ([countryCode isEqualToString:@"45"] )
    {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 8) ? NO : YES;
    }
    else if ([countryCode isEqualToString:@"92"])
    {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 11) ? NO : YES;
    }
    else
    {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 15) ? NO : YES;
    }
    return YES;
}

- (void)resignFields
{
    [self.phoneNumberTF resignFirstResponder];
}

@end
