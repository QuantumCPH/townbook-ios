//
//  CalculateDiscountVC.m
//  SalamCenterApp
//
//  Created by Globit on 07/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import "CalculateDiscountVC.h"
#import "AppDelegate.h"

@interface CalculateDiscountVC ()
{
    AppDelegate * appDelegate;
    NSArray * discountArray;
    NSArray * discountValueArray;
    NSInteger selectedDiscountRate;
    BOOL isSlided;
}
@end

@implementation CalculateDiscountVC

-(id)init{
    self = [super initWithNibName:@"CalculateDiscountVC" bundle:nil];
    if (self) {
        appDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
        discountArray=[[NSArray alloc]initWithObjects:@"--",@"-5%",@"-10%",@"-15%",@"-20%",@"-25%",@"-30%",@"-35%",@"-40%",@"-45%",@"-50%",@"-55%",@"-60%",@"-65%",@"-70%",@"-75%",@"-80%",@"-85%",@"-90%",@"-95%", nil];
        discountValueArray=[[NSArray alloc]initWithObjects:@"0",@"5",@"10",@"15",@"20",@"25",@"30",@"35",@"40",@"45",@"50",@"55",@"60",@"65",@"70",@"75",@"80",@"85",@"90",@"95", nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dolocalizationText];
    [self.bgImgV setImage:[UIImage imageNamed:[appDelegate getBackgroundImageName]]];
    self.lblPageTitle.font=[appDelegate getFontOfPageTitle];
    
//    [self.inputTF setInputAccessoryView:_toolBar];
    [self.pickerView selectRow:10 inComponent:0 animated:NO];
    selectedDiscountRate=50;
    [self.inputTF becomeFirstResponder];
    isSlided=NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [appDelegate hideBottomTabBar:YES];
}
-(void)dolocalizationText{
    self.lblDiscount.text=NSLocalizedString(@"DISCOUNT", nil);
    self.lblNewPrice.text=NSLocalizedString(@"NEW PRICE", nil);
    self.lblPageTitle.text=NSLocalizedString(@"Calculator", nil);
    self.lblStartingPrice.text=NSLocalizedString(@"STARTING PRICE", nil);
    self.lblYourDiscount.text=NSLocalizedString(@"YOUR DISCOUNT", nil);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark:Custom Methods
-(void)updateViewWithLatestValues{
    NSInteger price=[self.inputTF.text integerValue];
    NSInteger discountedPrice=price*(100-selectedDiscountRate)/100;
    NSInteger discount=price-discountedPrice;
    self.latestPriceTF.text=[NSString stringWithFormat:@"%li",(long)discountedPrice];
    self.discountTF.text=[NSString stringWithFormat:@"%li",(long)discount];
}
#pragma mark:UIPickerDelegate & DataSource
// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return  (int)[discountArray count];
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return discountArray[row];
}
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:[discountArray objectAtIndex:row] attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1],NSFontAttributeName:[UIFont systemFontOfSize:30]}];
    
    return attString;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    selectedDiscountRate=[[discountValueArray objectAtIndex:row]integerValue];
    [self updateViewWithLatestValues];
}
#pragma mark-UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    textField.text=[textField.text stringByReplacingCharactersInRange:range withString:string];
    [self updateViewWithLatestValues];
    return NO;
}
#pragma mark:IBActions & Selectors
- (IBAction)backBtnPressed:(id)sender {
//    [self.backBtn setSelected:YES];
//    [appDelegate showSlideMenuForBackAction];
//    [self.navigationController popViewControllerAnimated:YES];
    if(isSlided){
        [appDelegate showHideSlideMenue:YES withCenterName:nil];
        isSlided=NO;
    }
    else{
        [appDelegate showHideSlideMenue:YES withCenterName:nil];
        isSlided=YES;
    }
}
- (IBAction)toolBarDoneAction:(id)sender {
//    [self.inputTF resignFirstResponder];
    [self updateViewWithLatestValues];
}
- (IBAction)toolBarCancelAction:(id)sender{
//    [self.inputTF resignFirstResponder];
}
@end
