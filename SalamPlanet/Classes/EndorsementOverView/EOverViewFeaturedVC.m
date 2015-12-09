//
//  EOverViewFeaturedVC.m
//  SalamPlanet
//
//  Created by Globit on 22/10/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "EOverViewFeaturedVC.h"
#import "AppDelegate.h"
#import "ODRefreshControl.h"
#import "EndrViewPageVC.h"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
@interface EOverViewFeaturedVC ()
{
    AppDelegate * appDelegate;
    
    NSMutableArray * mainArray;
    NSMutableArray * mainArrayNews;
    NSMutableArray * mainArrayOffers;
    
    NSDictionary * userDictMain;
    ODRefreshControl * refreshControl;
    NSString * catSubCatType;
//    HMSegmentedControl *segmentedControl;
}
@end

@implementation EOverViewFeaturedVC
@synthesize audianceSegment;
- (id)initWIthOption:(NSString * )option ANDisCatSubCat:(BOOL)isCat
{
    self = [super initWithNibName:@"EOverViewFeaturedVC" bundle:nil];
    if (self) {
        catSubCatType=[[NSString alloc]initWithString:option];
        audianceSegment=ALL;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
//    [self addSegmentBarToViewNew];
    
    mainArray=[[NSMutableArray alloc]init];
    mainArrayOffers=[[NSMutableArray alloc]init];
    mainArrayNews=[[NSMutableArray alloc]init];

    [self loadUserData];
    [self loadMainArrayWithDummyData];
    
    if(!IS_IPHONE_5){
        self.tableView.frame=CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, 372.0);
    }
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    //Color
    [self updateTheViewColorSchemeAccordingToCenter];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [appDelegate hideBottomTabBar:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-Custom Methods
-(void)updateTheViewColorSchemeAccordingToCenter{
    UIColor * color=[appDelegate getTheColorAccordingToCenterName:catSubCatType];
    [self.topBarBGView setBackgroundColor:color];
    [self.segmentControl setTintColor:color];
}
-(void)addRefreshControlInCollectionView{
    refreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
    [refreshControl addTarget:self action:@selector(refreshControlAction:) forControlEvents:UIControlEventValueChanged];
    self.tableView.alwaysBounceVertical = YES;
}
-(void)loadUserData{
    NSData * savedObject=GetDataWithKey(kUserCreatedLocally);
    NSDictionary * dictnry=[NSKeyedUnarchiver unarchiveObjectWithData:savedObject];
    userDictMain=[[NSDictionary alloc]initWithDictionary:dictnry];
}
-(void)loadMainArrayWithDummyData{
    [mainArray removeAllObjects];
    
    NSArray * savedObjects=GetArrayWithKey(kArrayEndorsementCreatedLocally);
    for (NSData * item in savedObjects) {
        NSDictionary * dictnry=[NSKeyedUnarchiver unarchiveObjectWithData:item];
        if ([[dictnry valueForKey:kTempObjCategory]isEqualToString:catSubCatType]) {
            [mainArray addObject:dictnry];
        }
        if ([catSubCatType isEqualToString:@"Bookmark"]) {
            if ([[dictnry valueForKey:kTempObjIsBookmarked]isEqualToString:@"YES"]) {
                [mainArray addObject:dictnry];
            }
        }
    }
    [self sortMainArrayForAudience];
}
-(void)sortMainArrayForAudience{
    NSSortDescriptor *idSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:kTempEndrID ascending:NO];
    NSArray  * sortedArray=[mainArray sortedArrayUsingDescriptors:@[idSortDescriptor]];
    [mainArray removeAllObjects];
    for (id obj in sortedArray) {
        [mainArray addObject:obj];
    }
    [mainArrayOffers removeAllObjects];
    [mainArrayNews removeAllObjects];
    for (NSDictionary * dict in mainArray) {
        if ([[dict valueForKey:kTempObjType]integerValue]== News) {
            [mainArrayNews addObject:dict];
        }
        else if([[dict valueForKey:kTempObjType]integerValue]== Offers) {
            [mainArrayOffers addObject:dict];
        }
    }
}
//-(void)addSegmentBarToViewNew{
//    segmentedControl = [[HMSegmentedControl alloc] initWithSectionImages:@[[UIImage imageNamed:@"seg_blank"], [UIImage imageNamed:@"seg_1_blank"], [UIImage imageNamed:@"seg_blank"]]  sectionSelectedImages:@[[UIImage imageNamed:@"seg_1"], [UIImage imageNamed:@"seg_2"], [UIImage imageNamed:@"seg_3"] ]titlesForSections:@[@"Offers",@"Events",@"News"]];
//    
//    segmentedControl.frame = CGRectMake(4, 63 ,312, 36);
//    segmentedControl.selectionIndicatorHeight = 4.0f;
//    segmentedControl.backgroundColor = [UIColor clearColor];
//    segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
//    segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
//    [segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:segmentedControl];
//    audianceSegment=Offers;
//}
//-(void)updateTheSegmentBarSelectionImageWithIndex:(NSInteger)indx{
//    if (indx==0) {
//        [segmentedControl updateTheImageArray:@[[UIImage imageNamed:@"seg_blank"], [UIImage imageNamed:@"seg_1_blank"], [UIImage imageNamed:@"seg_blank"]]];
//    }
//    else if(indx==1){
//        [segmentedControl updateTheImageArray:@[[UIImage imageNamed:@"seg_blank"], [UIImage imageNamed:@"seg_blank"], [UIImage imageNamed:@"seg_blank"]]];
//    }
//    else if(indx==2){
//        [segmentedControl updateTheImageArray:@[[UIImage imageNamed:@"seg_blank"], [UIImage imageNamed:@"seg_3_blank"], [UIImage imageNamed:@"seg_blank"]]];
//    }
//    
//}
#pragma mark: UITableView Delegates and Datasource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ((audianceSegment==News && mainArrayNews.count==0) || (audianceSegment==ALL && mainArray.count==0) || (audianceSegment==Offers && mainArrayOffers.count==0)) {
        return 1;
    }
    if(audianceSegment==News){
        return mainArrayNews.count;
    }
    else if(audianceSegment==ALL){
        return mainArray.count;
    }
    else{
        return mainArrayOffers.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ((audianceSegment==News && mainArrayNews.count==0) || (audianceSegment==ALL && mainArray.count==0) || (audianceSegment==Offers && mainArrayOffers.count==0)) {
        return 44;
    }
    return 120.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ((audianceSegment==News && mainArrayNews.count==0) || (audianceSegment==ALL && mainArray.count==0) || (audianceSegment==Offers && mainArrayOffers.count==0)) {
        self.cellPlaceholder.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellPlaceholder;
    }
    CenterBannerCell * cell=[tableView dequeueReusableCellWithIdentifier:@"centerBannerCell"];
    if (!cell) {
        NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"CenterBannerCell" owner:self options:nil];
        cell=[array objectAtIndex:0];
    }
    
    NSDictionary * dict;
    if(audianceSegment==News){
        dict=[mainArrayNews objectAtIndex:indexPath.row];
    }
    else if(audianceSegment==ALL){
        dict=[mainArray objectAtIndex:indexPath.row];
    }
    else{
        dict=[mainArrayOffers objectAtIndex:indexPath.row];
    }
    cell.objNameLbl.text=[dict valueForKey:kTempObjTitle];
    cell.objDetail.text=[dict valueForKey:kTempObjDetail];
    cell.objPlaceLbl.text=[dict valueForKey:kTempObjPlace];
    cell.objShopLbl.text=[dict valueForKey:kTempObjShop];
    cell.objImgV.image=[UtilsFunctions imageWithImage:[UIImage imageNamed:[dict valueForKey:kTempObjImgName]] scaledToSize:CGSizeMake(cell.objImgV.frame.size.width*2,cell.objImgV.frame.size.height*2)];
    cell.tag=[[dict valueForKey:kTempObjID]integerValue];
    if ([[dict valueForKey:kTempObjIsFav]isEqualToString:@"YES"]) {
        [cell makeHearPressed:YES];
    }
    else{
        [cell makeHearPressed:NO];
    }
    cell.delegate=self;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath :(NSIndexPath *)indexPath{
    if ((audianceSegment==News && mainArrayNews.count==0) || (audianceSegment==ALL && mainArray.count==0) || (audianceSegment==Offers && mainArrayOffers.count==0)) {
        return;
    }
    NSDictionary * dict;
    if(audianceSegment==News){
        dict=[mainArrayNews objectAtIndex:indexPath.row];
    }
    else if(audianceSegment==ALL){
        dict=[mainArray objectAtIndex:indexPath.row];
    }
    else{
        dict=[mainArrayOffers objectAtIndex:indexPath.row];
    }
    EndrViewPageVC *endoreVC=[[EndrViewPageVC alloc]initWithEndorsementCreatedLocally:dict];
    [self.navigationController pushViewController:endoreVC animated:YES];
    NSLog(@"%li",(long)indexPath.row);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * dict;
    if(audianceSegment==News){
        dict=[mainArrayNews objectAtIndex:indexPath.row];
    }
    else if(audianceSegment==ALL){
        dict=[mainArray objectAtIndex:indexPath.row];
    }
    else{
        dict=[mainArrayOffers objectAtIndex:indexPath.row];
    }
    
    EndrViewPageVC *endoreVC=[[EndrViewPageVC alloc]initWithEndorsementCreatedLocally:dict];
    [self.navigationController pushViewController:endoreVC animated:YES];
    NSLog(@"%li",(long)indexPath.row);
}
#pragma mark - CenterBannerCellDelegate
-(void)bannerBookmarkButtonPressedWithOption:(BOOL)isBookmark ANDTag:(NSInteger)tag{
//    if(isFav){
//        NSString * place;
//        for (NSDictionary * dict in mainArray) {
//            if ([[dict valueForKey:kTempObjID]integerValue]==tag) {
//                [dict setValue:@"YES" forKey:kTempObjIsFav];
//                place=[dict valueForKey:kTempObjPlace];
//                break;
//            }
//        }
//        [UtilsFunctions saveAllEndorsementArrayInUserDefaults:mainArray];
//        [self loadMainArrayWithDummyData];
//        ShowMessage(kAppName, @"Offer have been saved");
//    }
//    else{
//        for (NSDictionary * dict in mainArray) {
//            if ([[dict valueForKey:kTempObjID]integerValue]==tag) {
//                [dict setValue:@"YES" forKey:kTempObjIsFav];
//                break;
//            }
//        }
//        [UtilsFunctions saveAllEndorsementArrayInUserDefaults:mainArray];
//        [self loadMainArrayWithDummyData];
//        ShowMessage(kAppName, @"Offer have been removed");
//    }
    if(isBookmark){
        for (NSDictionary * dict in mainArray) {
            if ([[dict valueForKey:kTempObjID]integerValue]==tag) {
                [dict setValue:@"YES" forKey:kTempObjIsBookmarked];
                break;
            }
        }
        [UtilsFunctions saveAllEndorsementArrayInUserDefaults:mainArray];
        [self loadMainArrayWithDummyData];
        ShowMessage(kAppName,NSLocalizedString(@"This offer have been saved", nil));
    }
    else{
        for (NSDictionary * dict in mainArray) {
            if ([[dict valueForKey:kTempObjID]integerValue]==tag) {
                [dict setValue:@"NO" forKey:kTempObjIsBookmarked];
                break;
            }
        }
        [UtilsFunctions saveAllEndorsementArrayInUserDefaults:mainArray];
        [self loadMainArrayWithDummyData];
        ShowMessage(kAppName,NSLocalizedString(@"This offer have been unsaved", nil));
    }
}
#pragma mark: IBAction and Selector Methods
-(void)refreshControlAction:(id)sender{
    
    [self performSelector:@selector(endRefreshControl) withObject:nil afterDelay:2];
}
-(void)endRefreshControl{
    [refreshControl endRefreshing];
}

#pragma mark:ActivitiesCollectionVCDelegate
-(void)addTheCategorySubCategorInFavList:(BOOL)isCat ANDName:(NSString *)name{

    NSMutableArray * array=[[NSMutableArray alloc]initWithArray:GetArrayWithKey(kArrayFavouriteCatSubCat)];
    for (NSString * str in array) {
        if ([str isEqualToString:name]) {
            return;
        }
    }
    [array addObject:name];
    SaveArrayWithKey(array, kArrayFavouriteCatSubCat);
}
#pragma mark-Selectors
- (IBAction)segmentedControlChangedValue:(UISegmentedControl *)segmentedControl {
    audianceSegment =segmentedControl.selectedSegmentIndex;
//    [self updateTheSegmentBarSelectionImageWithIndex:audianceSegment];
    [self.tableView reloadData];
}
#pragma mark:IBActions
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
