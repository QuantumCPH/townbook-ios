//
//  AddProfileVC.m
//  SalamPlanet
//
//  Created by Globit on 12/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "AddProfileVC.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "FBUserSelf.h"
#import "UIImageView+AFNetworking.h"
#import "RegStepOneVC.h"
#import "Constants.h"
#import "UtilsFunctions.h"

@import AVFoundation;

#define kCellNameTF @"cellNameTF"
#define kCellFBBtn  @"cellFBbutton"
#define kCellContinueBtn    @"cellContinueBtn"

#define kFBAppKey   @"788289757930171"//398243400343868"

@interface AddProfileVC ()
{
    NSMutableArray * mainArray;
    BOOL isPictureAdded;
    AppDelegate * appDelegate;
    FBLogin * fbLogin;
    UIImageView * profileImg;
    UITapGestureRecognizer * tapGesture;
}

@end

@implementation AddProfileVC
- (id)init
{
    self = [super initWithNibName:@"AddProfileVC" bundle:nil];
    if (self) {
        mainArray=[[NSMutableArray alloc]init];
        appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
        profileImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 320)];
        profileImg.image=[UIImage imageNamed:@"new_avatar"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self dolocalizationText];
    // add parallax with image
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.nameTF.leftView = paddingView;
    self.nameTF.leftViewMode = UITextFieldViewModeAlways;
    
    [self.nameTF setInputAccessoryView:_toolBar];
    
    
    [self loadParallaxImageInTableView];
    self.tableView.parallaxView.delegate = self;
    
    [self loadMainArray];
    
    self.view.backgroundColor=[UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1];//[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    

}
-(void)dolocalizationText{
    self.nameTF.placeholder=NSLocalizedString(@"Your Name", nil);
    [self.toolBarDone setTitle:NSLocalizedString(@"Done", nil)];
    [self.continueBtn setTitle:NSLocalizedString(@"Continue", nil) forState:UIControlStateNormal];
    [self.continueBtn setTitle:NSLocalizedString(@"Continue", nil) forState:UIControlStateHighlighted];
    [self.continueBtn setTitle:NSLocalizedString(@"Continue", nil) forState:UIControlStateSelected];
    [self.fbButton setTitle:NSLocalizedString(@"Sync with Facebook", nil) forState:UIControlStateNormal];
    [self.fbButton setTitle:NSLocalizedString(@"Sync with Facebook", nil) forState:UIControlStateHighlighted];
    [self.fbButton setTitle:NSLocalizedString(@"Sync with Facebook", nil) forState:UIControlStateSelected];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark:Custom Methods
-(void)loadParallaxImageInTableView{
    [self.tableView addParallaxWithImage:profileImg.image andHeight:160 andShadow:YES];
    tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self.tableView.backgroundView action:@selector(tapHasBeenDetected)];
}
-(void)loadParallaxImageInTableViewWithImage:(UIImage *)img{
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
    [self.tableView addParallaxWithImage:img andHeight:160 andShadow:YES];
    profileImg.image=img;
}
-(void)hideProgresshud{
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
}
-(void)loadMainArray{
    [mainArray removeAllObjects];
    
    [mainArray addObject:kCellNameTF];
    [mainArray addObject:kCellFBBtn];
    [mainArray addObject:kCellContinueBtn];
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
    if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellNameTF]) {
        return 60.0;
    }
    if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellFBBtn]) {
        return 46.0;
    }
    else{
        return 70.0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    
//    cell.textLabel.text = [NSString stringWithFormat:@"Row %li", indexPath.row+1];
//    return cell;
    if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellNameTF]) {
        self.cellNametf.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellNametf;
    }
    if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellFBBtn]) {
        self.cellFBBtn.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellFBBtn;
    }
    else{
        self.cellContinueBtn.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellContinueBtn;
    }
}
#pragma mark - APParallaxViewDelegate

- (void)parallaxView:(APParallaxView *)view willChangeFrame:(CGRect)frame {
    // Do whatever you need to do to the parallaxView or your subview before its frame changes
//    NSLog(@"parallaxView:willChangeFrame: %@", NSStringFromCGRect(frame));
}

- (void)parallaxView:(APParallaxView *)view didChangeFrame:(CGRect)frame {
    // Do whatever you need to do to the parallaxView or your subview after its frame changed
//    NSLog(@"parallaxView:didChangeFrame: %@", NSStringFromCGRect(frame));
}
-(void)parallaxViewAddPhotoButtonPressed{
    UIActionSheet * actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Camera", nil),NSLocalizedString(@"Gallery", nil), nil];
    [actionSheet showInView:self.view];
}
#pragma mark - UIActionSheetDelegate
//- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
//{
//    for (UIView *subview in actionSheet.subviews) {
//        if ([subview isKindOfClass:[UIButton class]]) {
//            UIButton *button = (UIButton *)subview;
//            button.titleLabel.textColor = [UIColor colorWithRed:86.0/255.0 green:198.0/255.0 blue:160.0/255.0 alpha:1.0];
//        }
//    }
//}
- (void)presentCameraPickerController:(UIImagePickerController *)imagePickerController
{
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [imagePickerController.navigationBar setTintColor:[UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1]];
    [self presentViewController:imagePickerController animated:YES completion:nil];

}
- (void)showCameraPermissionAlert
{
    ShowMessage(NSLocalizedString(@"Error", nil),NSLocalizedString(@"Camera Permission Required.Please enable camera in settings for this app", nil));
}
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
        }
        else
        {
            ShowMessage(NSLocalizedString(@"Error", nil),NSLocalizedString(@"Sorry! Camera is not available", nil));
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
        }
    }
}
#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage =info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    if(chosenImage.size.width>320)
    {
        profileImg.image=[UtilsFunctions imageByCroppingImage:chosenImage toSize:CGSizeMake(320, 320)];
    }
    else{
        profileImg.image=chosenImage;
    }
    isPictureAdded=YES;
    [self loadParallaxImageInTableViewWithImage:chosenImage];
}
#pragma mark - FBLoginDelegate
-(void)failedToFetchAnyAccount{
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
    [self.fbButton setSelected:NO];
    ShowMessage(kAppName,NSLocalizedString(@"Please add facebook account in settings.", nil));
}
-(void)fbProfileHasBeenFetchedSuccessfullyWithInfo:(FBUserSelf *)fbUser{
    if (fbUser.profileImageURL.length>0) {
        __weak typeof(self) weakSelf = self;
        [profileImg setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:fbUser.profileImageURL]] placeholderImage:[UIImage imageNamed:@"new_avatar"]
                              success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                  [weakSelf performSelectorOnMainThread:@selector(loadParallaxImageInTableViewWithImage:) withObject:image waitUntilDone:NO];
                              }
                              failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                  [weakSelf performSelectorOnMainThread:@selector(hideProgresshud) withObject:nil waitUntilDone:NO];
                                  //handle errors here
                              }];
        isPictureAdded=YES;
    }
    if (!fbUser.displayName) {
        self.nameTF.text=fbUser.firstName;
    }
    else{
        self.nameTF.text=fbUser.displayName;
    }
}
-(void)fbProfileDidNotFetched{
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
    [self.fbButton setSelected:NO];
    ShowMessage(kAppName,NSLocalizedString(@"Sorry, failed to fetch profile info due to network problem.", nil));
}
#pragma mark- IBActions and Selectors
-(void)tapHasBeenDetected{
    
}
- (IBAction)hideKeyboard:(id)sender {
    [self.nameTF resignFirstResponder];
}
- (IBAction)continueAction:(id)sender {
    if (isPictureAdded) {
        if ([self.nameTF.text length]>0) {
            [self.continueBtn setSelected:YES];
//            SaveStringWithKey(@"YES", kisLoggedIn);
//            SaveIntegerWithKey(0, kTempEndrIDUniversal);
            [self saveAllEndorsementInUserDefaults];
//            [appDelegate changeRootViewToStartApp];
            RegStepOneVC * regStepOne=[[RegStepOneVC alloc]init];
            [self.navigationController pushViewController:regStepOne animated:YES];
//            ShowMessage(kAppName, @"Registration is completed successfully");
        }
        else{
            ShowMessage(kAppName,NSLocalizedString(@"Please add name.", nil));
        }
    }
    else{
        ShowMessage(kAppName,NSLocalizedString(@"Please add Profile Picture", nil));
    }
   
}

- (IBAction)synchFBAction:(id)sender {
    if (self.fbButton.selected) {
        return;
    }
    if (!fbLogin) {
        fbLogin=[[FBLogin alloc]initWithKey:kFBAppKey];
        fbLogin.delegate=self;
    }
    else{
        [fbLogin facebookAccountInit];
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.fbButton setSelected:YES];
}
#pragma mark:Save Endorsement in user default
-(void)saveAllEndorsementInUserDefaults{
    SaveStringWithKey(self.nameTF.text, kTempUserName);
    NSMutableDictionary * dict=[[NSMutableDictionary alloc]init];
    [dict setObject:self.nameTF.text forKey:kTempUserName];
    
    [dict setObject:profileImg.image   forKey:kTempUserPic];
    
    [dict setObject:@"NP" forKey:kTempUserDOB];
    
    [dict setObject:@"NP" forKey:kTempUserLocation];
    
    [dict setObject:@"NP" forKey:kTempUserEducation];

    [dict setObject:@"YES" forKey:kTempUserGender];

    NSData *personEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:dict];
    
    NSUserDefaults *userData = [NSUserDefaults standardUserDefaults];
    [userData setObject:personEncodedObject forKey:kUserCreatedLocally];
    
    SaveArrayWithKey(@[NSLocalizedString(@"All", nil)],kArrayFavouriteCatSubCat);
}

@end
