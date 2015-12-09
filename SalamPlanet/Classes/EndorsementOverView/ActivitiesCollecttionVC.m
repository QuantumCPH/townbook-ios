    //
//  ECollecttionVCViewController.m
//  SalamPlanet
//
//  Created by Globit on 21/10/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "ActivitiesCollecttionVC.h"
#import "ODRefreshControl.h"
#import "EndrViewPageVC.h"
#import "OfferDetailVC.h"
#import "NewShopDetailVC.h"
#import "MainObject.h"
//#import "ShopDetailVC.h"
#import "AppDelegate.h"
#import "UtilsFunctions.h"
#import "Constants.h"
#import "MallCenter.h"
#import "Entity.h"
#import "Activity.h"
#import "Offer.h"
#import "UIImageView+WebCache.h"
#import "WebManager.h"
#import "MBProgressHUD.h"
#import "User.h"
#import "DataManager.h"
#import "Constants.h"
#import "NSMutableArray+Unique.h"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
@interface ActivitiesCollecttionVC ()
{
    //NSMutableArray * mainArray;
    NSMutableArray * mainArrayNews;
    NSMutableArray * mainArrayOffers;
  

    AppDelegate * appDelegate;
    ODRefreshControl * refreshControl;
    
    NSString * placeType;
    NSDateFormatter *dateFormatter;
}
@end

@implementation ActivitiesCollecttionVC
@synthesize audianceSegment;
@synthesize mainArray;
@synthesize pageMall;

-(id)initWithMall:(MallCenter *)mall ANDAudianceType:(AudianceType)aType{
    self = [super initWithNibName:@"ActivitiesCollecttionVC" bundle:nil];
    if (self) {
        //placeType=[[NSString alloc]initWithString:place];
        pageMall = mall;
        audianceSegment=aType;
        mainArray=[[NSMutableArray alloc]init];
        mainArrayNews=[[NSMutableArray alloc]init];
        mainArrayOffers=[[NSMutableArray alloc]init];
        
        appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self dolocalizationText];
    [self.bgImgV setImage:[UIImage imageNamed:[appDelegate getBackgroundImageName]]];
    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.tableView setContentInset:UIEdgeInsetsMake(10,0,10,0)];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];

    [self addRefreshControlInCollectionView];
    [self updateTheViewColorSchemeAccordingToCenter];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endRefreshControl) name:kAcitivitesReloadedNotification object:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    [self loadMainArrayWithDummyData];
//    [self loadUserData];
    [self.tableView reloadData];
    
}
-(void)dolocalizationText{
    self.lblNoNewUpdates.text=NSLocalizedString(@"No updates", nil);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)reloadActivities
{
    ActivitiesMainVC *vc = (ActivitiesMainVC *)self.parentViewController;
    [vc showProgressView];
    _isLoading = YES;
    [[WebManager sharedInstance] getOffersListPageNumber:_pageNumber forMall:nil success:^(NSArray *resultArray,int totalRecords) {
        [vc hideProgressView];
        _isLoading = NO;
        _totalRecords = totalRecords;
        [self.mainArray addObjectsFromArray:resultArray];
        [self doFiltrationOnPaginatedDataArray:resultArray];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [vc hideProgressView];
        ShowMessage(kAppName,[error localizedDescription]);
    }];
}
- (void)doFiltrationOnPaginatedDataArray:(NSArray *)resultArray
{
    if(audianceSegment == Offers)
    {
        NSPredicate * customPredicate = [NSPredicate predicateWithFormat:@"self isKindOfClass: %@",[Offer class]];
        NSArray * offers = [resultArray filteredArrayUsingPredicate:customPredicate];
        [mainArrayOffers addObjectsFromArray:offers excludingDuplicates:YES];
    }
    else if (audianceSegment == News)
    {
        NSPredicate * customPredicate = [NSPredicate predicateWithFormat:@"self isMemberOfClass: %@",[Activity class]];
        NSArray * news = [resultArray filteredArrayUsingPredicate:customPredicate];
        [mainArrayNews addObjectsFromArray:news excludingDuplicates:YES];
    }
}
#pragma mark:Parent View Methods
-(void)doActionOnAudienceSegmentChange:(AudianceType)newAudience{
    audianceSegment=newAudience;
    
    if(audianceSegment == Offers)
    {
        NSPredicate * customPredicate = [NSPredicate predicateWithFormat:@"self isKindOfClass: %@",[Offer class]];
        NSArray * offers = [self.mainArray filteredArrayUsingPredicate:customPredicate];
        mainArrayOffers = [[NSMutableArray alloc] initWithArray:offers];
        //mainArrayOffers = (NSMutableArray*)[self.mainArray filteredArrayUsingPredicate:customPredicate];
    }
    else if (audianceSegment == News)
    {
        NSPredicate * customPredicate = [NSPredicate predicateWithFormat:@"self isMemberOfClass: %@",[Activity class]];
        NSArray * news = [self.mainArray filteredArrayUsingPredicate:customPredicate];
        mainArrayNews = [[NSMutableArray alloc] initWithArray:news];
    }
    [self.tableView reloadData];
}
#pragma  mark: Custom Methods
-(void)updateTheViewColorSchemeAccordingToCenter{
//    UIColor * color=[appDelegate getTheGeneralColor];//getTheColorAccordingToCenterName:placeType];
//    [self.cellPlaceholder.contentView setBackgroundColor:color];
}
-(void)addRefreshControlInCollectionView{

//    UIRefreshControl * refreshcontrol = [[UIRefreshControl alloc] init];
//    [refreshControl addTarget:self action:@selector(refereshData:) forControlEvents:UIControlEventValueChanged];
//    [self.tableView addSubview:refreshControl];
    refreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
    [refreshControl addTarget:self action:@selector(refreshControlAction:) forControlEvents:UIControlEventValueChanged];
    self.tableView.alwaysBounceVertical = YES;
}

#pragma mark: UITableView Delegates and Datasource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ((audianceSegment==News && mainArrayNews.count==0) || (audianceSegment==ALL && mainArray.count==0) || (audianceSegment==Offers && mainArrayOffers.count==0)) {
        return 1;
    }
    if(audianceSegment==News){
        return mainArrayNews.count;
    }
    else if(audianceSegment==Offers){
        return mainArrayOffers.count;
    }
    else{
        return mainArray.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ((audianceSegment==News && mainArrayNews.count==0) || (audianceSegment==ALL && mainArray.count==0) || (audianceSegment==Offers && mainArrayOffers.count==0)) {
        return 44;
    }
    return 296.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ((audianceSegment==News && mainArrayNews.count==0) || (audianceSegment==ALL && mainArray.count==0) || (audianceSegment==Offers && mainArrayOffers.count==0)) {
        self.cellPlaceholder.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellPlaceholder;
    }
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityCell"];
    if (!cell) {
        NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"ActivityCell" owner:self options:nil];
        cell=[array objectAtIndex:0];
    }

//    CenterBannerCell * cell=[tableView dequeueReusableCellWithIdentifier:@"centerBannerCell"];
//    if (!cell) {
//        NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"CenterBannerCell" owner:self options:nil];
//        cell=[array objectAtIndex:0];
//    }
    
//    NSDictionary * dict;
    id activityObject;
    if(audianceSegment==News){
        activityObject = [mainArrayNews objectAtIndex:indexPath.row];
    }
    else if(audianceSegment==ALL){
         activityObject = [mainArray objectAtIndex:indexPath.row];
    }
    else{
        activityObject = [mainArrayOffers objectAtIndex:indexPath.row];
    }
    
    
    if ([activityObject isMemberOfClass:[Activity class]]) {
        [self configureCell:cell withActivity:(Activity*)activityObject];
    }
    else
    {
        [self configureCell:cell withOffer:(Offer*)activityObject];
    }

    cell.delegate =  self;
    cell.heartBtn.tag = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    User *user = [[DataManager sharedInstance] currentUser];
    if ([user.favouriteActivities containsObject:activityObject] || [user.favouriteOffers containsObject:activityObject])
    {
        [cell makeHearPressed:YES];
    }
    else
    {
        [cell makeHearPressed:NO];
    }
    return cell;
}
//    cell.objNameLbl.text=[dict valueForKey:kTempObjTitle];
//    cell.objDetail.text=[dict valueForKey:kTempObjDetail];
//    cell.objPlaceLbl.text=[dict valueForKey:kTempObjPlace];
//    if ([placeType isEqualToString:NSLocalizedString(@"All", nil)]) {
//         cell.objShopLbl.text=[dict valueForKey:kTempObjShop];
//    }
//    else{
//        cell.objShopLbl.text=@"";
//    }
//    
//    //cell.objImgV.image=[UtilsFunctions imageWithImage:[UIImage imageNamed:[dict valueForKey:kTempObjImgName]] scaledToSize:CGSizeMake(cell.objImgV.frame.size.width*2,cell.objImgV.frame.size.height*2)];
////    cell.objImgV.frame=CGRectMake(5,2,151,83);
//    cell.objImgV.image = [UIImage imageNamed:[dict valueForKey:kTempObjImgName]];
//    [self makeUIImageViewRoundedLeftSide:cell.objImgV ANDRadiues:3.0 ANDTableViewCell:cell];
//    cell.tag=[[dict valueForKey:kTempObjID]integerValue];
//    if ([[dict valueForKey:kTempObjIsBookmarked]isEqualToString:@"YES"]) {
//        [cell makeHearPressed:YES];
//    }
//    else{
//        [cell makeHearPressed:NO];
//    }
////    cell.heartBtn.frame=CGRectMake(277+2, 4+2, cell.heartBtn.frame.size.width, cell.heartBtn.frame.size.height);
////    [cell.bgImgView setHidden:NO];
//    [cell.dividerImgV setHidden:YES];
//    cell.delegate=self;
//    cell.selectionStyle=UITableViewCellSelectionStyleNone;

//- (void)configureCell:(CenterBannerCell*)cell withActivity:(Activity*)activity
//{
//    [cell.objImgV setImageWithURL:[NSURL URLWithString:activity.imageURL] placeholderImage:[UIImage imageNamed:@"place-holder"]];
//    cell.objNameLbl.text = activity.title;
//    cell.objDetail.text = activity.briefText;
//    cell.objPlaceLbl.text = activity.mall.placeName;
//    if (activity.entityObject && activity.entityObject.name)
//        cell.objShopLbl.text = activity.entityObject.name;
//    else
//        cell.objShopLbl.text=@"";
//
//}
//- (void)configureCell:(CenterBannerCell*)cell withOffer:(Offer*)offer
//{
//    [cell.objImgV setImageWithURL:[NSURL URLWithString:offer.imageURL] placeholderImage:[UIImage imageNamed:@"place-holder"]];
//    cell.objNameLbl.text = offer.title;
//    cell.objDetail.text = offer.briefText;
//    cell.objPlaceLbl.text = offer.mall.placeName;
//    if (offer.entityObject && offer.entityObject.name)
//        cell.objShopLbl.text = offer.entityObject.name;
//    else
//        cell.objShopLbl.text=@"";
//}
- (void)configureCell:(ActivityCell*)cell withActivity:(Activity*)activity
{
    [cell.offerImageView setImageWithURL:[NSURL URLWithString:activity.imageURL] placeholderImage:[UIImage imageNamed:@"place-holder"]];
    [cell.entityLogoImgView setImageWithURL:[NSURL URLWithString:activity.entityObject.logoURL] placeholderImage:[UIImage imageNamed:@"place-holder"]];
    cell.nameLbl.text = activity.title;
    
    if (activity.entityObject && activity.entityObject.name)
        cell.entityPlaceLbl.text = [NSString stringWithFormat:@"%@,%@",activity.entityObject.name ,activity.mall.placeName];
    else
         cell.entityPlaceLbl.text = activity.mall.placeName;
    
    cell.briefTxtLbl.text = activity.briefText;

    NSString * startDateString;
    if(activity.startDate)
        startDateString = [dateFormatter stringFromDate:activity.startDate];
    
    if (startDateString)
        cell.timingLbl.text = startDateString;
//        cell.timingLbl.text = [NSString stringWithFormat:@"%@ :%@",NSLocalizedString(@"News",nil),startDateString];
//    else
//        cell.timingLbl.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"News",nil),NSLocalizedString(@"Not Available",nil)];
}
- (void)configureCell:(ActivityCell*)cell withOffer:(Offer*)offer
{
    [cell.offerImageView setImageWithURL:[NSURL URLWithString:offer.imageURL] placeholderImage:[UIImage imageNamed:@"place-holder"]];
    [cell.entityLogoImgView setImageWithURL:[NSURL URLWithString:offer.entityObject.logoURL] placeholderImage:[UIImage imageNamed:@"place-holder"]];
    cell.nameLbl.text = offer.title;
    if (offer.entityObject && offer.entityObject.name)
        cell.entityPlaceLbl.text = [NSString stringWithFormat:@"%@,%@",offer.entityObject.name ,offer.mall.placeName];
    else
        cell.entityPlaceLbl.text = offer.mall.placeName;
    
    cell.briefTxtLbl.text = offer.briefText;
    
    NSString * startDateString;
    NSString * endDateString;
    if(offer.startDate)
        startDateString = [dateFormatter stringFromDate:offer.startDate];
    if (offer.endDate)
        endDateString = [dateFormatter stringFromDate:offer.endDate];
    
    if (startDateString && endDateString)
        cell.timingLbl.text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",NSLocalizedString(@"Offer",nil),NSLocalizedString(@"starts",nil),startDateString,NSLocalizedString(@"ends",nil),endDateString];
    else
        cell.timingLbl.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"Offer Validity",nil),NSLocalizedString(@"Not Available",nil)];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath :(NSIndexPath *)indexPath{
    if ((audianceSegment==News && mainArrayNews.count==0) || (audianceSegment==ALL && mainArray.count==0) || (audianceSegment==Offers && mainArrayOffers.count==0)) {
        return;
    }
//    NSArray * savedObjects=GetArrayWithKey(kArrayEndorsementCreatedLocally);
//    NSDictionary * dict   = [NSKeyedUnarchiver unarchiveObjectWithData:(NSData*)savedObjects.firstObject];
//    if (_isFromChat) {
//        [self.delegate endorementIsSelectedForChat:dict];
//        return;
//    }
    //OfferDetailVC *endoreVC=[[OfferDetailVC alloc]initWithOfferCreatedLocally:dict ANDCenterName:placeType];
    id activityObject;
    if(audianceSegment==News){
        activityObject = [mainArrayNews objectAtIndex:indexPath.row];
    }
    else if(audianceSegment==ALL){
        activityObject = [mainArray objectAtIndex:indexPath.row];
    }
    else{
        activityObject = [mainArrayOffers objectAtIndex:indexPath.row];
    }
//    ActivitiesMainVC *vc = (ActivitiesMainVC *)self.parentViewController;
//    vc.isFromActivityDetail = YES;
    OfferDetailVC *offerDetailVC = [[OfferDetailVC alloc] init];
    offerDetailVC.activityObject = activityObject;
    [self.navigationController pushViewController:offerDetailVC animated:YES];
}
#pragma mark - CenterBannerCellDelegate
-(void)bannerBookmarkButtonPressedWithOption:(BOOL)isBookmark ANDTag:(NSInteger)tag{
    id activityObject;
    if(audianceSegment==News){
        activityObject = [mainArrayNews objectAtIndex:tag];
    }
    else if(audianceSegment==ALL){
        activityObject = [mainArray objectAtIndex:tag];
    }
    else{
        activityObject = [mainArrayOffers objectAtIndex:tag];
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *activityId = nil;
    BOOL isOffer = NO;
    if ([activityObject isMemberOfClass:[Activity class]])
    {
        activityId = [(Activity *)activityObject activityId];
    }
    else
    {
        activityId = [(Offer *)activityObject activityId];
        isOffer = YES;
    }
    
    
    if(isBookmark)
    {
        [[WebManager sharedInstance] markActivity:activityId favouriteDeleted:NO
                                          success:^(id response) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            if (response!= nil)
            {
                User *user = [[DataManager sharedInstance] currentUser];
                if (isOffer)
                {
                    [user addFavouriteOffersObject:activityObject];
                    ShowMessage(kAppName, NSLocalizedString(@"This offer added to your favourities", nil));
                }
                else
                {
                    [user addFavouriteActivitiesObject:activityObject];
                    ShowMessage(kAppName, NSLocalizedString(@"This news added to your favourities", nil));
                }
                [[DataManager sharedInstance] saveContext];
            }
        } failure:^(NSString *errorString) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            ShowMessage(kAppName,errorString);
        }];
    }
    else{
        [[WebManager sharedInstance] markActivity:activityId favouriteDeleted:YES
                                          success:^(id response) {
          [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
          if (response!= nil)
          {
              User *user = [[DataManager sharedInstance] currentUser];
              if (isOffer)
              {
                  [user removeFavouriteOffersObject:activityObject];
                  ShowMessage(kAppName, NSLocalizedString(@"This offer removed from your favourities", nil));
              }
              else
              {
                  [user removeFavouriteActivitiesObject:activityObject];
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
#pragma mark:UIScrollViewDelegate
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
//                     withVelocity:(CGPoint)velocity
//              targetContentOffset:(inout CGPoint *)targetContentOffset
//{
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(_totalRecords > self.mainArray.count)
    {
        if (((self.tableView.contentOffset.y + (self.tableView.frame.size.height)) >= self.tableView.contentSize.height) && !_isLoading){
            _pageNumber = _pageNumber+1;
            [self reloadActivities];
        }
    }
}
#pragma mark: IBAction and Selector Methods
-(void)refreshControlAction:(id)sender{
    ActivitiesMainVC *vc = (ActivitiesMainVC *)self.parentViewController;
    vc.isCollectionReloading = YES;
    [vc loadActivities];
    //[self performSelector:@selector(endRefreshControl) withObject:nil afterDelay:2];
}
-(void)endRefreshControl{
    [refreshControl endRefreshing];
}
@end
