//
//  EditProfileViewController.m
//  SalamPlanet
//
//  Created by Saad Khan on 18/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "EditProfileViewController.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"
#import "SDImageCache.h"
#import "NSString+Helpers.h"
#import "DataManager.h"
#import "RegStepOneVC.h"
#import "WebManager.h"
#import "CountryList.h"
#import "BDVCountryNameAndCode.h"
#import "ProfileViewController.h"

@import AVFoundation;

#define kFBAppKey   @"398243400343868"

@interface EditProfileViewController ()
{
    AppDelegate * appDelegate;
    BOOL isPictureAdded;
    FBLogin * fbLogin;
    BOOL isMale;
    BOOL isAutoCompleteLocation;
}
@property (nonatomic,strong) User *user;
@end

@implementation EditProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isMale=YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [UtilsFunctions makeUIImageViewRound:self.profileImg ANDRadius:self.profileImg.frame.size.width/2];
    
    appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate hideBottomTabBar:YES];
    
    [self configureTextFields];
    self.maleButton.groupButtons = @[self.maleButton,self.femaleButton];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSDate *date  = [dateFormatter dateFromString:@"31/12/2000"];
    self.datePicker.maximumDate = date;
    self.user = [[DataManager sharedInstance] currentUser];
    if (self.user.name)
        [self loadCurrentUserData];
    else if (!self.user.name && self.isFacebookRegistration)
         [self loadFacebookUser];
    
    [self.syncFBButton setTitle:NSLocalizedString(@"Sync with Facebook", nil) forState:UIControlStateNormal];
    [self.syncFBButton setTitle:NSLocalizedString(@"Sync with Facebook", nil) forState:UIControlStateHighlighted];
    [self.syncFBButton setTitle:NSLocalizedString(@"Sync with Facebook", nil) forState:UIControlStateSelected];
    
    if (_isFromEdit) {
        _backBtn.hidden = NO;
        self.syncFBButton.hidden = YES;
        [self.photoButton setTitle:NSLocalizedString(@"Edit Photo",nil) forState:UIControlStateNormal];
        [self.continueBtn setTitle:NSLocalizedString(@"Update", nil) forState:UIControlStateNormal];
        [self.continueBtn setTitle:NSLocalizedString(@"Update", nil) forState:UIControlStateSelected];
        [appDelegate hideBottomTabBar:YES];
    }
    else
    {
        _backBtn.hidden = YES;
        //[self configureCityTextField];
        [self.photoButton setTitle:NSLocalizedString(@"Add Photo",nil) forState:UIControlStateNormal];
        [self.photoButton setTitle:NSLocalizedString(@"Add Photo",nil) forState:UIControlStateHighlighted];
        [self.photoButton setTitle:NSLocalizedString(@"Add Photo",nil) forState:UIControlStateSelected];
        [self.continueBtn setTitle:NSLocalizedString(@"Continue", nil) forState:UIControlStateNormal];
        [self.continueBtn setTitle:NSLocalizedString(@"Continue", nil) forState:UIControlStateSelected];
        NSString *cityAddress = GetStringWithKey(kLocationServiceAddress);
        if (cityAddress)
            _cityTF.text = cityAddress;
        if (self.isFacebookRegistration)
        {
            self.syncFBButton.hidden = YES;
           
        }
        else
            [self.maleButton setSelected:YES];
    }
}
#pragma mark - Custom methods
-(void)configureCityTextField
{
    NSString *cityName = GetStringWithKey(kLocationServiceCity);
    if (cityName)
        self.cityTF.text = cityName;
    else
        self.cityTF.text = GetStringWithKey(kLocationServiceAddress);
}
- (NSString*)removeSpaceFromString:(NSString*)addressString
{
    if ([addressString hasPrefix:@" "])
        addressString = [addressString substringFromIndex:1];
    
    return addressString;
}
- (NSString*)getCityNameFromAddress:(NSString*)address
{
    NSString *cityName;
    NSArray *addressComponents = [address componentsSeparatedByString:@","];
    if (addressComponents.count>0)
    {
        if (addressComponents.count >3)
        {
            cityName = addressComponents[addressComponents.count-3];
            cityName = [self removeSpaceFromString:cityName];
        }
        else if (addressComponents.count == 3 || addressComponents.count == 2)
        {
            cityName = addressComponents.firstObject;
            cityName = [self removeSpaceFromString:cityName];
        }
        else
            cityName = address;
    }
    else
        cityName = address;
    
    return cityName;
}
- (void)setUserCountryShortNameFromAddress:(NSString *)address
{
    NSString *countryName;
    NSArray *addressComponents = [address componentsSeparatedByString:@","];
    if (addressComponents.count>0)
    {
        countryName = addressComponents.lastObject;
        countryName = [self removeSpaceFromString:countryName];
        
        if ([countryName isEqualToString:@"Danmark"])//spelling correction
            countryName = @"Denmark";
        
        
        CountryList *obj = [[CountryList alloc] init];
        NSMutableDictionary *countriesCode = [[NSMutableDictionary alloc] initWithDictionary:obj.countryCodes];
        NSDictionary *codeDict = [[NSDictionary alloc] initWithDictionary:[countriesCode objectForKey:countryName]];
        self.user.country = [[codeDict objectForKey:@"Abbr"] uppercaseString];
    }
}
- (void)configureTextFields
{
    for (int i = 0; i<4; i++)
    {
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
        if (i == 0)
            [self addPaddingView:paddingView toTextField:_nameTF];
        else if (i == 1)
            [self addPaddingView:paddingView toTextField:_emailTF];
        else if (i == 2)
            [self addPaddingView:paddingView toTextField:_cityTF];
        else
            [self addPaddingView:paddingView toTextField:_dobTF];
    }
    
    [self.dobTF setInputView:self.datePicker];
    [self.dobTF setInputAccessoryView:_toolBar];
}

- (void)addPaddingView:(UIView*)view toTextField:(UITextField*)textField
{
    textField.leftView = view;
    textField.leftViewMode = UITextFieldViewModeAlways;
}

-(void)loadUserData{
    NSData * savedObject=GetDataWithKey(kUserCreatedLocally);
    NSDictionary * dictnry=[NSKeyedUnarchiver unarchiveObjectWithData:savedObject];
    if ([dictnry objectForKey:kTempUserName]) {
        self.nameTF.text=[dictnry objectForKey:kTempUserName];
    }
    if ([dictnry objectForKey:kTempUserPic]) {
        self.profileImg.image=[dictnry objectForKey:kTempUserPic];
        isPictureAdded=YES;
    }
    if ([dictnry objectForKey:kTempUserDOB]) {
        self.dobTF.text=[dictnry objectForKey:kTempUserDOB];
    }
    if ([[dictnry objectForKey:kTempUserGender]isEqualToString:@"YES"]) {
        isMale=YES;
    }
    else{
        isMale=NO;
    }
}
- (BOOL)isValidProfile
{
    BOOL validProfile = NO;
    if ([self.nameTF.text isEmpty]) {
         ShowMessage(kAppName, NSLocalizedString(@"Please add Name.",nil));
    }
    else if ([self.emailTF.text isEmpty])
    {
        ShowMessage(kAppName, NSLocalizedString(@"Please add email.",nil));
    }
    else if (![self.emailTF.text isValidEmail])
    {
         ShowMessage(kAppName, NSLocalizedString(@"Please enter a valid email.",nil));
    }
    else if ([self.cityTF.text isEmpty])
    {
        ShowMessage(kAppName, NSLocalizedString(@"Please enter your address.",nil));
    }
//    else if ([self.dobTF.text isEmpty])
//    {
//        ShowMessage(kAppName, @"Please add date of birth.");
//    }
//    else if (!isPictureAdded)
//    {
//        ShowMessage(kAppName, @"Please add Profile Picture");
//    }
    else
    {
        validProfile = YES;
    }
    return validProfile;
}
- (void)presentCameraPickerController:(UIImagePickerController *)imagePickerController
{
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.allowsEditing = YES;
    [imagePickerController.navigationBar setTintColor:[UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1]];
    [self presentViewController:imagePickerController animated:YES completion:nil];
    
}
- (void)showCameraPermissionAlert
{
    ShowMessage(NSLocalizedString(@"Error", nil),NSLocalizedString(@"Camera Permission Required.Please enable camera in settings for this app", nil));
}

- (void)loadFacebookUser
{
    if (self.fbUser.profileImageURL.length>0) {
        [self.profileImg setImageWithURL:[NSURL URLWithString:self.fbUser.profileImageURL] placeholderImage:[UIImage imageNamed:@"parallax_avatar"]];
        isPictureAdded=YES;
    }
    self.nameTF.text = self.fbUser.displayName;
    self.emailTF.text = self.fbUser.email;
    self.dobTF.text = self.fbUser.dob;
    if ([[self.fbUser.gender lowercaseString] isEqualToString:@"male"])
        [self.maleButton setSelected:YES];
    else
        [self.femaleButton setSelected:YES];
}
- (void)loadCurrentUserData
{
    if (_isFromEdit && self.profileImage) {
        self.profileImg.image = self.profileImage;
    }
    else if (self.user.image.length >0) {
        [self.profileImg setImageWithURL:[NSURL URLWithString:self.user.image] placeholderImage:[UIImage imageNamed:@"parallax_avatar"]];
        isPictureAdded = YES;
    }
    self.nameTF.text = self.user.name;
    self.emailTF.text = self.user.email == nil? @"":self.user.email;
    NSString *cityName = self.user.city == nil? @"":self.user.city;
    NSString *countryName;
    if (self.user.country)
    {
        BDVCountryNameAndCode *bdvCountryNameAndCode = [[BDVCountryNameAndCode alloc] init];
        countryName = [bdvCountryNameAndCode countryNameFromCountryShortName:self.user.country];
    }
    
    if (countryName)
        self.cityTF.text = [NSString stringWithFormat:@"%@,%@",cityName,countryName];
    else
        self.cityTF.text = cityName;
    
    if (self.user.dateOfBirth) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        self.dobTF.text = [dateFormatter stringFromDate:self.user.dateOfBirth];
        self.datePicker.date = self.user.dateOfBirth;
    }

    if (self.user.isMale)
        [self.maleButton setSelected:YES];
    else
        [self.femaleButton setSelected:YES];
}
- (void)showAddLocationView
{
    [self.cityTF resignFirstResponder];
    AddLocationView * locSubView=[[AddLocationView alloc]initWithGoogleApi:YES];
    locSubView.frame=CGRectMake(14, 66, self.view.frame.size.width-(14+14), locSubView.frame.size.height);
    [self.view addSubview:locSubView];
    locSubView.delegate = self;
    //[locSubView.inputTF becomeFirstResponder];
}
#pragma mark -IBActions
- (IBAction)cityTextTapped:(id)sender {
    [self showAddLocationView];
}

- (IBAction)toolBarDoneAction:(id)sender {
    NSDate *dob = self.datePicker.date;
    self.user.dateOfBirth = dob;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    self.dobTF.text = [dateFormatter stringFromDate:dob];
    [self.dobTF resignFirstResponder];
    [self.nameTF resignFirstResponder];
}

- (IBAction)uploadPhotoAction:(id)sender {

    UIActionSheet * actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Camera",nil),NSLocalizedString(@"Gallery",nil), nil];
    [actionSheet showInView:self.view];
}

- (IBAction)continueAction:(id)sender {
   
    if ([self isValidProfile])
    {
        [self.continueBtn setSelected:YES];
        NSString *name = self.nameTF.text;
        self.user.name = name;

        self.user.email = self.emailTF.text;
        self.user.city = [self getCityNameFromAddress:self.cityTF.text];
        [self setUserCountryShortNameFromAddress:self.cityTF.text];
        if (self.user.country == nil)
        {
            self.user.country = [GetStringWithKey(kSelectedCountryShortName) uppercaseString];
        }
//        NSString *countryName = [GetStringWithKey(kSelectedCountryShortName) uppercaseString];
//        if (!countryName) {
//            NSString *address = GetStringWithKey(kLocationServiceAddress);
//            [self setUserCountryShortNameFromAddress:address];
//        }
//        else
//            self.user.country = countryName;
        if (!isAutoCompleteLocation)
        {
            self.user.latitude = appDelegate.locationManager.location.coordinate.latitude;
            self.user.longitude = appDelegate.locationManager.location.coordinate.longitude;
        }
        self.user.imageDataString = [UtilsFunctions getBase64StringFromImage:self.profileImg.image];
        //self.user.imageLocalPath = [UtilsFunctions saveImageInDirectory:self.profileImg.image];
        self.user.isMale = self.maleButton.isSelected;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[WebManager sharedInstance] saveUserProfileOnServer:self.user success:^(id response) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            if (response) {
                [[DataManager sharedInstance] setCurrentUser:self.user];
                [[DataManager sharedInstance] saveContext];
                [[SDImageCache sharedImageCache] removeImageForKey:self.user.image fromDisk:YES];
                if (self.user.image)
                    [[SDWebImageManager sharedManager] downloadWithURL:[NSURL URLWithString:self.user.image] delegate:self];
                if (!_isFromEdit)
                {
                    //SaveStringWithKey(@"YES", kisLoggedIn);
                    RegStepOneVC * regStepOne=[[RegStepOneVC alloc]init];
                    [self.navigationController pushViewController:regStepOne animated:YES];
#if !(TARGET_IPHONE_SIMULATOR)
                    [[WebManager sharedInstance] sendDeviceTokenForPushNotification];
#endif
                }
                else
                {
                    [self.continueBtn setSelected:NO];
                    NSInteger count = self.navigationController.viewControllers.count;
                    ProfileViewController *profileVC = (ProfileViewController *)self.navigationController.viewControllers[count-2];
                    profileVC.profileImage = self.profileImg.image;
                    profileVC.isPopedFromEditProfile = YES;
                }
            }
        } failure:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            ShowMessage(kAppName,[error localizedDescription]);
        }];
    }
}
- (IBAction)backAction:(id)sender {
    [self.backBtn setSelected:YES];    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)syncFBBtnAction:(id)sender {
    if (!fbLogin) {
        fbLogin = [[FBLogin alloc] init];
        fbLogin.delegate = self;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [fbLogin loginFB];
}
#pragma mark -AddLocViewDelegate
-(void)locationNameisSelected:(NSString *)locationName ANDGPSValues:(CLLocationCoordinate2D)locationCoordinates
{
    self.cityTF.text = locationName;
    if (locationCoordinates.latitude != 0.00 && locationCoordinates.longitude != 0.00)
    {
        self.user.latitude = locationCoordinates.latitude;
        self.user.longitude = locationCoordinates.longitude;
        isAutoCompleteLocation = YES;
    }
    
}
-(void)locationViewIsCancelled
{
    
}
#pragma mark - FBLoginDelegate
-(void)failedToFetchAnyAccount{
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
    ShowMessage(kAppName, NSLocalizedString(@"Please add facebook account in settings.",nil));
}

-(void)fbProfileHasBeenFetchedSuccessfullyWithInfo:(FBUserSelf *)fbUser{
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
    self.fbUser = fbUser;
    [self loadFacebookUser];
}
-(void)fbProfileDidNotFetched{
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
    ShowMessage(kAppName, NSLocalizedString(@"Sorry, failed to fetch profile info.",nil));
}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (buttonIndex==0) {
        UIImagePickerController * imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if(status == AVAuthorizationStatusAuthorized)
            {
                [self presentCameraPickerController:imagePickerController];
            } else if(status == AVAuthorizationStatusDenied)
            {
                [self showCameraPermissionAlert];
            } else if(status == AVAuthorizationStatusRestricted )
            {
                [self showCameraPermissionAlert];
            } else if(status == AVAuthorizationStatusNotDetermined)
            {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if(granted)
                    {
                        [self presentCameraPickerController:imagePickerController];
                    } else {
                        NSLog(@"Not granted access");
                        [self showCameraPermissionAlert];
                    }
                }];
            }

//            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
//            
//            [imagePickerController.navigationBar setTintColor:[UIColor colorWithRed:86.0/255.0 green:198.0/255.0 blue:160.0/255.0 alpha:1.0]];
//            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
        else
        {
            ShowMessage(NSLocalizedString(@"Error", nil),NSLocalizedString(@"Sorry! Camera is not available", nil));
        }
    }
    else if (buttonIndex==1) {
        UIImagePickerController * imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [imagePickerController.navigationBar setTintColor:[UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1]];
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
        else
        {
            ShowMessage(NSLocalizedString(@"Error", nil),NSLocalizedString(@"Sorry! Photo Library is not available", nil));
        }
    }
}
#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage =info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:^{
        if (_isFromEdit)
            [appDelegate hideWithoutAnimationBottomTabBar:YES];
    }];
    if(chosenImage.size.width>320)
    {
        self.profileImg.image = [UtilsFunctions imageWithImage:chosenImage scaledToSize:CGSizeMake(320, 320)];
    }
    else{
        self.profileImg.image=chosenImage;
    }
    isPictureAdded=YES;
    [self.photoButton setTitle:@" " forState:UIControlStateNormal];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        if (_isFromEdit)
            [appDelegate hideWithoutAnimationBottomTabBar:YES];
    }];
}

@end
