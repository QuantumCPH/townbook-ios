//
//  NewShopDetailVC.m
//  SalamPlanet
//
//  Created by Globit on 12/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "NewShopDetailVC.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "FBUserSelf.h"
#import "UIImageView+AFNetworking.h"

#define kCellDetailText @"cellDetailText"
#define kCellHeadingPF  @"cellHeadingPF"
#define kCellShareView  @"cellShareView"
#define kCellFeatureProduct @"cellFeaturedProduct"
#define kCellTabOptions    @"cellTabOptions"
#define kCellDirection  @"cellDirection"

@interface NewShopDetailVC ()
{
    NSMutableArray * mainArray;
    AppDelegate * appDelegate;
    FBLogin * fbLogin;
    UIImageView * profileImg;
    NSDictionary * offerDictMain;
    NSMutableArray * mainFeaturedProductArray;
    NSString * centerName;
    EShareView * shareView;
    DetailTabOptions tabOpt;
    EDetailActionCell * detailTabCell;
    
    BOOL isBookMarked;
    UIBarButtonItem *leftItem;
    UIBarButtonItem *rightItem;
}

@end

@implementation NewShopDetailVC
- (id)init
{
    self = [super initWithNibName:@"NewShopDetailVC" bundle:nil];
    if (self) {
        mainArray=[[NSMutableArray alloc]init];
        appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
        tabOpt=ShowDetailOpt;
    }
    return self;
}
-(id)initWithOfferCreatedLocally:(NSDictionary *)offerDict ANDCenterName:(NSString*)centername{
    self = [super initWithNibName:@"NewShopDetailVC" bundle:nil];
    if (self) {
        offerDictMain=[[NSDictionary alloc]initWithDictionary:offerDict];
        mainArray=[[NSMutableArray alloc]init];
        mainFeaturedProductArray=[[NSMutableArray alloc]init];
        centerName=[[NSString alloc]initWithString:centername];
        appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
        if ([offerDictMain valueForKey:kTempObjImgName]) {
            profileImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:[offerDictMain valueForKey:kTempObjImgName]]];
        }
        else{
            profileImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shop_avatar"]];
        }
        tabOpt=ShowDetailOpt;
        isBookMarked=NO;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    // add parallax with image
    
    [self loadParallaxImageInTableView];
    self.tableView.parallaxView.delegate = self;
    
    [self loadFeaturedProductsArrayWithDummy];
    [self loadMainArray];
    
   self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:[appDelegate getBackgroundImageName]]];//[UIColor colorWithRed:84.0/255.0 green:200.0/255.0 blue:163.0/255.0 alpha:1];
}
-(void)customizeTheNavigationBar{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"euserInfo-background"]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;

    if (!leftItem) {
        leftItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back-button.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleBordered target:self action:@selector(leftNavBarBtnPressed:)];
        leftItem.tintColor=[UIColor clearColor];
    }
    if (!rightItem) {
        NSString * imgName;
        if (isBookMarked) {
            imgName=@"heart_large_p";
        }
        else{
            imgName=@"heart_large";
        }
        rightItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleBordered target:self action:@selector(rightNavBarBtnPressed:)];
    }
    [[self navigationItem] setLeftBarButtonItem:leftItem];
    [[self navigationItem] setRightBarButtonItem:rightItem];
    
    if ([offerDictMain valueForKey:kTempObjShop]) {
        [[self navigationItem] setTitle:[offerDictMain valueForKey:kTempObjShop]];
    }
    else{
        [[self navigationItem] setTitle:@"Shop"];
    }
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    [self customizeTheNavigationBar];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark:Custom Methods
-(CGSize)calculateSizeForText:(NSString *)txt{
    
    CGSize maximumLabelSize = CGSizeMake(300, 600);
    CGSize expectedSectionSize = [txt sizeWithFont:self.detailText.font//self.commentView.font
                                 constrainedToSize:maximumLabelSize
                                     lineBreakMode:NSLineBreakByTruncatingTail];
    return expectedSectionSize;
}
-(void)loadParallaxImageInTableView{
    [self.tableView addParallaxWithoutButtonWithImage:profileImg.image andHeight:160 andShadow:NO];
}
-(void)loadParallaxImageInTableViewWithImage:(UIImage *)img{
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
    [self.tableView addParallaxWithoutButtonWithImage:img andHeight:160 andShadow:YES];
    profileImg.image=img;
}
-(void)hideProgresshud{
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
}
-(void)loadMainArray{
    [mainArray removeAllObjects];
    
    [mainArray addObject:kCellTabOptions];
    if (tabOpt==ShowDetailOpt) {
        [mainArray addObject:kCellDetailText];
    }
    else if (tabOpt==ShowShareOpt) {
        [mainArray addObject:kCellShareView];
    }
    else if(tabOpt==ShowDirectionOpt)
    {
        [mainArray addObject:kCellDirection];
    }
    else if(tabOpt==ShowOffersOpt){
        for (int i=0; i<mainFeaturedProductArray.count; i++) {
            [mainArray addObject:kCellFeatureProduct];
        }
    }
    [mainArray addObject:kCellHeadingPF];
    for (int i=0; i<mainFeaturedProductArray.count; i++) {
        [mainArray addObject:kCellFeatureProduct];
    }
}
-(void)initializeShareView{
    if (!shareView) {
        shareView=[[EShareView alloc]init];
        shareView.frame=self.cellShareView.contentView.frame;
        shareView.delegate=self;
        [self.cellShareView.contentView addSubview:shareView];
        self.cellShareView.selectionStyle=UITableViewCellSelectionStyleNone;
    }
}
-(void)loadFeaturedProductsArrayWithDummy{
    [mainFeaturedProductArray removeAllObjects];
    
    NSArray * savedObjects=GetArrayWithKey(kArrayEndorsementCreatedLocally);
    for (NSData * item in savedObjects) {
        NSDictionary * dictnry=[NSKeyedUnarchiver unarchiveObjectWithData:item];
        [mainFeaturedProductArray addObject:dictnry];
        if (mainFeaturedProductArray.count==3) {
            break;
        }
    }
}
-(void)initializeMapToShowInDetailCell{
    if (!_map) {
        _map = [[MKMapView alloc] init];//CGRectMake(0, 0, 101, 160.0)
        _map.userInteractionEnabled = FALSE;
        _map.delegate = self;
        MKCoordinateRegion myRegion;
        
        myRegion.center.latitude = 56.0;
        myRegion.center.longitude = 10.0;
        
        // this sets the zoom level, a smaller value like 0.02
        // zooms in, a larger value like 80.0 zooms out
        myRegion.span.latitudeDelta = 0.2;
        myRegion.span.longitudeDelta = 0.2;
        
        // move the map to our location
        [_map setRegion:myRegion animated:NO];
        
        //annotation
        TGAnnotation *annot = [[TGAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(56.0, 10.0)];
        [_map addAnnotation:annot];
    }
}
-(void)initializeDetailTabCell{
    detailTabCell = [[[NSBundle mainBundle] loadNibNamed:@"EDetailActionCell" owner:self options:nil] objectAtIndex:0];
    
    [detailTabCell setButtonViewsAccordingToOptionisPlace:NO];
    detailTabCell.delegate=self;
    detailTabCell.selectionStyle=UITableViewCellSelectionStyleNone;
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
    if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellTabOptions]) {
        return 38.0;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellDetailText]) {
        CGSize size=[self calculateSizeForText:[offerDictMain valueForKey:kTempObjDetail]];
        CGRect frame=self.detailText.frame;
        frame.size.height=size.height+10;
        self.detailText.frame=frame;
        return size.height+25;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellHeadingPF]) {
        return 21.0;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellShareView]) {
        return 69.0;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellDirection]){
        return 160.0;
    }
    else//kCellFeatureProduct
    {
        return 80.0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellTabOptions]) {
        if (!detailTabCell) {
            [self initializeDetailTabCell];
        }
        
        //        //Bookmark
        //        if ([[endoreDictMain valueForKey:kTempObjIsBookmarked]isEqualToString:@"YES"]) {
        //            [cell makeBookmarkedPressed:YES];
        //        }
        //        else{
        //            [cell makeBookmarkedPressed:NO];
        //        }
      
        return detailTabCell;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellDirection]) 
    {
        AddressLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addressLocationDetail"];
        
        if(cell == nil){
            cell = [AddressLocationCell addressLocationDetailCell];
            CGRect frame=cell.mapContainerView.frame;
            frame.origin.x=0;
            frame.origin.y=0;
            [self initializeMapToShowInDetailCell];
            _map.frame=frame;
            
            UITapGestureRecognizer * tapGestureForMap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mapHasBeenTapped:)];
            tapGestureForMap.delegate=self;
            
            [cell.mapContainerView addSubview:_map];
            [cell.mapContainerView addGestureRecognizer:tapGestureForMap];
            cell.delegate=self;
            [cell setFontsOfItemsInView];
        }
        [cell.addressTV setTextColor:[UIColor whiteColor]];
        [cell.phoneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cell.priceLbl setTextColor:[UIColor whiteColor]];
        [cell.directionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cell.websiteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cell.backgroundColor=[UIColor clearColor];
        cell.contentView.backgroundColor=[UIColor clearColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellDetailText]) {
        self.detailText.text=[offerDictMain valueForKey:kTempObjDetail];
        self.cellDetailText.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellDetailText;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellHeadingPF]) {
        self.cellHeadingFP.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellHeadingFP;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellShareView]) {
        [self initializeShareView];
        self.cellShareView.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellShareView;
    }
    else//kCellFeatureProduct
    {
        CenterBannerCell * cell=[tableView dequeueReusableCellWithIdentifier:@"centerBannerCell"];
        if (!cell) {
            NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"CenterBannerCell" owner:self options:nil];
            cell=[array objectAtIndex:0];
        }
        
        NSDictionary * dict;
        if(indexPath.row>=(mainArray.count-mainFeaturedProductArray.count)){
            NSInteger ind=(indexPath.row-(mainArray.count-mainFeaturedProductArray.count));
            dict=[mainFeaturedProductArray objectAtIndex:ind];
        }else{
            NSInteger ind=indexPath.row-1;
            dict=[mainFeaturedProductArray objectAtIndex:ind];
        }
        
        cell.objNameLbl.text=[dict valueForKey:kTempObjTitle];
        cell.objDetail.text=[dict valueForKey:kTempObjDetail];
        cell.objDetail.textColor=[UIColor whiteColor];
        cell.objPlaceLbl.text=[dict valueForKey:kTempObjPlace];
        cell.objShopLbl.text=[dict valueForKey:kTempObjShop];
        
        cell.objImgV.image=[UtilsFunctions imageWithImage:[UIImage imageNamed:[dict valueForKey:kTempObjImgName]] scaledToSize:CGSizeMake(cell.objImgV.frame.size.width*2,cell.objImgV.frame.size.height*2)];
        cell.tag=[[dict valueForKey:kTempObjID]integerValue];
        
        if ([[dict valueForKey:kTempObjIsBookmarked]isEqualToString:@"YES"]) {
            [cell makeHearPressed:YES];
        }
        else{
            [cell makeHearPressed:NO];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
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
#pragma mark:AddressLocationCellDelegate
-(void)phoneNumberPressedForCallOnNumber:(NSString *)number{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ABC Shop" message:[NSString stringWithFormat:@"Call %@",number]
                                                       delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Call",nil];
        
    [alert show];
}
-(void)addressPressedToShowMap{
    [self mapHasBeenTapped:nil];
}
-(void)goToWebsitePressedToOpenWebsite{
    WebVC * webVC=[[WebVC alloc]initWithUrl:@"https://www.google.com"];
        [self.navigationController pushViewController:webVC animated:YES];
}
#pragma mark:EDetailActionCellDelegate
-(void)buttonDetailPressed{
    tabOpt=ShowDetailOpt;
    [self loadMainArray];
    [self.tableView reloadData];
}
-(void)buttonCheckinPressed{
    if (tabOpt==ShowDirectionOpt) {
        tabOpt=ShowDetailOpt;
    }
    else{
        tabOpt=ShowDirectionOpt;
    }
    [self loadMainArray];
    [self.tableView reloadData];
}
-(void)buttonSharePressed{
    if (tabOpt==ShowShareOpt) {
        tabOpt=ShowDetailOpt;
    }
    else{
        tabOpt=ShowShareOpt;
    }
    [self loadMainArray];
    [self.tableView reloadData];
}
-(void)buttonOffersPressed{
    if (tabOpt==ShowOffersOpt) {
        tabOpt=ShowDetailOpt;
    }
    else{
        tabOpt=ShowOffersOpt;
    }
    [self loadMainArray];
    [self.tableView reloadData];
}
#pragma mark:EShareViewDelegate
-(void)shareTheEndorsementOnFacebook{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *fbPostSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [fbPostSheet setInitialText:@"This is a Facebook post!"];
        [self presentViewController:fbPostSheet animated:YES completion:nil];
    } else
    {
        ShowMessage(kAppName, @"You can't post right now, make sure your device has an internet connection and you have at least one facebook account setup");
    }
}
-(void)shareTheEndorsementOnTwitter{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"This is a tweet!"];
        [self presentViewController:tweetSheet animated:YES completion:nil];
        
    }
    else
    {
        ShowMessage(kAppName, @"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup");
    }
}
-(void)shareTheEndorsementOnChat{
    
}
-(void)shareTheEndorsementOnSMS{
    MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc] init];
    if ([MFMessageComposeViewController canSendText]) {
        
        NSString *smsString = [offerDictMain valueForKey:kTempObjShop]
        ;
        messageVC.body = smsString;
        
        messageVC.messageComposeDelegate = self;
        [self presentViewController:messageVC animated:YES completion:nil];
    }
    else{
        ShowMessage(kAppName, @"Your device doesn't support SMS!");
    }
}
-(void)shareTheEndorsementOnEmail{
    // Email Subject
    NSString *emailTitle = @"Salam Mobile Invitation ";
    // Email Content
    NSString *messageBody = [offerDictMain valueForKey:kTempObjShop];
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
        ShowMessage(kAppName, @"You can't send email");
    }
}
#pragma mark - MFMessageComposeViewControllerDelegate methods
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            ShowMessage(kAppName, @"Failed to send SMS!");
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

#pragma mark - MKMap View methods

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    if (annotation == mapView.userLocation)
        return nil;
    
    static NSString *MyPinAnnotationIdentifier = @"Pin";
    MKPinAnnotationView *pinView =
    (MKPinAnnotationView *) [self.map dequeueReusableAnnotationViewWithIdentifier:MyPinAnnotationIdentifier];
    if (!pinView){
        MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                                        reuseIdentifier:MyPinAnnotationIdentifier];
        
        annotationView.image = [UIImage imageNamed:@"pin_map_blue"];
        
        return annotationView;
        
    }else{
        
        pinView.image = [UIImage imageNamed:@"pin_map_blue"];
        
        return pinView;
    }
    
    return nil;
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (buttonIndex==0) {
        ShowMapVC * showMapVC=[[ShowMapVC alloc]initWithCoordinatesLong:56.0 ANDLat:10.0 ANDLocationName:@"ABC City"];
        [self.navigationController pushViewController:showMapVC animated:YES];
    }
    else if (buttonIndex==1) {
        ShowGoogleMapVC * showMapVC=[[ShowGoogleMapVC alloc]initWithCoordinatesLong:56.0 ANDLat:10.0 ANDLocationName:@"ABC City"];
        [self.navigationController pushViewController:showMapVC animated:YES];
    }
}
#pragma mark:IBActions and Selectors
-(void)leftNavBarBtnPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightNavBarBtnPressed:(id)sender{
    isBookMarked=!isBookMarked;
    NSString * imgName;
    if (isBookMarked) {
        imgName=@"heart_large_p";
    }
    else{
        imgName=@"heart_large";
    }
    rightItem.image=[[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
-(void)mapHasBeenTapped:(id)sender{
    UIActionSheet * actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Apple Maps",@"Google Maps", nil];
    [actionSheet showInView:self.view];
}
@end
