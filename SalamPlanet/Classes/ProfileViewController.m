//
//  ProfileViewController.m
//  SalamCenterApp
//
//  Created by Waseem Asif on 02/11/2015.
//  Copyright © 2015 Globit. All rights reserved.
//

#import "ProfileViewController.h"
#import "EditProfileViewController.h"
#import "UIImageView+WebCache.h"
#import "ProfileInfoCell.h"
#import "ProfileImageCell.h"
#import "ProfileShareCell.h"
#import "LanguageCell.h"
#import "UtilsFunctions.h"
#import "LangaugeManager.h"
#import "AppDelegate.h"
#import "Constants.h"
#import "User.h"
#import "DataManager.h"
#import "RegStepOneVC.h"
#import "RegStepTwoVC.h"
#import "NotificationsVC.h"
#import "SDWebImageManager.h"
#import "MBProgressHUD.h"
#import "WebManager.h"
#import "SDImageCache.h"
#import "LanguagesVC.h"

@import AVFoundation;
@import Social;
@import MessageUI;

@interface ProfileViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate>
{
    NSArray * infoArray;
    AppDelegate * appDelegate;
    User *user;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;


@property (nonatomic) BOOL isImageEdited;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    
    infoArray = @[NSLocalizedString(@"Edit Profile",nil),NSLocalizedString(@"Towns", nil),NSLocalizedString(@"Interests", nil),NSLocalizedString(@"Help",nil),NSLocalizedString(@"Privacy Policy",nil),NSLocalizedString(@"About Us", nil),NSLocalizedString(@"Log out", nil)];
    user = [[DataManager sharedInstance] currentUser];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.titleLbl.text = user.name;
    //[self.tableView reloadData];
    [appDelegate hideWithoutAnimationBottomTabBar:NO];
    ProfileImageCell *imageCell = (ProfileImageCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if(_isPopedFromEditProfile)
    {
        imageCell.profileImgView.image = self.profileImage;
        self.isPopedFromEditProfile = NO;
    }
    else if (_isImageEdited)
    {
        imageCell.profileImgView.image = self.profileImage;
    }
    else
    {
        if(user.image.length >0)
        {
            self.profileImage = [[SDWebImageManager sharedManager] imageWithURL:[NSURL URLWithString:user.image]];
            imageCell.profileImgView.image = self.profileImage;

            //[imageCell.profileImgView setImageWithURL:[NSURL URLWithString:user.image] placeholderImage:[UIImage imageNamed:@"new_avatar.png"]];
        }
    }
}
#pragma mark:Custom Methods
- (NSString*)getInfoSectionTitle
{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *bundleVersionKey  = (NSString *)CFBridgingRelease(kCFBundleVersionKey);
    NSString *build = [[[NSBundle mainBundle] infoDictionary] objectForKey:bundleVersionKey];
    return [NSString stringWithFormat:@"iOS version %@ - build %@",version,build];
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
#pragma mark:IBActions and Selectors
- (IBAction)pictureEditBtnTapped:(UIButton*)sender {
    UIActionSheet * actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Camera",nil),NSLocalizedString(@"Gallery",nil), nil];
    [actionSheet showInView:self.view];
}

- (IBAction)segmentBarLanguageValueChanged:(UISegmentedControl*)sender {
    ShowMessage(kAppName,NSLocalizedString(@"Please restart the application for applying the change", nil));
    UISegmentedControl * segmentController=(UISegmentedControl *)sender;
    if (segmentController.selectedSegmentIndex==0) {
        [NSBundle setLanguage:nil];
        SaveStringWithKey(nil, kAppLangauge);
    }
    else if(segmentController.selectedSegmentIndex==1){
        [NSBundle setLanguage:kEnglish];
        SaveStringWithKey(kEnglish, kAppLangauge);
    }
    else{
        [NSBundle setLanguage:kDanish];
        SaveStringWithKey(kDanish, kAppLangauge);
    }
}
- (IBAction)facebookTapped:(id)sender
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *fbPostSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [fbPostSheet setInitialText:NSLocalizedString(@"Hey Check this new Townbook App.",nil)];
        [self presentViewController:fbPostSheet animated:YES completion:nil];
    } else
    {
        ShowMessage(kAppName,NSLocalizedString(@"You can't post right now, make sure your device has an internet connection and you have at least one facebook account setup", nil));
    }
}
- (IBAction)twitterTapped:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:NSLocalizedString(@"Hey Check this new Townbook App.",nil)];
        [self presentViewController:tweetSheet animated:YES completion:nil];
        
    }
    else
    {
        ShowMessage(kAppName,NSLocalizedString(@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup", nil));
    }
}
- (IBAction)smsTapped:(id)sender {
    MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc] init];
    if ([MFMessageComposeViewController canSendText]) {
        
        NSString *smsString = NSLocalizedString(@"Townbook App Invitation",nil);
        messageVC.body = smsString;
        
        messageVC.messageComposeDelegate = self;
        [self presentViewController:messageVC animated:YES completion:nil];
    }
//    else{
//        ShowMessage(kAppName,NSLocalizedString(@"Your device doesn't support SMS!", nil));
//    }
}
- (IBAction)emailTapped:(id)sender {
    // Email Subject
    NSString *emailTitle = NSLocalizedString(@"Townbook App Invitation",nil);
    // Email Content
    NSString *messageBody = NSLocalizedString(@"Hey Check this new Townbook App.",nil);
    // To address
    //    NSArray *toRecipents = [NSArray arrayWithObject:@"support@appcoda.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    if ([MFMailComposeViewController canSendMail]) {
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
    }
    else{
        ShowMessage(kAppName,NSLocalizedString(@"You can't send email", nil));
    }
}

#pragma mark-UITableView DataSource and Delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return nil;
    else if (section == 1 )
        return [self getInfoSectionTitle];
    else if (section == 2)
        return NSLocalizedString(@"Settings", nil);
    else
        return NSLocalizedString(@"Share",nil);
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1];
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor whiteColor]];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if( section == 1)
        return infoArray.count;
    else if (section == 2)
        return 2;
    else
        return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 )
        return 250.0;
    else if (indexPath.section == 3)
        return 70;
    else
        return 44;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        ProfileImageCell *imageCell = [tableView dequeueReusableCellWithIdentifier:@"ProfileImageCell"];
        [imageCell.profileImgView setupImageViewer];
        if([UIScreen mainScreen].bounds.size.height == 568.0)
            imageCell.overlayImgView.image = [UIImage imageNamed:@"Photo_overlay_320"];
        if (_isImageEdited) {
            imageCell.profileImgView.image = self.profileImage;
          
        }
        else if (user.image.length >0) {
            [imageCell.profileImgView setImageWithURL:[NSURL URLWithString:user.image] placeholderImage:[UIImage imageNamed:@"new_avatar.png"]];
        }
        return imageCell;
    }
    else if(indexPath.section == 1)
    {
        ProfileInfoCell *infoCell =  [tableView dequeueReusableCellWithIdentifier:@"ProfileInfoCell"];
        infoCell.infoLbl.text = infoArray[indexPath.row];
        return infoCell;
    }
    else if (indexPath.section == 2)
    {
        ProfileInfoCell *infoCell =  [tableView dequeueReusableCellWithIdentifier:@"ProfileInfoCell"];
        if (indexPath.row == 0)
            infoCell.infoLbl.text = NSLocalizedString(@"Notifications",nil);
        else
            infoCell.infoLbl.text = NSLocalizedString(@"Change Language",nil);

        return infoCell;
    }
    else
    {
        ProfileShareCell *shareCell = [tableView dequeueReusableCellWithIdentifier:@"ProfileShareCell"];
        return shareCell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            EditProfileViewController * editProfileVC =[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"EditProfile"];
            editProfileVC.isFromEdit = YES;
            if (self.profileImage)
                editProfileVC.profileImage = _profileImage;
            [self.navigationController pushViewController:editProfileVC animated:YES];
        }
        else if (indexPath.row ==1)
        {
            RegStepOneVC *mallsVC = [[RegStepOneVC alloc] init];
            mallsVC.isFromEdit = YES;
            [self.navigationController pushViewController:mallsVC animated:YES];
        }
        else if (indexPath.row == 2)
        {
            RegStepTwoVC * interestsVC = [[RegStepTwoVC alloc]init];
            interestsVC.isFromEdit = YES;
            [self.navigationController pushViewController:interestsVC animated:YES];
        }
        else if (indexPath.row == infoArray.count-1 )
        {
            UIAlertView *ask = [[UIAlertView alloc] initWithTitle:kAppName message:NSLocalizedString(@"Do You Want to logout", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) otherButtonTitles:NSLocalizedString(@"Yes", nil), nil];
            ask.tag = 500;
            [ask show];
        }
    }
    else if (indexPath.section == 2)
    {
        if (indexPath.row == 0)
        {
            NotificationsVC * notificationVC =[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"NotificationsVC"];
            [self.navigationController pushViewController:notificationVC animated:YES];
        }
        else
        {
            LanguagesVC *languagesVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LanguagesVC"];
            [self.navigationController pushViewController:languagesVC animated:YES];
            
        }
    }
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (!(alertView.tag == 500)) {
        return;
    }
    else if(buttonIndex != alertView.cancelButtonIndex){
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[WebManager sharedInstance] signOutUser:^(NSString *message){
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            //ShowMessage(kAppName, message);
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserSignOutNotification object:nil];
            SaveStringWithKey(@"NO", kisLoggedIn);
            [[NSUserDefaults standardUserDefaults] setPersistentDomain:[NSDictionary dictionary] forName:[[NSBundle mainBundle] bundleIdentifier]];
            [appDelegate loadRegisterationChoiceScreen];
 
        } failure:^(NSString *errorString) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            ShowMessage(kAppName, errorString);

        }];
    }
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
    [picker dismissViewControllerAnimated:YES completion:nil];
    if(chosenImage.size.width>320)
    {
        self.profileImage = [UtilsFunctions imageWithImage:chosenImage scaledToSize:CGSizeMake(320, 320)];
    }
    else{
        self.profileImage = chosenImage;
    }
    _isImageEdited = YES;
    ProfileImageCell *imageCell = (ProfileImageCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    imageCell.profileImgView.image = self.profileImage;
    user.imageDataString = [UtilsFunctions getBase64StringFromImage:self.profileImage];
                            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[WebManager sharedInstance] saveUserProfileOnServer:user success:^(id response) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (response) {
            [[DataManager sharedInstance] setCurrentUser:user];
            [[DataManager sharedInstance] saveContext];
            [[SDImageCache sharedImageCache] removeImageForKey:user.image fromDisk:YES];
            [[SDWebImageManager sharedManager] downloadWithURL:[NSURL URLWithString:user.image] delegate:self];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ShowMessage(kAppName,[error localizedDescription]);
    }];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - MFMessageComposeViewControllerDelegate methods
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            ShowMessage(kAppName,NSLocalizedString(@"Failed to send SMS!", nil));
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - MFMailComposeViewControllerDelegate methods
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
