//
//  OfferDetailVC.m
//  SalamCenterApp
//
//  Created by Globit on 04/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "OfferDetailVC.h"
#import "AppDelegate.h"
#import "NewShopDetailVC.h"
#import "SGActionView.h"
#import "Constants.h"
#import "UtilsFunctions.h"
#import "WebManager.h"
#import "DataManager.h"
#import "MBProgressHUD.h"
#import "Activity.h"
#import "Offer.h"
#import "User.h"
#import "Entity.h"
#import "SDWebImageManager.h"
#import "BannerImage.h"
#import "BannerVC.h"
#import "MBProgressHUD.h"
#import "DetailTextCell.h"


#define kCellImageContainer @"cellImageContainer"
#define kCellOfferTitleHeadline @"cellOfferTitleHeadline"
#define kCellOfferDetailText    @"cellOfferDetailText"
#define kCellHeaderFeaturedProducts     @"cellHeaderFeaturedProducts"
#define kCellFeatureProduct     @"cellFeatureProduct"

@interface OfferDetailVC ()
{
    NSDictionary * offerDictMain;
    NSMutableArray * mainArray;
    NSMutableArray * mainFeaturedProductArray;
    //KIImagePager * imagePager;
    NSString * centerName;
    AppDelegate * appDelegate;
    Entity *entityObject;
    NSMutableArray *bannerImages;
    NSURL * url;
    __weak IBOutlet UIView *shareView;
}
@end

@implementation OfferDetailVC

-(id)initWithOfferCreatedLocally:(NSDictionary *)offerDict ANDCenterName:(NSString*)centername{
    self = [super initWithNibName:@"OfferDetailVC" bundle:nil];
    if (self) {
        offerDictMain=[[NSDictionary alloc]initWithDictionary:offerDict];
        mainArray=[[NSMutableArray alloc]init];
        mainFeaturedProductArray=[[NSMutableArray alloc]init];
        if (centername) {
            centerName=[[NSString alloc]initWithString:centername];
        }
        appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    mainArray = [[NSMutableArray alloc]init];
    mainFeaturedProductArray = [[NSMutableArray alloc]init];
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (self.activityId)
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[WebManager sharedInstance] loadDetailsOfActivity:self.activityId
                 success:^(id response) {
                     [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                     self.activityObject = response;
                     _activityId = nil;
                     [self checkClassAndConfigureActivity];
                     [self.tableView reloadData];
                 } failure:^(NSString *errorString) {
                     [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                     ShowMessage(kAppName,errorString);
                 }];
    }
    else
    {
        [self checkClassAndConfigureActivity];
    }
    //[self dolocalizationText];
    //[self addBanners];
    [self.bgImgV setImage:[UIImage imageNamed:[appDelegate getBackgroundImageName]]];
    self.lblPageTitle.font=[appDelegate getFontOfPageTitle];
    
    [self loadMainArray];
    //[self initializeImagePager];
    //self.pageControl.hidden = YES;
    
    self.tableView.tableFooterView = shareView;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self updateFonts];
}
- (void)checkClassAndConfigureActivity
{
    NSString *title;
    if ([self.activityObject isMemberOfClass:[Activity class]])
    {
        title = [(Activity *)self.activityObject title];
        entityObject = [(Activity *)self.activityObject entityObject];
        self.isOffer = NO;
        url = [NSURL URLWithString:[(Activity*)self.activityObject imageURL]];
    }
    else
    {
        title = [(Offer *)self.activityObject title];
        entityObject = [(Offer *)self.activityObject entityObject];
        self.isOffer = YES;
        url = [NSURL URLWithString:[(Offer*)self.activityObject imageURL]];
    }
    self.lblPageTitle.text = title;
    [self addBanners];
    self.shopNameLbl.text = entityObject.name;
    [self dolocalizationText];
    
    User *user = [[DataManager sharedInstance] currentUser];
    if ([user.favouriteActivities containsObject:self.activityObject] || [user.favouriteOffers containsObject:self.activityObject])
    {
        [self.heartBtn setSelected:YES];
    }
}
-(void)updateFonts{
    [self.lblPageTitle setFont:[UIFont fontWithName:@"Designosaur" size:17.0]];
    [self.shopNameLbl setFont:[UIFont fontWithName:@"Designosaur" size:20.0]];
    [self.shopNameBtn.titleLabel setFont:[UIFont fontWithName:@"Designosaur" size:13.0]];
    [self.lblDetailHeading setFont:[UIFont fontWithName:@"Designosaur" size:17.0]];
    [self.offerDetailTV setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:15.0]];
    [self.lblRelatedOffers setFont:[UIFont fontWithName:@"Designosaur" size:13.0]];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [appDelegate hideBottomTabBar:YES];
    [self.tableView reloadData];
}
-(void)dolocalizationText{
    if (entityObject.entityType && [entityObject.entityType isEqualToString:@"Mall"])
        self.shopNameBtn.hidden = YES;
    else
        self.lblGoToShop.text = [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"Go to", nil),entityObject.entityType? entityObject.entityType:@""];
    self.lblRelatedOffers.text=NSLocalizedString(@"Related Offers", nil);
//    self.lblSharePoints.text=[NSString stringWithFormat:NSLocalizedString(@"%@ pts", nil),@"5"];
//    [self.shareOfferBtn setTitle:NSLocalizedString(@"Share", nil) forState:UIControlStateNormal];
//    [self.shareOfferBtn setTitle:NSLocalizedString(@"Share", nil) forState:UIControlStateHighlighted];
//    [self.shareOfferBtn setTitle:NSLocalizedString(@"Share", nil) forState:UIControlStateSelected];
    self.lblShare.text = [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"Share", nil),NSLocalizedString(_isOffer ? NSLocalizedString(@"Offer",nil):NSLocalizedString(@"News",nil), nil)];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark:Custom Methods
- (void)addBanners
{
    NSArray *banners;
    if (_isOffer)
        banners = [(Offer*)_activityObject banners].allObjects;
    else
        banners = [(Activity*)_activityObject banners].allObjects;
    
    bannerImages = [[NSMutableArray alloc] init];
    for (BannerImage *banner in banners) {
        [bannerImages addObject:banner.imageURL];
    }
    if (bannerImages.count == 0)
    {
        NSString *imageURL;
        if (_isOffer)
            imageURL = [(Offer*)self.activityObject imageURL];
        else
            imageURL = [(Activity*)self.activityObject imageURL];
        
        [bannerImages addObject:imageURL];
    }
    if (bannerImages.count == 0 || bannerImages.count == 1 )
        self.pageControl.hidden = YES;
    else
         [self setUpTimer];
        
    self.pageControl.numberOfPages = bannerImages.count;
//    _viewsArray = [[NSMutableArray alloc] init];
//    for (int i = 0; i<bannerImages.count; i++) {
//        BannerVC *bannerVC = [self viewControllerAtIndex:i];
//        [_viewsArray addObject:bannerVC];
//    }
    [self initializeImagePager];
}
-(void)initializeImagePager{
    
//    imagePager = [[KIImagePager alloc] initWithFrame:CGRectMake(0,64, 320, 198)];
//    imagePager.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    
//    
//    imagePager.indicatorDisabled = YES;
//    
//    imagePager.dataSource=self;//Saad
//    imagePager.delegate=self;//Saad
//    imagePager.slideshowTimeInterval = 3.0;
//    [self.cellImageContainer.contentView addSubview:imagePager];
    
    _pagerView = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    _pagerView.dataSource = self;
    _pagerView.delegate = self;
    _pagerView.view.backgroundColor = [UIColor clearColor];
    [_pagerView.view setFrame:CGRectMake(0, 0, _bannerContainer.frame.size.width, _bannerContainer.frame.size.height)];
    _pagerView.view.userInteractionEnabled = NO;
    BannerVC *initialViewController = [self viewControllerAtIndex:0];
    _currentIndex = 0;
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    [_pagerView setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:_pagerView];
    [_bannerContainer addSubview:_pagerView.view];
    [_pagerView didMoveToParentViewController:self];
   

}
-(BannerVC *)viewControllerAtIndex:(NSUInteger)index {
    
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BannerVC *childVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"BannerVC"];
    childVC.indexNumber = index;
    childVC.imageUrl = bannerImages[index];
    return childVC;
}

-(void)loadMainArray{
    [mainArray removeAllObjects];
    
    [mainArray addObject:kCellImageContainer];
    [mainArray addObject:kCellOfferDetailText];
    //[mainArray addObject:kCellOfferTitleHeadline];
//    [mainArray addObject:kCellHeaderFeaturedProducts];
//    
//    for (int i=0; i<mainFeaturedProductArray.count; i++) {
//        [mainArray addObject:kCellFeatureProduct];
//    }
}
//-(CGSize)calculateSizeForText:(NSString *)txt{
//    
//    CGSize maximumLabelSize = CGSizeMake(290, 600);
//        CGSize expectedSectionSize = [txt sizeWithFont:self.offerDetailTV.font//self.commentView.font
//                                     constrainedToSize:maximumLabelSize
//                                         lineBreakMode:NSLineBreakByTruncatingTail];
//        return expectedSectionSize;
//}
-(CGFloat)calculateHeightForText:(NSString *)txt{
    
    CGSize maximumLabelSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds)-20, 5000);
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    
    CGRect stringRect=[txt boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"MyriadPro-Regular" size:15.0],NSParagraphStyleAttributeName:style} context:nil];
    return stringRect.size.height+20;
}
- (void)setUpTimer
{
    if (self.timer) {
        [self.timer invalidate];
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.6
                                                  target:self
                                                selector:@selector(scrollToNextPage)
                                                userInfo:nil
                                                 repeats:YES];
}
- (void)scrollToNextPage
{
    _currentIndex++;
    if (_currentIndex == bannerImages.count)
        _currentIndex = 0;
    
    self.pageControl.currentPage = _currentIndex;
    BannerVC *vcObject = [self viewControllerAtIndex:_currentIndex];
    NSArray *viewControllers  = [[NSMutableArray alloc] initWithArray:[NSArray arrayWithObject:vcObject]];
    [_pagerView setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}
#pragma mark - PageView Datasource
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(BannerVC *)viewController indexNumber];
    //NSUInteger index = _currentIndex;
    if (index == 0) {
        
        return [self viewControllerAtIndex:bannerImages.count-1];
    }
    index--;
    return [self viewControllerAtIndex:index];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(BannerVC *)viewController indexNumber];
    //NSUInteger index = _currentIndex;
    index++;
    if (index == bannerImages.count) {
        return [self viewControllerAtIndex:0];
    }
    return [self viewControllerAtIndex:index];
}

//-(void)pageViewScroll:(NSUInteger)index andDirection:(UIPageViewControllerNavigationDirection)direction andAnimate:(BOOL)anim {
//    BannerVC *vcObject = [self viewControllerAtIndex:index];
//    NSArray *viewControllers  = [[NSMutableArray alloc] initWithArray:[NSArray arrayWithObject:vcObject]];
//    [_pagerView setViewControllers:viewControllers direction:direction animated:anim completion:nil];
//}

#pragma mark - UITableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellImageContainer]) {
        return 316.0;
    }
    else if([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellOfferTitleHeadline])
    {
        return 80.0;
    }
    else if([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellOfferDetailText])
    {
//        CGSize size=[self calculateSizeForText:self.isOffer?[(Offer*)self.activityObject detailText]:[(Activity*)self.activityObject detailText]];
//        CGRect frame=self.offerDetailTV.frame;
//        frame.size.height=size.height+30;
//        self.offerDetailTV.frame=frame;
//        int offset = 25;
//        if (size.height>15)
//            offset = 48+30;
//        return size.height+offset;//+40;
        CGFloat height = [self calculateHeightForText:self.isOffer?[(Offer*)self.activityObject detailText]:[(Activity*)self.activityObject detailText]];
        if ([[(Activity*)self.activityObject title] isEqualToString:@"Madoplevelser på museet"])
            return height+200;
        return height+20;
//        return 170.0;

    }
    else if([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellHeaderFeaturedProducts])
    {
        return 24.0;
    }
    else//kCellFeatureProduct
    {
        return 120.0;//80.0;
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
    if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellImageContainer]) {
        self.cellImageContainer.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellImageContainer;
    }
    else if([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellOfferTitleHeadline])
    {
        self.cellOfferTitleHeadline.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellOfferTitleHeadline;
    }
    else if([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellOfferDetailText])
    {
        
        NSString *detailText = self.isOffer?[(Offer*)self.activityObject detailText]:[(Activity*)self.activityObject detailText];
        
        DetailTextCell * cell=[tableView dequeueReusableCellWithIdentifier:@"DetailTextCell"];
        if (!cell) {
            NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"DetailTextCell" owner:self options:nil];
            cell=[array objectAtIndex:0];
        }
        if ([[(Activity*)self.activityObject title] isEqualToString:@"Madoplevelser på museet"])
            [cell setDetailTextHeight:[self calculateHeightForText:detailText] +200];
        else
            [cell setDetailTextHeight:[self calculateHeightForText:detailText]];
        cell.detailTextView.text = detailText;
        return cell;

//        self.detailTextHeightConstraint.constant = [self calculateHeightForText:detailText];
//        [self.cellOfferDetailText.contentView setNeedsLayout];
//        [self.cellOfferDetailText.contentView layoutIfNeeded];
//         self.offerDetailTV.text = detailText;
//        
//        self.cellOfferDetailText.selectionStyle=UITableViewCellSelectionStyleNone;
//        return self.cellOfferDetailText;
    }
    else if([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellHeaderFeaturedProducts])
    {
        self.cellHeaderFeaturedProducts.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellHeaderFeaturedProducts;
    }
    else//kCellFeatureProduct
    {
        CenterBannerCell * cell=[tableView dequeueReusableCellWithIdentifier:@"centerBannerCell"];
        if (!cell) {
            NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"CenterBannerCell" owner:self options:nil];
            cell=[array objectAtIndex:0];
        }
        
//        NSDictionary * dict;
//        if(indexPath.row>=(mainArray.count-mainFeaturedProductArray.count)){
//            dict=[mainFeaturedProductArray objectAtIndex:(indexPath.row-(mainArray.count-mainFeaturedProductArray.count))];
//        }
//        
//        cell.objNameLbl.text=[dict valueForKey:kTempObjTitle];
//        cell.objDetail.text=[dict valueForKey:kTempObjDetail];
////        cell.objDetail.textColor=[UIColor whiteColor];
//        cell.objPlaceLbl.text=[dict valueForKey:kTempObjPlace];
//        cell.objShopLbl.text=[dict valueForKey:kTempObjShop];
//        
//        cell.objImgV.image=[UtilsFunctions imageWithImage:[UIImage imageNamed:[dict valueForKey:kTempObjImgName]] scaledToSize:CGSizeMake(cell.objImgV.frame.size.width*2,cell.objImgV.frame.size.height*2)];
//        [self makeUIImageViewRoundedLeftSide:cell.objImgV ANDRadiues:3.0 ANDTableViewCell:cell];
//        cell.tag=[[dict valueForKey:kTempObjID]integerValue];
//        
//        if ([[dict valueForKey:kTempObjIsBookmarked]isEqualToString:@"YES"]) {
//            [cell makeHearPressed:YES];
//        }
//        else{
//            [cell makeHearPressed:NO];
//        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath :(NSIndexPath *)indexPath{
//    OfferDetailVC *offerDetailVC = [[OfferDetailVC alloc] init];
//    offerDetailVC.activityObject = self.activityObject;
//    [self.navigationController pushViewController:offerDetailVC animated:YES];
//    if(indexPath.row>=(mainArray.count-mainFeaturedProductArray.count)){
//        OfferDetailVC * offerDetailVC=[[OfferDetailVC alloc]initWithOfferCreatedLocally:[mainFeaturedProductArray objectAtIndex:(indexPath.row-(mainArray.count-mainFeaturedProductArray.count))] ANDCenterName:centerName];
//        [self.navigationController pushViewController:offerDetailVC animated:YES];
//    }
}
//#pragma mark - KIImagePager DataSource
//- (NSArray *) arrayWithImages
//{
////    NSURL * url = [NSURL URLWithString:self.isOffer?[(Offer*)self.activityObject imageURL]:[(Activity*)self.activityObject imageURL]];
//    //return [NSArray arrayWithObject:[[SDWebImageManager sharedManager] imageWithURL:url]];
//    return [NSArray arrayWithArray:bannerImages];
//}
//- (UIImage *) placeHolderImageForImagePager
//{
//    return [UIImage imageNamed:@"place-holder"];
//}
//- (UIViewContentMode) contentModeForImage:(NSUInteger)image
//{
//    return UIViewContentModeScaleToFill;
//}
//
//- (NSString *) captionForImageAtIndex:(NSUInteger)index
//{
//    return nil;
//}
//
//#pragma mark - KIImagePager Delegate
//- (void) imagePager:(KIImagePager *)imagePager didScrollToIndex:(NSUInteger)index
//{
//    self.pageControl.currentPage = index;
////    NSLog(@"%s %lu", __PRETTY_FUNCTION__, (unsigned long)index);
//}
//
//- (void) imagePager:(KIImagePager *)imagePager didSelectImageAtIndex:(NSUInteger)index
//{
////    NSLog(@"%s %lu", __PRETTY_FUNCTION__, (unsigned long)index);
//}
#pragma mark: SGShareView
-(NSString*) createShareString
{
    NSString *title;
    NSString *messageBody;
    if (self.isOffer)
    {
        title = [(Offer *)self.activityObject title];
        messageBody = [(Offer *)self.activityObject briefText];
    }
    else
    {
        title = [(Activity *)self.activityObject title];
        messageBody = [(Activity *)self.activityObject briefText];
    }
    NSString * message = [NSString stringWithFormat:@"Mall App:%@: %@",title,messageBody];
    return message;
}
//-(void)showSGShareView{
//    [SGActionView sharedActionView].style=SGActionViewStyleDark;
//    SGMenuActionHandler handler=^(NSInteger index){
//        NSLog(@"selected index= %li",(long)index);
//        [self.shareOfferBtn setSelected:NO];
//        switch (index) {
//            case 1:
//                [self shareTheOfferOnFacebook];
//                break;
//            case 2:
//                [self shareTheOfferOnTwitter];
//                break;
//            case 3:
//                [self shareTheOfferOnSMS];
//                break;
//            case 4:
//                [self shareTheOfferOnEmail];
//                break;
//                
//            default:
//                break;
//        }
//    };
//    [SGActionView showGridMenuWithTitle:@"Share Offer"
//                             itemTitles:@[ @"Facebook", @"Twitter", @"SMS", @"Email"]
//                                 images:@[ [UIImage imageNamed:@"share-facebook-button"],
//                                           [UIImage imageNamed:@"share-twitter-button"],
//                                           [UIImage imageNamed:@"share-sms-button"],
//                                           [UIImage imageNamed:@"share-email-button"]]
//                         selectedHandle:handler];
//}
-(void)shareTheOfferOnFacebook{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *fbPostSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
       
        [fbPostSheet addImage:[[SDWebImageManager sharedManager] imageWithURL:url]];
        
        [fbPostSheet setInitialText:[self createShareString]];
        
        [self presentViewController:fbPostSheet animated:YES completion:nil];
    } else
    {
        ShowMessage(kAppName,NSLocalizedString(@"You can't post right now, make sure your device has an internet connection and you have at least one facebook account setup", nil));
    }
}
-(void)shareTheOfferOnTwitter{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        [tweetSheet addImage:[[SDWebImageManager sharedManager] imageWithURL:url]];
        [tweetSheet setInitialText:[self createShareString]];

        [self presentViewController:tweetSheet animated:YES completion:nil];
        
    }
    else
    {
        ShowMessage(kAppName,NSLocalizedString(@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup", nil));
    }
}
-(void)shareTheOfferOnSMS{
    MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc] init];
    if ([MFMessageComposeViewController canSendText]) {
        
//        NSString *smsString;
//        if (self.isOffer)
//            smsString = [(Offer *)self.activityObject title];
//        else
//            smsString = [(Activity *)self.activityObject title];
        ;
        messageVC.body = [self createShareString];
        
        messageVC.messageComposeDelegate = self;
        [self presentViewController:messageVC animated:YES completion:nil];
    }
    else{
        ShowMessage(kAppName,NSLocalizedString(@"Your device doesn't support SMS!", nil));
    }
}
-(void)shareTheOfferOnEmail{
    // Email Subject
    NSString *emailTitle;
    NSString *messageBody;
    if (self.isOffer)
    {
        emailTitle = [(Offer *)self.activityObject title];
        messageBody = [(Offer *)self.activityObject detailText];
    }
    else
    {
        emailTitle = [(Activity *)self.activityObject title];
        messageBody = [(Activity *)self.activityObject detailText];
    }
    

    //= @"The Mall App Mobile Invitation";
    // Email Content

    // To address
    //    NSArray *toRecipents = [NSArray arrayWithObject:@"support@appcoda.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    if ([MFMailComposeViewController canSendMail]) {
        mc.mailComposeDelegate = self;
        [mc setSubject:[NSString stringWithFormat:@"Mall App:%@",emailTitle]];
        [mc setMessageBody:messageBody isHTML:NO];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
    }
    else{
        ShowMessage(kAppName,NSLocalizedString(@"You can't send email", nil));
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

#pragma mark:IBActions and Selectors
- (IBAction)shareBtnAction:(id)sender {
//    [self.shareOfferBtn setSelected:!self.shareOfferBtn.selected];
//    [self showSGShareView];
}

- (IBAction)backBtnAction:(id)sender {
    [self.backBtn setSelected:YES];    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)heartBtnPressed:(id)sender {
    [self.heartBtn setSelected:!self.heartBtn.selected];
    NSString *activityId;
    if (!self.isOffer)
        activityId = [(Activity *)self.activityObject activityId];
    else
        activityId = [(Offer *)self.activityObject activityId];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (self.heartBtn.selected)
    {
        [[WebManager sharedInstance] markActivity:activityId favouriteDeleted:NO
                                          success:^(id response) {
              [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
              if (response!= nil)
              {
                  User *user = [[DataManager sharedInstance] currentUser];
                  if (self.isOffer)
                  {
                      [user addFavouriteOffersObject:self.activityObject];
                      ShowMessage(kAppName, NSLocalizedString(@"This offer added to your favourities", nil));
                  }
                  else
                  {
                      [user addFavouriteActivitiesObject:self.activityObject];
                      ShowMessage(kAppName, NSLocalizedString(@"This news added to your favourities", nil));
                  }
                  [[DataManager sharedInstance] saveContext];
              }
          } failure:^(NSString *errorString) {
              [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
              ShowMessage(kAppName,errorString);
          }];
    }
    else
    {
        [[WebManager sharedInstance] markActivity:activityId favouriteDeleted:YES
                                          success:^(id response) {
              [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
              if (response!= nil)
              {
                  User *user = [[DataManager sharedInstance] currentUser];
                  if (self.isOffer)
                  {
                      [user removeFavouriteOffersObject:self.activityObject];
                      ShowMessage(kAppName, NSLocalizedString(@"This offer removed from your favourities", nil));
                  }
                  else
                  {
                      [user removeFavouriteActivitiesObject:self.activityObject];
                      ShowMessage(kAppName, NSLocalizedString(@"This news removed from your favourities", nil));
                  }
                  [[DataManager sharedInstance] saveContext];
                  
              }
          } failure:^(NSString *errorString) {
              [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
              ShowMessage(kAppName,errorString);
          }];
    }
}

- (IBAction)shopBtnPressed:(id)sender {
    if (_isFromEntity)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        NewShopDetailVC * shopDetailVC=[[NewShopDetailVC alloc]initWithOfferCreatedLocally:offerDictMain ANDCenterName:centerName];
       
        Entity *entity;
        if (self.isOffer)
            entity = [(Offer *)self.activityObject entityObject];
        else
            entity = [(Activity *)self.activityObject entityObject];

        if ([entity.entityType isEqualToString:@"Shop"])
        {
            Shop *shop = [[DataManager sharedInstance] shopWithId:entity.entityId];
            shop.name = entity.name;
            shopDetailVC.shop = shop;
            shopDetailVC.isForShop = YES;
            [self.navigationController pushViewController:shopDetailVC animated:YES];
        }
        else if ([entity.entityType isEqualToString:@"Restaurant"])
        {
            Restaurant *restaurant = [[DataManager sharedInstance] restaurantWithId:entity.entityId];
            restaurant.name = entity.name;
            shopDetailVC.restaurant = restaurant;
            shopDetailVC.isForRestaurent = YES;
            [self.navigationController pushViewController:shopDetailVC animated:YES];

        }
    }
}
#pragma mark-Sharing IBActions
- (IBAction)facebookTapped:(id)sender {
    [self shareTheOfferOnFacebook];
    
}
- (IBAction)twitterTapped:(id)sender {
    [self shareTheOfferOnTwitter];
}
- (IBAction)smsTapped:(id)sender {
    [self shareTheOfferOnSMS];
}
- (IBAction)emailTapped:(id)sender {
    [self shareTheOfferOnEmail];
}

@end
