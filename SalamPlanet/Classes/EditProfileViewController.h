//
//  EditProfileViewController.h
//  SalamPlanet
//
//  Created by Saad Khan on 18/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"
#import "ActionSheetStringPicker.h"
#import "FBLogin.h"
#import "RadioButton.h"
#import "UtilsFunctions.h"
#import "User.h"
#import "FBUserSelf.h"
#import "AddLocationView.h"

@interface EditProfileViewController : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate,FBLoginDelegate,AddLocViewDelegate>
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIImageView *profileImg;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextField *cityTF;

@property (weak, nonatomic) IBOutlet UITextField *dobTF;
@property (weak, nonatomic) IBOutlet UIButton *continueBtn;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet RadioButton *maleButton;
@property (weak, nonatomic) IBOutlet RadioButton *femaleButton;
@property (weak, nonatomic) IBOutlet UIButton *photoButton;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *syncFBButton;

@property (strong,nonatomic) UIImage *profileImage;
@property (nonatomic)BOOL isFromEdit;
@property (nonatomic)BOOL isFacebookRegistration;
@property (strong, nonatomic) FBUserSelf *fbUser;

- (IBAction)toolBarDoneAction:(id)sender;

- (IBAction)uploadPhotoAction:(id)sender;
- (IBAction)continueAction:(id)sender;
- (IBAction)backAction:(id)sender;

- (IBAction)syncFBBtnAction:(id)sender;

-(void)loadUserData;
@end
