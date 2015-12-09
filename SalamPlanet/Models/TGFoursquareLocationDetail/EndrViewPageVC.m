//
//  EndrViewPageVC.m
//  TGFoursquareLocationDetail-Demo
//
//  Created by Thibault Guégan on 15/12/2013.
//  Copyright (c) 2013 Thibault Guégan. All rights reserved.
//

#import "EndrViewPageVC.h"
#import "Constants.h"
#import "AppDelegate.h"
#import "UtilsFunctions.h"
#import "CenterBannerCell.h"

@interface EndrViewPageVC ()
{
    NSDictionary * endoreDictMain;
    NSDictionary * userDictMain;
    NSMutableArray * mainArray;
    NSMutableArray * mainPicturesArray;
    NSMutableArray * mainFeaturedProductArray;
    BOOL showDetailCell;
    BOOL showRatingDetailCell;
    BOOL showShareViewCell;
    BOOL showShareViewCellForCell;
    NSInteger shareViewCellIndex;
    AppDelegate * appDelegate;
    EShareView * shareView;
}
@end

@implementation EndrViewPageVC


-(id)initWithEndorsementCreatedLocally:(NSDictionary *)edoreDict{
    self = [super initWithNibName:@"EndrViewPageVC" bundle:nil];
    if (self) {
        endoreDictMain=[[NSDictionary alloc]initWithDictionary:edoreDict];
        [self loadUserData];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //My Initiallizations
    appDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    mainArray=[[NSMutableArray alloc]init];
    mainPicturesArray=[[NSMutableArray alloc]init];
    mainFeaturedProductArray=[[NSMutableArray alloc]init];
    
    [self loadMainArray];
    [self loadMainPicturesArray];
    [self loadFeaturedProductsArrayWithDummy];
    //end
    
	
    self.locationDetail = [[TGFoursquareLocationDetail alloc] initWithFrame:self.view.bounds];
    //Making the array of users temprly
    NSMutableArray *tempUserArray=[[NSMutableArray alloc]init];

    for (int i=0; i<mainPicturesArray.count; i++) {
        NSMutableDictionary * dict=[[NSMutableDictionary alloc]initWithDictionary:userDictMain];
//        [dict setObject:[endoreDictMain valueForKey:kTempEndrDate] forKey:kTempEndrDate];
        [tempUserArray addObject:dict];
    }
    [self.locationDetail loadDataWithUserArray:tempUserArray ANDPicturesArray:mainPicturesArray];

    self.locationDetail.tableViewDataSource = self;
    self.locationDetail.tableViewDelegate = self;

    self.locationDetail.delegate = self;
    self.locationDetail.parallaxScrollFactor = 0.3; // little slower than normal.
    
    [self.view addSubview:self.locationDetail];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self.view bringSubviewToFront:_headerView];
    
    self.topView.frame=CGRectMake(0, 0, self.topView.frame.size.width, self.topView.frame.size.height);
    [self.view addSubview:self.topView];
    
    self.locationDetail.headerView = _headerView;
    
    [self loadDataOnView];
    showDetailCell=NO;
    showRatingDetailCell=NO;
    showShareViewCell=NO;
    showShareViewCellForCell=NO;
    shareViewCellIndex=0;
    
    [self initializeMapToShowInDetailCell];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [appDelegate hideBottomTabBar:YES];
}
#pragma mark:Custom Methods By Me
-(void)updateTheViewColorSchemeAccordingToCenter{
    UIColor * color=[appDelegate getTheColorAccordingToCenterName:[endoreDictMain valueForKey:kTempObjCategory]];
    [self.topView setBackgroundColor:color];
}
-(void)loadUserData{
    NSData * savedObject=GetDataWithKey(kUserCreatedLocally);
    NSDictionary * dictnry=[NSKeyedUnarchiver unarchiveObjectWithData:savedObject];
    userDictMain=[[NSDictionary alloc]initWithDictionary:dictnry];
}
-(void)loadMainArray{
    [mainArray removeAllObjects];
    
    [mainArray addObject:kObjTabBarCell];
    if(showDetailCell){
        [mainArray addObject:kObjShopDetailCell];
    }
    if (showShareViewCell) {
        [mainArray addObject:kObjShareCell];
    }
    [mainArray addObject:kObjDetailCell];

    [mainArray addObject:kObjFeaturedProductHeadingCell];
    [mainArray addObject:kObjFeaturedProductCellOne];
    [mainArray addObject:kObjFeaturedProductCellTwo];
    [mainArray addObject:kObjFeaturedProductCellThree];
}
-(void)loadMainPicturesArray{
    NSString * imgName=[endoreDictMain valueForKey:kTempObjImgName];
    UIImage *img=[UIImage imageNamed:imgName];
    img=[UtilsFunctions imageWithImage:img scaledToSize:CGSizeMake(320*2, 300*2)];
    [mainPicturesArray addObject:img];
}
-(void)loadFeaturedProductsArrayWithDummy{
    [mainFeaturedProductArray removeAllObjects];
    
    NSArray * savedObjects=GetArrayWithKey(kArrayEndorsementCreatedLocally);
    for (NSData * item in savedObjects) {
        NSDictionary * dictnry=[NSKeyedUnarchiver unarchiveObjectWithData:item];
        [mainFeaturedProductArray addObject:dictnry];
    }
}
-(void)loadDataOnView{
    
    [self.endrTitleLbl setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:18.0f]];
    [self.catSubCatLbl setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:11.0f]];
    [self.tagLbl setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:11.0f]];
    
    if([endoreDictMain valueForKey:kTempEndrName]){
        self.endrTitleLbl.text=[endoreDictMain valueForKey:kTempEndrName];
    }
    if([endoreDictMain valueForKey:kTempEndrCategory] && [endoreDictMain valueForKey:kTempEndrSubCategory]){
        self.catSubCatLbl.text=[NSString stringWithFormat:@"%@,%@",[endoreDictMain valueForKey:kTempEndrCategory],[endoreDictMain valueForKey:kTempEndrSubCategory]];
    }
    if ([endoreDictMain valueForKey:kTempEndrTagString]) {
        self.tagLbl.text=[endoreDictMain valueForKey:kTempEndrTagString];
        CGSize size=[self calculateSizeForText:[endoreDictMain valueForKey:kTempEndrTagString]];
        if (size.height>18) {
            self.tagLbl.frame=CGRectMake(self.tagLbl.frame.origin.x, self.tagLbl.frame.origin.y, self.tagLbl.frame.size.width, size.height);
        }
    }
}
-(void)mapHasBeenTapped:(id)sender{
    UIActionSheet * actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Apple Maps",@"Google Maps", nil];
    [actionSheet showInView:self.view];
}
-(CGSize)calculateSizeForText:(NSString *)txt{
    
    CGSize maximumLabelSize = CGSizeMake(300, 600);
    CGSize expectedSectionSize = [txt sizeWithFont:self.detailText.font//self.commentView.font
                                 constrainedToSize:maximumLabelSize
                                     lineBreakMode:NSLineBreakByTruncatingTail];
    return expectedSectionSize;
}
-(void)makeCallFromPhoneWithNumber:(NSString *)phNo{
    NSString *urlString = [NSString stringWithFormat:@"tel:%@",phNo];
    NSString *escaped = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:escaped]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:escaped]];
    } else
    {
        ShowMessage(kAppName, @"Call facility is not available!!!");
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
-(void)initializeShareView{
    if (!shareView) {
        shareView=[[EShareView alloc]init];
        shareView.frame=self.cellShowShareView.contentView.frame;
        shareView.delegate=self;
        [self.cellShowShareView.contentView addSubview:shareView];
        self.cellShowShareView.selectionStyle=UITableViewCellSelectionStyleNone;
    }
}
#pragma mark - UITableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%li",(long)indexPath.row);
    if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kObjTabBarCell]) {
        return 38.0;
    }
    else if([[mainArray objectAtIndex:indexPath.row]isEqualToString:kObjShopDetailCell])
    {
            return 160.0;
    }
    else if([[mainArray objectAtIndex:indexPath.row]isEqualToString:kObjShareCell])
    {
        return 69.0;
    }
    else if([[mainArray objectAtIndex:indexPath.row]isEqualToString:kObjFeaturedProductHeadingCell])
    {
        return 21.0;
    }
    else if([[mainArray objectAtIndex:indexPath.row]isEqualToString:kObjDetailCell])
    {
//        return 140.0;
        CGSize size=[self calculateSizeForText:[endoreDictMain valueForKey:kTempObjDetail]];
        CGRect frame=self.detailText.frame;
        frame.size.height=size.height+10;
        self.detailText.frame=frame;
        return size.height+20;

    }
    else
    {
        return 80;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mainArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kObjTabBarCell]) {
        EDetailActionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eDetailAction"];
        
        if(cell == nil){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"EDetailActionCell" owner:self options:nil] objectAtIndex:0];
        }
        [cell setButtonViewsAccordingToOptionisPlace:NO];
    
        //Bookmark
        if ([[endoreDictMain valueForKey:kTempObjIsBookmarked]isEqualToString:@"YES"]) {
//            [cell makeBookmarkedPressed:YES];
        }
        else{
//            [cell makeBookmarkedPressed:NO];
        }
        cell.delegate=self;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if([[mainArray objectAtIndex:indexPath.row]isEqualToString:kObjShareCell]){
        [self initializeShareView];
        return self.cellShowShareView;
    }
    else if([[mainArray objectAtIndex:indexPath.row]isEqualToString:kObjShopDetailCell]){
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
            if ([[endoreDictMain valueForKey:kTempEndrCategory]isEqualToString:kBookCategory] || [[endoreDictMain valueForKey:kTempEndrCategory]isEqualToString:kMovieCategory] || [[endoreDictMain valueForKey:kTempEndrCategory]isEqualToString:kMusicCategory]) {
                //don't add map
            }
            else{
                [cell.mapContainerView addSubview:_map];
                [cell.mapContainerView addGestureRecognizer:tapGestureForMap];
            }
            cell.delegate=self;
            [cell setFontsOfItemsInView];
        }

        return cell;
    }
    else if([[mainArray objectAtIndex:indexPath.row]isEqualToString:kObjFeaturedProductHeadingCell]){
        self.cellOverallRatingInfo.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellOverallRatingInfo;
    }
    else if([[mainArray objectAtIndex:indexPath.row]isEqualToString:kObjDetailCell])
    {
        self.headingTitle.text=[endoreDictMain valueForKey:kTempObjTitle];
        self.detailText.text=[endoreDictMain valueForKey:kTempObjDetail];
        self.cellOfferDetailText.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellOfferDetailText;
    }
    else{
        CenterBannerCell * cell=[tableView dequeueReusableCellWithIdentifier:@"centerBannerCell"];
        if (!cell) {
            NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"CenterBannerCell" owner:self options:nil];
            cell=[array objectAtIndex:0];
        }
        
        NSDictionary * dict;
        if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kObjFeaturedProductCellOne]) {
            dict=[mainFeaturedProductArray objectAtIndex:0];
        }
        else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kObjFeaturedProductCellTwo]) {
            dict=[mainFeaturedProductArray objectAtIndex:1];
        }
        else{
            dict=[mainFeaturedProductArray objectAtIndex:2];
        }

        cell.objNameLbl.text=[dict valueForKey:kTempObjTitle];
        cell.objDetail.text=[dict valueForKey:kTempObjDetail];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kEndrDetailOverallRatingInfoCell]) {
        if (showRatingDetailCell) {
            showRatingDetailCell=NO;
        }
        else{
            showRatingDetailCell=YES;
        }
        [self loadMainArray];
        [self.locationDetail.tableView reloadData];
    }
    if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kObjFeaturedProductCellOne]) {
        EndrViewPageVC *endoreVC=[[EndrViewPageVC alloc]initWithEndorsementCreatedLocally:[mainFeaturedProductArray objectAtIndex:0]];
        [self.navigationController pushViewController:endoreVC animated:YES];
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kObjFeaturedProductCellTwo]) {
        EndrViewPageVC *endoreVC=[[EndrViewPageVC alloc]initWithEndorsementCreatedLocally:[mainFeaturedProductArray objectAtIndex:1]];
        [self.navigationController pushViewController:endoreVC animated:YES];
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kObjFeaturedProductCellThree]) {
        EndrViewPageVC *endoreVC=[[EndrViewPageVC alloc]initWithEndorsementCreatedLocally:[mainFeaturedProductArray objectAtIndex:2]];
        [self.navigationController pushViewController:endoreVC animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    cell.contentView.backgroundColor = [UIColor whiteColor];
}

#pragma mark - TGFoursquareLocationDetailDelegate

- (void)locationDetail:(TGFoursquareLocationDetail *)locationDetail imagePagerDidLoad:(KIImagePager *)imagePager
{
//    imagePager.dataSource = self;//Saad
//    imagePager.delegate = self;//Saad
    imagePager.pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
    imagePager.pageControl.pageIndicatorTintColor = [UIColor blackColor];
    imagePager.slideshowTimeInterval = 0.0f;
    imagePager.slideshowShouldCallScrollToDelegate = YES;
    
    self.locationDetail.nbImages = (int)[self.locationDetail.imagePager.dataSource.arrayWithImages count];
    self.locationDetail.currentImage = 0;
    //[imagePager updateCaptionLabelForImageAtIndex:self.locationDetail.currentImage];
}

- (void)locationDetail:(TGFoursquareLocationDetail *)locationDetail tableViewDidLoad:(UITableView *)tableView
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)locationDetail:(TGFoursquareLocationDetail *)locationDetail headerViewDidLoad:(UIView *)headerView
{
    [headerView setAlpha:0.0];
    [headerView setHidden:YES];
}
-(void)hideShowTheTitleView:(BOOL)show{
    [self.topView setHidden:!show];
}
-(void)topViewHasBeenAppearDisappear:(BOOL)appear{
    [self.catSubCatLbl setHidden:appear];
    [self.tagLbl setHidden:appear];
    [self.headerBGView setHidden:appear];
}
-(void)gotoUserProfileViewForUser{
    UserProfileVC * userProfileVC=[[UserProfileVC alloc]init];
    [self.navigationController pushViewController:userProfileVC animated:YES];
}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (buttonIndex==0) {
        ShowMapVC * showMapVC=[[ShowMapVC alloc]initWithCoordinatesLong:56.0 ANDLat:10.0 ANDLocationName:[endoreDictMain valueForKey:kTempEndrName]];
        [self.navigationController pushViewController:showMapVC animated:YES];
    }
    else if (buttonIndex==1) {
//        ShowGoogleMapVC * showMapVC=[[ShowGoogleMapVC alloc]initWithCoordinatesLong:56.0 ANDLat:10.0 ANDLocationName:[endoreDictMain valueForKey:kTempEndrName]];
//        [self.navigationController pushViewController:showMapVC animated:YES];
    }
}

#pragma mark:UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:
(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
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
#pragma mark:AddressLocationCellDelegate
-(void)phoneNumberPressedForCallOnNumber:(NSString *)number{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[endoreDictMain valueForKey:kTempEndrName] message:[NSString stringWithFormat:@"Call %@",number]
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
#pragma mark:UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        [self makeCallFromPhoneWithNumber:@"042376889237"];
    }
}
#pragma mark:EDetailActionCellDelegate
-(void)buttonDetailPressed{
    if (showShareViewCell) {
        showShareViewCell=NO;
    }
    if (showDetailCell) {
        showDetailCell=NO;
        [self loadMainArray];
    }
    else{
        showDetailCell=YES;
        [self loadMainArray];
    }
    [self.locationDetail.tableView reloadData];
}
-(void)buttonCheckinPressed{

}
-(void)buttonBookmarkPressed:(BOOL)isBM{
    NSMutableArray * tempArray=[[NSMutableArray alloc]init];
    [tempArray removeAllObjects];
    NSArray * savedObjects=GetArrayWithKey(kArrayEndorsementCreatedLocally);
    for (NSData * item in savedObjects) {
        NSDictionary * dictnry=[NSKeyedUnarchiver unarchiveObjectWithData:item];
        [tempArray addObject:dictnry];
    }

    if(isBM){
        for (NSDictionary * dict in tempArray) {
            if ([[dict valueForKey:kTempObjID]integerValue]==[[endoreDictMain valueForKey:kTempObjID]integerValue]) {
                [dict setValue:@"YES" forKey:kTempObjIsBookmarked];
                break;
            }
        }
        [UtilsFunctions saveAllEndorsementArrayInUserDefaults:tempArray];
        ShowMessage(kAppName, @"This endorsement have been saved");
    }
    else{
        for (NSDictionary * dict in tempArray) {
            if ([[dict valueForKey:kTempObjID]integerValue]==[[endoreDictMain valueForKey:kTempObjID]integerValue]) {
                [dict setValue:@"NO" forKey:kTempObjIsBookmarked];
                break;
            }
        }
        [UtilsFunctions saveAllEndorsementArrayInUserDefaults:tempArray];
        ShowMessage(kAppName, @"This endorsement have been unsaved");
    }

}
-(void)buttonSharePressed{
    if (showShareViewCellForCell) {
        showShareViewCellForCell=NO;
    }
    if (showDetailCell) {
        showDetailCell=NO;
    }
    if (showShareViewCell) {
        showShareViewCell=NO;
        [self loadMainArray];
    }
    else{
        showShareViewCell=YES;
        [self loadMainArray];
    }
    [self.locationDetail.tableView reloadData];
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
        
        NSString *smsString = [endoreDictMain valueForKey:kTempEndrName]
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
    NSString *messageBody = [endoreDictMain valueForKey:kTempEndrName];
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
#pragma mark:EndorsementCellDelegate
-(void)goToSeeComments{
    EndrCommentsViewController * endrCmtVC=[[EndrCommentsViewController alloc]initWithEndrDictMain:endoreDictMain ANDEndrUserMain:userDictMain];
    [self.navigationController pushViewController:endrCmtVC animated:YES];
    
}
-(void)goToLikeEndr{
    
}
-(void)goToChat
{
    DemoChatViewController * chatVC=[[DemoChatViewController alloc]initWithEndorsementCreatedLocally:endoreDictMain];
    [self.navigationController pushViewController:chatVC animated:YES];
}
-(void)shareEndore{
    if (showShareViewCell) {
        showShareViewCell=NO;
    }
    shareViewCellIndex=0;
    if (showShareViewCellForCell) {
        showShareViewCellForCell=NO;
    }
    else{
        showShareViewCellForCell=YES;
    }
    [self loadMainArray];
    [self.locationDetail.tableView reloadData];

}
-(void)goToUserProfileAction{
    UserProfileVC * userProfileVC=[[UserProfileVC alloc]init];
    [self.navigationController pushViewController:userProfileVC animated:YES];
}
#pragma mark - Button actions
- (IBAction)backBtnAction:(id)sender {
    [self.backBtn setSelected:YES];    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
