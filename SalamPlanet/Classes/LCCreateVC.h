//
//  LCCreateVC.h
//  SalamCenterApp
//
//  Created by Globit on 12/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCObject.h"
#import "BarcodeScannerVC.h"
//#import "ImageCropView.h"
#import "RSKImageCropper.h"
#import "BarcodeTypesVC.h"
#import "BarcodeType.h"
#import "Barcode.h"
#import "SelectBarcodeCell.h"
#import "NSString+Helpers.h"
#import "TPKeyboardAvoidingTableView.h"

@protocol LCCreateVCDelegate
-(void)newLCObjectHasBeenCreated:(LCObject *)obj;
@end

@interface LCCreateVC : UIViewController<UIImagePickerControllerDelegate,RSKImageCropViewControllerDelegate,UINavigationControllerDelegate,BarcodeScannerVCDelegate,BarcodeTypesVCDelegate,UIActionSheetDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) id<LCCreateVCDelegate> delegate;
@property (strong, nonatomic) IBOutlet UILabel *lblPageTitle;
@property (weak, nonatomic) IBOutlet UIImageView *bgImgV;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellTopCardName;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellCardImages;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellCardName;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellCardNumber;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellBarcodeNumber;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellCardProvider;

//@property (strong, nonatomic) IBOutlet UITableViewCell *cellBarcodeType;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellCardDescription;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellDeleteCard;
@property (weak, nonatomic) IBOutlet UITextField *cardTitleValueTF;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UIButton *btnDeleteFront;
@property (weak, nonatomic) IBOutlet UIButton *btnScanBarcode;
@property (strong, nonatomic) IBOutlet UILabel *lblFront;
@property (strong, nonatomic) IBOutlet UILabel *lblBack;
@property (strong, nonatomic) IBOutlet UILabel *lblCardName;
@property (strong, nonatomic) IBOutlet UILabel *lblCardNumber;
@property (strong, nonatomic) IBOutlet UILabel *lblBarcodeNumber;

@property (weak, nonatomic) IBOutlet UITextView *cardDescriptionTF;
@property (weak, nonatomic) IBOutlet UITextField *cardNumberTF;
@property (weak, nonatomic) IBOutlet UITextField *barcodeTF;

@property (weak, nonatomic) IBOutlet UIButton *btnDeleteBackBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imgVFront;
@property (weak, nonatomic) IBOutlet UIImageView *imgVBack;
@property (weak, nonatomic) IBOutlet UIButton *btnAddFrontCardImage;
@property (weak, nonatomic) IBOutlet UIButton *btnAddBackCardImage;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UITextField *cardNameTF;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellIssueDate;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellExpiryDate;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextField *issueDateTF;
@property (weak, nonatomic) IBOutlet UITextField *expiryDateTF;

//@property (weak, nonatomic) IBOutlet UITextField *barcodeTypeTF;
@property (weak, nonatomic) IBOutlet UIButton *btnDeleteCard;
@property (weak, nonatomic) IBOutlet UILabel *lblProviderName;
@property (weak, nonatomic) IBOutlet UITextField *providerNameTF;

@property (strong, nonatomic) LCObject * mainLCObj;
@property (strong, nonatomic) BarcodeType * barcodeType;
@property (nonatomic) BOOL isCreateNewCard;

-(id)initWithLCObject:(LCObject *)lcObj;

- (IBAction)hideKeyboard:(id)sender;
- (IBAction)backBtnPressed:(id)sender;
- (IBAction)doneBtnPressed:(id)sender;
- (IBAction)scanBarcodePressed:(id)sender;
- (IBAction)addFrontCardImageBtnPressed:(id)sender;
- (IBAction)addBackCardImageBtnPressed:(id)sender;
- (IBAction)deleteFrontBtnPressed:(id)sender;
- (IBAction)deleteBackBtnPressed:(id)sender;
- (IBAction)deleteCardBtnPressed:(id)sender;
@end
