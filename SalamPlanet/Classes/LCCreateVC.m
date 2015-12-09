//
//  LCCreateVC.m
//  SalamCenterApp
//
//  Created by Globit on 12/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import "LCCreateVC.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "WebManager.h"
#import "DataManager.h"
#import "LoyaltyCard.h"

#define kCellTopCardName @"cellTopCardName"
#define kCellCardImages @"cellCardImages"
#define kCellCardName   @"cellCardName"
#define kCellCardNumber @"cellCardNumber"
#define kCellProviderName @"cellProviderName"
#define kCellBarcodeNumber  @"cellBarcodeNumber"
#define kCellBarcodeType    @"cellBarcodeType"
#define kCellCardDescription @"cellCardDescription"
#define kCellCardDelete     @"cellCardDelete"
#define kCellIssueDate     @"cellIssueDate"
#define kCellExpiryDate    @"cellExpiryDate"

@interface LCCreateVC ()
{
    NSMutableArray * mainArray;
    AppDelegate * appDelegate;
    ImageImportingType imageFor;
    SelectBarcodeCell * selectBarCodeCell;
    NSDateFormatter *dateFormatter;
    BOOL isViewSquezed;
}

@end

@implementation LCCreateVC
-(id)init{
    self = [super initWithNibName:@"LCCreateVC" bundle:nil];
    if (self) {
        mainArray=[[NSMutableArray alloc]init];
        appDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    }
    return self;
}
-(id)initWithLCObject:(LCObject *)lcObj{
    self = [super initWithNibName:@"LCCreateVC" bundle:nil];
    if (self) {
        mainArray=[[NSMutableArray alloc]init];
        appDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
        _mainLCObj=lcObj;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self dolocalizationText];
    self.lblPageTitle.font=[appDelegate getFontOfPageTitle];
    
    [self.cardDescriptionTF setInputAccessoryView:_toolBar];
    [self.cardNumberTF setInputAccessoryView:_toolBar];
    [self.barcodeTF setInputAccessoryView:_toolBar];
    [self.cardTitleValueTF setInputAccessoryView:_toolBar];
    [self.cardNameTF setInputAccessoryView:_toolBar];
    [self.providerNameTF setInputAccessoryView:_toolBar];
    [self.issueDateTF setInputAccessoryView:_toolBar];
    [self.expiryDateTF setInputAccessoryView:_toolBar];
    [self.issueDateTF setInputView:_datePicker];
    [self.expiryDateTF setInputView:_datePicker];
    
    [UtilsFunctions makeUIImageViewRound:self.imgVFront ANDRadius:7.0];
    [UtilsFunctions makeUIImageViewRound:self.imgVBack ANDRadius:7.0];
    
    [self.bgImgV setImage:[UIImage imageNamed:[appDelegate getBackgroundImageName]]];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self loadMainArray];

    [self.btnDeleteFront setHidden:YES];
    [self.btnDeleteBackBtn setHidden:YES];
    
    //Initiallize SelectBarcodeTypeCell
    NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"SelectBarcodeCell" owner:self options:nil];
    selectBarCodeCell=[array objectAtIndex:0];
    /////
    if (_mainLCObj) {
        [self updateUIWithPrevData];
    }
    isViewSquezed=NO;
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [appDelegate hideBottomTabBar:YES];
    [self.btnAddFrontCardImage setSelected:NO];
    [self.btnAddBackCardImage setSelected:NO];
    [self.navigationController.navigationBar setHidden:YES];
    [selectBarCodeCell setSelected:NO];
}
-(void)dolocalizationText{
    if (_isCreateNewCard) {
        self.lblPageTitle.text=NSLocalizedString(@"Create", nil);
    }
    else{
        self.lblPageTitle.text=NSLocalizedString(@"Edit", nil);
    }
    self.lblFront.text=NSLocalizedString(@"Front", nil);
    self.lblBack.text=NSLocalizedString(@"Back", nil);
    self.lblBarcodeNumber.text=NSLocalizedString(@"Barcode Number", nil);
    self.lblCardName.text=NSLocalizedString(@"Card Name", nil);
    self.lblCardNumber.text=NSLocalizedString(@"Card Number", nil);
    self.lblDescription.text=NSLocalizedString(@"Description", nil);
    
    [self.doneBtn setTitle:NSLocalizedString(@"Done", nil) forState:UIControlStateNormal];
    [self.doneBtn setTitle:NSLocalizedString(@"Done", nil) forState:UIControlStateHighlighted];
    [self.doneBtn setTitle:NSLocalizedString(@"Done", nil) forState:UIControlStateSelected];

    [self.btnDeleteCard setTitle:NSLocalizedString(@"Delete", nil) forState:UIControlStateNormal];
    [self.btnDeleteCard setTitle:NSLocalizedString(@"Delete", nil) forState:UIControlStateHighlighted];
    [self.btnDeleteCard setTitle:NSLocalizedString(@"Delete", nil) forState:UIControlStateSelected];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-Custom Methods
-(void)updateUIWithPrevData{
    self.cardTitleValueTF.text=_mainLCObj.lcTitle;
    if (_mainLCObj.lcFrontImgName && _mainLCObj.lcBackImgName) {
        self.imgVFront.image=[UIImage imageNamed:_mainLCObj.lcFrontImgName];
        self.imgVBack.image=[UIImage imageNamed:_mainLCObj.lcBackImgName];
        [self.btnDeleteFront setHidden:YES];
        [self.btnDeleteBackBtn setHidden:YES];
    }
    else if(_mainLCObj.lcFrontImage && _mainLCObj.lcBackImage){
        self.imgVBack.image=_mainLCObj.lcBackImage;
        self.imgVFront.image=_mainLCObj.lcFrontImage;
        [self.btnDeleteFront setHidden:NO];
        [self.btnDeleteBackBtn setHidden:NO];
    }
    self.cardNameTF.text=_mainLCObj.lcTitle;
    if (_isCreateNewCard==NO) {
        if (_mainLCObj.lcBarcodeName) {
            selectBarCodeCell.barcodeTypeTF.text=_mainLCObj.lcBarcodeName;
        }
        self.barcodeTF.text=_mainLCObj.lcBarcodeNumber;
        self.cardNumberTF.text=_mainLCObj.lcCardNumber;
        if (_mainLCObj.lcDescription) {
            self.cardDescriptionTF.text=_mainLCObj.lcDescription;
            self.cardDescriptionTF.textColor=[UIColor blackColor];
        }
    }
}
-(void)loadMainArray{
    [mainArray removeAllObjects];
    
//    [mainArray addObject:kCellTopCardName];
    [mainArray addObject:kCellCardImages];
    [mainArray addObject:kCellCardName];
    [mainArray addObject:kCellCardNumber];
    [mainArray addObject:kCellProviderName];
    [mainArray addObject:kCellIssueDate];
    [mainArray addObject:kCellExpiryDate];
    [mainArray addObject:kCellBarcodeNumber];
    [mainArray addObject:kCellBarcodeType];
    [mainArray addObject:kCellCardDescription];
    if (!_isCreateNewCard) {
        [mainArray addObject:kCellCardDelete];
    }
}
- (void)showProgressView
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
- (void)hideProgressView
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [mainArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellTopCardName]) {
        return 36.0;
    }
    else if([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellCardImages]){
        return 130.0;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellCardDescription]){
        return 185.0;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellCardDelete]){
        return 60.0;
    }
    else if ([[mainArray objectAtIndex:indexPath.row] isEqualToString:kCellBarcodeType]){
        return 50;
    }
    else
    {
        return 60.0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellTopCardName]) {
        self.cellTopCardName.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellTopCardName;
    }
    else if([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellCardImages]){
        self.cellCardImages.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellCardImages;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellCardName]){
        self.cellCardName.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellCardName;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellCardNumber]){
        self.cellCardNumber.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellCardNumber;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellProviderName]){
        self.cellCardProvider.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellCardProvider;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellIssueDate]){
        self.cellIssueDate.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellIssueDate;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellExpiryDate]){
        self.cellExpiryDate.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellExpiryDate;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellBarcodeNumber]){
        self.cellBarcodeNumber.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellBarcodeNumber;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellBarcodeType]){
        selectBarCodeCell.selectionStyle=UITableViewCellSelectionStyleNone;
        return selectBarCodeCell;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellCardDelete]){
        self.cellDeleteCard.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellDeleteCard;
    }
    else
    {
        self.cellCardDescription.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellCardDescription;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellBarcodeType]) {
        BarcodeTypesVC * barcodeVC=[[BarcodeTypesVC alloc]init];
        barcodeVC.delegate=self;
        [self.navigationController pushViewController:barcodeVC animated:YES];
    }
}
#pragma mark-UITextFieldDelegate
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    if ([textField isEqual:self.cardNameTF]) {
        [self.cardNumberTF becomeFirstResponder];
    }
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.cardNameTF]) {
        NSIndexPath* ipath = [NSIndexPath indexPathForRow:1 inSection: 0];
        [self.tableView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionTop animated: YES];
    }
    else if([textField isEqual:self.cardNumberTF]){
        NSIndexPath* ipath = [NSIndexPath indexPathForRow:2 inSection: 0];
        [self.tableView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionTop animated: YES];
    }
    else if([textField isEqual:self.providerNameTF]){
        NSIndexPath* ipath = [NSIndexPath indexPathForRow:3 inSection: 0];
        [self.tableView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionTop animated: YES];
    }
    else if([textField isEqual:self.issueDateTF]){
        NSIndexPath* ipath = [NSIndexPath indexPathForRow:4 inSection: 0];
        [self.tableView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionTop animated: YES];
    }
    else if([textField isEqual:self.expiryDateTF]){
        NSIndexPath* ipath = [NSIndexPath indexPathForRow:5 inSection: 0];
        [self.tableView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionTop animated: YES];
    }
    else if([textField isEqual:self.barcodeTF]){
        NSIndexPath* ipath = [NSIndexPath indexPathForRow:6 inSection: 0];
        [self.tableView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionTop animated: YES];
    }
    if (isViewSquezed) {
        CGRect frame=self.tableView.frame;
        frame.size.height+=240;
        self.tableView.frame=frame;
        isViewSquezed=NO;
    }
    return YES;
}
#pragma mark-UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"Optional"]) {
        textView.text=@"";
        textView.textColor=[UIColor blackColor];
    }
    if (!isViewSquezed) {
        CGRect frame=self.tableView.frame;
        frame.size.height-=240;
        self.tableView.frame=frame;
        isViewSquezed=YES;
    }
    NSIndexPath* ipath = [NSIndexPath indexPathForRow:5 inSection: 0];
    [self.tableView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionTop animated: YES];
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView{
    if ([textView.text length]==0) {
        textView.text=@"Optional";
        textView.textColor=[UIColor lightGrayColor];
    }
}
#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage =info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:NO completion:nil];
    
    if(chosenImage != nil){
        RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:chosenImage cropMode:RSKImageCropModeSquare];
        imageCropVC.delegate = self;
        [self.navigationController pushViewController:imageCropVC animated:YES];
    }
}
#pragma mark - RSKImageCropViewControllerDelegate

- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage
{
    if (imageFor==CardBackside) {
        self.imgVBack.image=croppedImage;
        [self.btnDeleteBackBtn setHidden:NO];
    }
    else if(imageFor==CardFronSide){
        self.imgVFront.image=croppedImage;
        [self.btnDeleteFront setHidden:NO];
    }
    [[self navigationController] popViewControllerAnimated:NO];
}

#pragma mark-BarcodeScannerVCDelegate
-(void)addBarcodeWithNumber:(Barcode *)barCodeObj{
    self.barcodeType=[[BarcodeType alloc]initWithBarcodeObj:barCodeObj];
    self.barcodeTF.text=barCodeObj.getBarcodeData;
    selectBarCodeCell.barcodeTypeTF.text=self.barcodeType.barcodeName;
    ShowMessage(kAppName,NSLocalizedString(@"Barcode has been added successfully", nil));
}
#pragma mark-BarcodeTypesVCDelegate
-(void)barcodeHasBeenSelected:(BarcodeType *)obj{
    selectBarCodeCell.barcodeTypeTF.text=obj.barcodeName;
    self.barcodeType=obj;
}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (buttonIndex==0) {
        UIImagePickerController * imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [imagePickerController.navigationBar setTintColor:[UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1]];
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
        else
        {
            ShowMessage(NSLocalizedString(@"Error", nil),NSLocalizedString(@"Sorry! Camera is not available", nil));
            [self.btnAddFrontCardImage setSelected:NO];
            [self.btnAddBackCardImage setSelected:NO];
        }
    }
    else if (buttonIndex==1) {
        UIImagePickerController * imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [imagePickerController.navigationBar setTintColor:[UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1]];
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
        else
        {
            ShowMessage(NSLocalizedString(@"Error", nil),NSLocalizedString(@"Sorry! Photo Library is not available", nil));
            [self.btnAddFrontCardImage setSelected:NO];
            [self.btnAddBackCardImage setSelected:NO];
        }
    }
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (!alertView.tag == 400) {
        return;
    }
    else if(buttonIndex != alertView.cancelButtonIndex){
        ShowMessage(kAppName,NSLocalizedString(@"Card has been deleted successfully", nil));
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else{
    }
}
#pragma mark-IBActions and Selectors
- (IBAction)backBtnPressed:(id)sender {
    [self.backBtn setSelected:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)isValidCard
{
    BOOL validCard = NO;
    if ([self.barcodeTF.text isEmpty])
    {
        ShowMessage(kAppName, NSLocalizedString(@"Please add card barcode number",nil));
    }
    else if ([selectBarCodeCell.barcodeTypeTF.text isEmpty]){
        ShowMessage(kAppName,NSLocalizedString(@"Please select barcode type", nil));
    }
    else if ([self.issueDateTF.text isEmpty])
    {
         ShowMessage(kAppName, NSLocalizedString(@"Please add card issue date",nil));
    }
    else if ([self.expiryDateTF.text isEmpty])
    {
        ShowMessage(kAppName, NSLocalizedString(@"Please add card expiry date",nil));
    }
    else{
        validCard = YES;
    }
    return validCard;
}
- (IBAction)doneBtnPressed:(id)sender {
    
    if ([self isValidCard])
    {
        LoyaltyCard *loyaltyCard = [[DataManager sharedInstance] loyaltyCardWithId:nil];//cardId come from server
        loyaltyCard.barcode = self.barcodeTF.text;
        loyaltyCard.cardNumber = self.cardNameTF.text;
        loyaltyCard.title = self.cardNameTF.text;
        loyaltyCard.notes = self.cardDescriptionTF.text;
        loyaltyCard.barcodeType = selectBarCodeCell.barcodeTypeTF.text;
        loyaltyCard.providerName = self.providerNameTF.text;
        loyaltyCard.issueDate = [dateFormatter dateFromString:self.issueDateTF.text];
        loyaltyCard.expiryDate = [dateFormatter dateFromString:self.expiryDateTF.text];
        
        loyaltyCard.frontImageString = [UtilsFunctions getBase64StringFromImage:self.imgVBack.image];
        loyaltyCard.backImageString = [UtilsFunctions getBase64StringFromImage:self.imgVFront.image];
        [self showProgressView];
        [[WebManager sharedInstance] saveLoyaltyCardOnServer:loyaltyCard success:^(NSString* message) {
            [self hideProgressView];
            if (message)
            {
                ShowMessage(kAppName, message);
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSString *errorString) {
            [self hideProgressView];
            ShowMessage(kAppName, errorString);
            
        }];
    }
//    if ([self.cardNumberTF.text length]) {
//        if ([self.cardDescriptionTF.text length]) {
//            if (self.imgVBack.image) {
//                if (self.imgVFront.image) {
//                        if (self.cardNameTF.text.length) {
//                            if ([self.barcodeTF.text length]) {
//                                if ([selectBarCodeCell.barcodeTypeTF.text length]==0) {
//                                    ShowMessage(kAppName,NSLocalizedString(@"Please select barcode type", nil));
//                                    return;
//                                }
//                            }
//                            LCObject * lcObj=[[LCObject alloc]init];
//                            lcObj.lcID=10;
//                            lcObj.lcCardNumber=self.cardNumberTF.text;
//                            lcObj.lcDescription=self.cardDescriptionTF.text;
//                            lcObj.lcBarcodeImgName=@"temp_barcode";
//                            lcObj.lcBackImage=self.imgVBack.image;
//                            lcObj.lcFrontImage=self.imgVFront.image;
//                            lcObj.lcShopName=@" ";
//                            lcObj.lcBarcodeNumber=self.barcodeTF.text;
//                            lcObj.lcTitle=self.cardNameTF.text;
//                            lcObj.lcBarcodeName=selectBarCodeCell.barcodeTypeTF.text;
//                            [self.delegate newLCObjectHasBeenCreated:lcObj];
//                            if(_isCreateNewCard){
//                                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//                            }
//                            else{
//                                [self.navigationController popViewControllerAnimated:YES];
//                            }
//                        }
//                        else{
//                            ShowMessage(kAppName,NSLocalizedString(@"Please add Card name", nil));
//                        }
////                    }
////                    else{
////                        ShowMessage(kAppName, @"Please add card barcode number");
////                    }
//                }
//                else{
//                    ShowMessage(kAppName,NSLocalizedString(@"Please add card back picture", nil));
//                }
//            }
//            else{
//                ShowMessage(kAppName,NSLocalizedString(@"Please add card front picture", nil));
//            }
//        }
//        else{
//            ShowMessage(kAppName,NSLocalizedString(@"Please enter card description", nil));
//        }
//    }
//    else{
//        ShowMessage(kAppName,NSLocalizedString(@"Please enter card number first", nil));
//    }
}

- (IBAction)scanBarcodePressed:(id)sender {
    BarcodeScannerVC * barCodeScannerVC=[[BarcodeScannerVC alloc]init];
    barCodeScannerVC.delegate=self;
    [self.navigationController presentViewController:barCodeScannerVC animated:NO completion:nil];
}

- (IBAction)addFrontCardImageBtnPressed:(id)sender {
    [self.btnAddFrontCardImage setSelected:YES];
    UIActionSheet * actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Camera", nil),NSLocalizedString(@"Gallery", nil), nil];
    [actionSheet showInView:self.view];
    imageFor=CardFronSide;
    
//    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc] init];
//    imagePickerController.delegate = self;
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
//        [imagePickerController.navigationBar setTintColor:[UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1]];
//
//        [self.navigationController presentViewController:imagePickerController animated:YES completion:nil];
//    }
//    else
//    {
//        ShowMessage(@"Error", @"Sorry! Camera is not available");
//
//    }
}

- (IBAction)addBackCardImageBtnPressed:(id)sender {
    [self.btnAddBackCardImage setSelected:YES];
    UIActionSheet * actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Camera", nil),NSLocalizedString(@"Gallery", nil), nil];
    [actionSheet showInView:self.view];
    imageFor=CardBackside;
    
//    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc] init];
//    imagePickerController.delegate = self;
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
//        [imagePickerController.navigationBar setTintColor:[UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1]];
//    
//        [self.navigationController presentViewController:imagePickerController animated:YES completion:nil];
//    }
//    else
//    {
//        ShowMessage(@"Error", @"Sorry! Camera is not available");
//        
//    }
}

- (IBAction)deleteFrontBtnPressed:(id)sender {
    [self.imgVFront setImage:[UIImage imageNamed:@"LC_CardImg1"]];
    [self.btnDeleteFront setHidden:YES];
}

- (IBAction)deleteBackBtnPressed:(id)sender {
    [self.imgVBack setImage:[UIImage imageNamed:@"LC_CardImg2"]];
    [self.btnDeleteBackBtn setHidden:YES];
}

- (IBAction)deleteCardBtnPressed:(id)sender {
    [self.btnDeleteCard setSelected:YES];
    UIAlertView *ask = [[UIAlertView alloc] initWithTitle:kAppName message:NSLocalizedString(@"Do you want to delete this card?", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"NO", nil) otherButtonTitles:NSLocalizedString(@"Yes", nil).uppercaseString, nil];
    ask.tag = 400;
    [ask show];

}
- (IBAction)hideKeyboard:(id)sender {
    if (isViewSquezed) {
        CGRect frame=self.tableView.frame;
        frame.size.height+=240;
        self.tableView.frame=frame;
        isViewSquezed=NO;
    }
    [self.cardDescriptionTF resignFirstResponder];
    [self.cardNumberTF resignFirstResponder];
    [self.barcodeTF resignFirstResponder];
    [self.cardTitleValueTF resignFirstResponder];
    [self.cardNameTF resignFirstResponder];
    [self.providerNameTF resignFirstResponder];
   

    if (self.issueDateTF.isFirstResponder) {
        self.issueDateTF.text = [dateFormatter stringFromDate:self.datePicker.date];
        [self.issueDateTF resignFirstResponder];
    }
    else if ([self.expiryDateTF isFirstResponder])
    {
        self.expiryDateTF.text = [dateFormatter stringFromDate:self.datePicker.date];
        [self.expiryDateTF resignFirstResponder];
    }
}
@end
