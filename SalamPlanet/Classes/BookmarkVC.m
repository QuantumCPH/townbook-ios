//
//  BookmarkVC.m
//  SalamCenterApp
//
//  Created by Globit on 09/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import "BookmarkVC.h"
#import "ShopCell.h"
#import "ServiceCell.h"
#import "AppDelegate.h"
#import "NewShopDetailVC.h"
#import "OfferDetailVC.h"
#import "ActivityCell.h"

#import "UIImageView+WebCache.h"
#import "DataManager.h"
#import "User.h"
#import "MallCenter.h"
#import "Offer.h"
#import "Activity.h"
#import "Shop.h"
#import "Restaurant.h"
#import "MACategory.h"


@interface BookmarkVC ()
{
    AppDelegate * appDelegate;
    NSMutableArray * mainShopsArray;
    NSMutableArray * mainOffersArray;
    NSMutableArray * mainNewsArray;
    NSMutableArray * mainRestaurantsArray;
    NSMutableArray * mainSearchedArray;
    NSMutableDictionary * mainDictionary;
    NSMutableArray * mainSectionArray;
    BOOL isForSearched;
    BOOL shouldShowFilters;
    BOOL isSlided;
    NSInteger selectedSection;
    NSDateFormatter *dateFormatter;
    User *user;
}
@end

@implementation BookmarkVC
-(id)init{
    self = [super initWithNibName:@"BookmarkVC" bundle:nil];
    if (self) {
        mainOffersArray=[[NSMutableArray alloc]init];
        mainNewsArray=[[NSMutableArray alloc]init];
        mainShopsArray=[[NSMutableArray alloc]init];
        mainRestaurantsArray=[[NSMutableArray alloc]init];
        mainSearchedArray=[[NSMutableArray alloc]init];
        mainDictionary=[[NSMutableDictionary alloc]init];
        mainSectionArray=[[NSMutableArray alloc]init];
        appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self dolocalizationText];
    [self.bgImgV setImage:[UIImage imageNamed:[appDelegate getBackgroundImageName]]];
    self.lblPageTitle.font=[appDelegate getFontOfPageTitle];
    
    user = [[DataManager sharedInstance] currentUser];
    
    [self filterMainArrayForOptionOffers];
    [self.tableView reloadData];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    //Add Searchbar tablew Header View
    self.tableView.tableHeaderView=self.searchBarView;
    [self.tableView setContentOffset:CGPointMake(0, 44)];
    
    isSlided=NO;
    selectedSection=1000;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self filterDataWithSegmentBarValue];
    [appDelegate hideBottomTabBar:YES];
}
-(void)dolocalizationText{
    self.lblPageTitle.text=NSLocalizedString(@"FAVORITE", nil);
    [self.segmentBar setTitle:NSLocalizedString(@"Offers", nil) forSegmentAtIndex:0];
    [self.segmentBar setTitle:NSLocalizedString(@"News", nil) forSegmentAtIndex:1];
    [self.segmentBar setTitle:NSLocalizedString(@"Shops", nil) forSegmentAtIndex:2];
    [self.segmentBar setTitle:NSLocalizedString(@"Restaurants", nil) forSegmentAtIndex:3];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-Filtering Data
-(void)filterMainArrayForOptionOffers{
    [mainDictionary removeAllObjects];
    [mainSectionArray removeAllObjects];
    mainOffersArray = [[NSMutableArray alloc] initWithArray:[user.favouriteOffers allObjects]];
    shouldShowFilters = NO;
//    for (Offer* offer in mainOffersArray) {
//        NSArray * categories = [offer.categories allObjects];
//        for (MACategory * category in categories)
//        {
//            NSString * name = category.categoryText;
//            
//            if(name && ![name isEqual:[NSNull null]] && name.length > 0)
//            {
//                if ([mainDictionary valueForKey:name]) {
//                    NSMutableArray * array = [mainDictionary valueForKey:name];
//                    [array addObject:offer];
//                }
//                else{
//                    NSMutableArray * array = [[NSMutableArray alloc] init];
//                    [array addObject:offer];
//                    [mainDictionary setObject:array forKey:name];
//                    [mainSectionArray addObject:name];
//                }
//            }
//        }
//    }
}
-(void)filterMainArrayForOptionNews{
    [mainDictionary removeAllObjects];
    [mainSectionArray removeAllObjects];
    mainNewsArray = [[NSMutableArray alloc] initWithArray:[user.favouriteActivities allObjects]];
    shouldShowFilters = NO;
//    for (Activity * news in mainNewsArray) {
//        NSArray * categories = [news.categories allObjects];
//        for (MACategory * category in categories)
//        {
//            NSString * name = category.categoryText;
//            if(name && ![name isEqual:[NSNull null]] && name.length > 0)
//            {
//                if ([mainDictionary valueForKey:name]) {
//                    NSMutableArray * array = [mainDictionary valueForKey:name];
//                    [array addObject:news];
//                }
//                else{
//                    NSMutableArray * array = [[NSMutableArray alloc] init];
//                    [array addObject:news];
//                    [mainDictionary setObject:array forKey:name];
//                    [mainSectionArray addObject:name];
//                }
//            }
//        }
//    }
}
-(void)filterMainArrayForOptionShops{
    shouldShowFilters = YES;
    [mainDictionary removeAllObjects];
    [mainSectionArray removeAllObjects];
    mainShopsArray = [[NSMutableArray alloc] initWithArray:[user.favouriteShops allObjects]];
    
    for (Shop * shop in mainShopsArray) {
        NSArray * categories = [shop.categories allObjects];
        for (MACategory * category in categories)
        {
            NSString * name = category.categoryText;
            if(name && ![name isEqual:[NSNull null]] && name.length > 0)
            {
                if ([mainDictionary valueForKey:name]) {
                    NSMutableArray * array = [mainDictionary valueForKey:name];
                        [array addObject:shop];
                }
                else{
                    NSMutableArray * array = [[NSMutableArray alloc] init];
                    [array addObject:shop];
                    [mainDictionary setObject:array forKey:name];
                    [mainSectionArray addObject:name];
                }
            }
        }
    }
    NSArray *sortedSections = [mainSectionArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    mainSectionArray = [[NSMutableArray alloc] initWithArray:sortedSections];
}
-(void)filterMainArrayForOptionRestuarants{
    shouldShowFilters = YES;
    [mainDictionary removeAllObjects];
    [mainSectionArray removeAllObjects];
    mainRestaurantsArray = [[NSMutableArray alloc] initWithArray:[user.favouriteRestaurants allObjects]];
    
    for (Restaurant * rest in mainRestaurantsArray) {
        NSArray * categories = [rest.categories allObjects];
        for (MACategory * category in categories)
        {
            NSString * name = category.categoryText;
            if(name && ![name isEqual:[NSNull null]] && name.length > 0)
            {
                if ([mainDictionary valueForKey:name]) {
                    NSMutableArray * array = [mainDictionary valueForKey:name];
                    [array addObject:rest];
                }
                else{
                    NSMutableArray * array = [[NSMutableArray alloc] init];
                    [array addObject:rest];
                    [mainDictionary setObject:array forKey:name];
                    [mainSectionArray addObject:name];
                }
            }
        }
    }
    NSArray *sortedSections = [mainSectionArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    mainSectionArray = [[NSMutableArray alloc] initWithArray:sortedSections];
}

#pragma mark-Custom Methods
-(void)makeUIImageViewRoundedLeftSide:(UIImageView*)imgView ANDRadiues:(float)rad ANDTableViewCell:(UITableViewCell *)cell{
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:imgView.bounds
                                     byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerTopLeft)
                                           cornerRadii:CGSizeMake(rad, rad)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = cell.bounds;
    maskLayer.path = maskPath.CGPath;
    imgView.layer.mask = maskLayer;
}
-(void)loadSearchedData:(NSString *)searchText{
    [mainSearchedArray removeAllObjects];
    if (self.segmentBar.selectedSegmentIndex==0) {
        for (Offer *offer in mainOffersArray) {
            NSString * name = offer.title;
            NSString * category = offer.categoryName;
            if(([name rangeOfString:searchText options:NSCaseInsensitiveSearch].location!=NSNotFound || [searchText isEqualToString:@""]) && name){
                [mainSearchedArray addObject:offer];
            }
            else if(([category rangeOfString:searchText options:NSCaseInsensitiveSearch].location!=NSNotFound || [searchText isEqualToString:@""]) && category){
                [mainSearchedArray addObject:offer];
            }
        }
    }
    else if (self.segmentBar.selectedSegmentIndex==1) {
        for (Activity *news in mainNewsArray) {
            NSString * name = news.title;
            NSString * category = news.categoryName;
            if(([name rangeOfString:searchText options:NSCaseInsensitiveSearch].location!=NSNotFound || [searchText isEqualToString:@""]) && name){
                [mainSearchedArray addObject:news];
            }
            else if(([category rangeOfString:searchText options:NSCaseInsensitiveSearch].location!=NSNotFound || [searchText isEqualToString:@""]) && category){
                [mainSearchedArray addObject:news];
            }

        }
    }
    else if(self.segmentBar.selectedSegmentIndex==2){
        for (Shop * shop in mainShopsArray) {
            NSString * name = shop.name;
            //NSString * category = shop.categoryName;
            if(([name rangeOfString:searchText options:NSCaseInsensitiveSearch].location!=NSNotFound || [searchText isEqualToString:@""]) && name){
                [mainSearchedArray addObject:shop];
            }
//            else if(([category rangeOfString:searchText options:NSCaseInsensitiveSearch].location!=NSNotFound || [searchText isEqualToString:@""]) && category){
//                [mainSearchedArray addObject:shop];
//            }
        }
    }
    else
    {
        for (Restaurant * rest in mainRestaurantsArray) {
            NSString * name = rest.name;
           // NSString * category = rest.categoryName;
            if(([name rangeOfString:searchText options:NSCaseInsensitiveSearch].location!=NSNotFound || [searchText isEqualToString:@""]) && name){
                [mainSearchedArray addObject:rest];
            }
//            else if(([category rangeOfString:searchText options:NSCaseInsensitiveSearch].location!=NSNotFound || [searchText isEqualToString:@""]) && category){
//                [mainSearchedArray addObject:rest];
//            }
        }
    }
}
#pragma mark-UITableView DataSource and Delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (isForSearched || !shouldShowFilters) {
        return 1;
    }
    return [mainSectionArray count];
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(isForSearched || !shouldShowFilters)
    {
        return nil;
    }
    return (NSString*)[mainSectionArray objectAtIndex:section];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (isForSearched || !shouldShowFilters) {
        return nil;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 36)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.frame.size.width, 36)];
    [label setFont:[UIFont systemFontOfSize:14]];
    label.textColor=[UIColor colorWithRed:89.0/255.0 green:89.0/255.0 blue:89.0/255.0 alpha:1];//[UIColor whiteColor];
    NSString *string =[mainSectionArray objectAtIndex:section];
    CGRect lblFrame=label.frame;
    label.frame=lblFrame;
    //
    //Background Image with 50%opacity
    view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"list-separator-36"]];//shopdetail_bannerslider50per

    UIButton * buttonSection=[[UIButton alloc]initWithFrame:view.frame];
    [buttonSection setTitle:@"" forState:UIControlStateNormal];
    buttonSection.backgroundColor=[UIColor clearColor];
    buttonSection.tag=section;
    [buttonSection addTarget:self action:@selector(sectionHasBeenPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [label setText:string];
    [view addSubview:label];
    [view addSubview:buttonSection];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (isForSearched || !shouldShowFilters) {
        return 0;
    }
    //For new Logic of Viewing
    return 36;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(isForSearched)
    {
        return mainSearchedArray.count;
    }
    else if (! shouldShowFilters)
    {
        if (self.segmentBar.selectedSegmentIndex == 0) {
            return mainOffersArray.count;
        }
        else{
            return mainNewsArray.count;
        }
    }
    NSArray * array=[mainDictionary objectForKey:[mainSectionArray objectAtIndex:section]];

    if (selectedSection==section) {
        return [array count];
    }
    else{
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.segmentBar.selectedSegmentIndex==0) {
        return 296.0;//80.0;
    }
    if (self.segmentBar.selectedSegmentIndex==1) {
        return 296.0;//80.0;
    }
    if (self.segmentBar.selectedSegmentIndex==2) {
        return 100.0;//80.0;
    }
    else{
        return 100.0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.segmentBar.selectedSegmentIndex==0) {
//        CenterBannerCell * cell=[tableView dequeueReusableCellWithIdentifier:@"centerBannerCell"];
//        if (!cell) {
//            NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"CenterBannerCell" owner:self options:nil];
//            cell=[array objectAtIndex:0];
//        }
        ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityCell"];
        if (!cell) {
            NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"ActivityCell" owner:self options:nil];
            cell=[array objectAtIndex:0];
        }

        Offer *offer;
        if (isForSearched) {
            offer = [mainSearchedArray objectAtIndex:indexPath.row];
        }
        else{
//            offer = [[mainDictionary objectForKey:[mainSectionArray objectAtIndex:indexPath.section]]objectAtIndex:indexPath.row];
            offer = [mainOffersArray objectAtIndex:indexPath.row];
        }
        [self configureCell:cell withOffer:offer];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (self.segmentBar.selectedSegmentIndex==1) {
//        CenterBannerCell * cell=[tableView dequeueReusableCellWithIdentifier:@"centerBannerCell"];
//        if (!cell) {
//            NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"CenterBannerCell" owner:self options:nil];
//            cell=[array objectAtIndex:0];
//        }
        ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityCell"];
        if (!cell) {
            NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"ActivityCell" owner:self options:nil];
            cell=[array objectAtIndex:0];
        }

        Activity * activity;
        if (isForSearched) {
            activity = [mainSearchedArray objectAtIndex:indexPath.row];
        }
        else{
//            activity = [[mainDictionary objectForKey:[mainSectionArray objectAtIndex:indexPath.section]]objectAtIndex:indexPath.row];
            activity = [mainNewsArray objectAtIndex:indexPath.row];
        }
        [self configureCell:cell withActivity:activity];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (self.segmentBar.selectedSegmentIndex==2) {
        ShopCell * cell = [tableView dequeueReusableCellWithIdentifier:@"shopCell"];
        if (cell == nil) {
            NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"ShopCell" owner:self options:nil];
            cell=[array objectAtIndex:0];
        }

        
        Shop * shop;
        if(isForSearched){
            shop=[mainSearchedArray objectAtIndex:indexPath.row];
        }
        else{
            NSLog(@"%ld,%ld",(long)indexPath.section,(long)indexPath.row);
            NSString * keyName=[mainSectionArray objectAtIndex:indexPath.section];
            shop=[[mainDictionary objectForKey:keyName]objectAtIndex:indexPath.row];
        }
        [self configureCell:cell withShop:shop];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    else{
        ShopCell * cell = [tableView dequeueReusableCellWithIdentifier:@"shopCell"];
        if (cell == nil) {
            NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"ShopCell" owner:self options:nil];
            cell=[array objectAtIndex:0];
        }
        Restaurant * rest;
        if(isForSearched){
            rest=[mainSearchedArray objectAtIndex:indexPath.row];
        }
        else{
            rest=[[mainDictionary objectForKey:[mainSectionArray objectAtIndex:indexPath.section]]objectAtIndex:indexPath.row];
        }
        [self configureCell:cell withRestaurant:rest];
        [cell makeHeartPressed:YES];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.segmentBar.selectedSegmentIndex==0) {
        Offer *offer;
        if (isForSearched) {
            offer = [mainSearchedArray objectAtIndex:indexPath.row];
        }
        else{
            offer = [mainOffersArray objectAtIndex:indexPath.row];
        }
        OfferDetailVC *offerDetailVC = [[OfferDetailVC alloc] init];
        offerDetailVC.activityObject = offer;
        [self.navigationController pushViewController:offerDetailVC animated:YES];
    }
    else if (self.segmentBar.selectedSegmentIndex == 1)
    {
        Activity *activity;
        if (isForSearched) {
            activity = [mainSearchedArray objectAtIndex:indexPath.row];
        }
        else{
            activity = [mainNewsArray objectAtIndex:indexPath.row];
        }
        OfferDetailVC *offerDetailVC = [[OfferDetailVC alloc] init];
        offerDetailVC.activityObject = activity;
        [self.navigationController pushViewController:offerDetailVC animated:YES];
    }
    else if (self.segmentBar.selectedSegmentIndex==2) {
        Shop * shop;
        if(isForSearched){
            shop = [mainSearchedArray objectAtIndex:indexPath.row];
        }
        else{
            shop = [mainShopsArray objectAtIndex:indexPath.row];
        }
        NewShopDetailVC *shopDetailVC=[[NewShopDetailVC alloc]initWithOfferCreatedLocally:nil ANDCenterName:nil];
        shopDetailVC.shop = shop;
        [self.navigationController pushViewController:shopDetailVC animated:YES];
    }
    else{
        Restaurant * rest;
        if(isForSearched){
            rest=[mainSearchedArray objectAtIndex:indexPath.row];
        }
        else{
            rest=[mainRestaurantsArray objectAtIndex:indexPath.row];
        }
        NewShopDetailVC *shopDetailVC=[[NewShopDetailVC alloc]initWithOfferCreatedLocally:nil ANDCenterName:nil];
        shopDetailVC.isForRestaurent=YES;
        shopDetailVC.restaurant = rest;
        [self.navigationController pushViewController:shopDetailVC animated:YES];
    }
}
#pragma mark CellConfiguration
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
    cell.isForFavourites = YES;
    [cell makeHearPressed:YES];
}
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
    
    if(activity.startDate)
        startDateString = [dateFormatter stringFromDate:activity.startDate];
    
    cell.isForFavourites = YES;
    [cell makeHearPressed:YES];
}

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
//    cell.isForFavourites = YES;
//    [cell makeHearPressed:YES];
//}
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
//    cell.isForFavourites = YES;
//    [cell makeHearPressed:YES];
//}
- (void)configureCell:(ShopCell*)cell withShop:(Shop*)shop
{
    [cell.shopLogoImgV setImageWithURL:[NSURL URLWithString:shop.logoURL] placeholderImage:[UIImage imageNamed:@"place-holder"]];
    cell.lblShopName.text = shop.name;
    cell.lblShopFloor.text = shop.floor;
    cell.lblShopTitle.text = shop.briefText;
    [cell makeHeartPressed:YES];
}
- (void)configureCell:(ShopCell*)cell withRestaurant:(Restaurant *)restaurant
{
    [cell.shopLogoImgV setImageWithURL:[NSURL URLWithString:restaurant.logoURL] placeholderImage:[UIImage imageNamed:@"place-holder"]];
    cell.lblShopName.text = restaurant.name;
    cell.lblShopFloor.text = restaurant.floor;
    cell.lblShopTitle.text = restaurant.briefText;
    [cell makeHeartPressed:YES];
}
#pragma mark UISearchBarDelegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length==0) {
        isForSearched=NO;
//        [self.searchBar resignFirstResponder];
        [self.searchBar performSelector:@selector(resignFirstResponder)
                        withObject:nil
                        afterDelay:0];
        [self.segmentBar setEnabled:YES];
        [self.tableView reloadData];
        return;
    }
    isForSearched=YES;
    [self loadSearchedData:self.searchBar.text];
    [self.tableView reloadData];
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    isForSearched=NO;
//    [self.searchBar resignFirstResponder];
    [self.searchBar performSelector:@selector(resignFirstResponder)
                         withObject:nil
                         afterDelay:0];

    [self.tableView reloadData];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //    [searchBar resignFirstResponder];
    // Do the search...
}
#pragma mark:IBActions and Selectors
-(void)sectionHasBeenPressed:(id)sender{
    UIButton * button=(UIButton *)sender;
    if (selectedSection==button.tag) {
        selectedSection=1000;
    }
    else{
        selectedSection=button.tag;
    }
    [self.tableView reloadData];
}
- (IBAction)segmentBarValueChanged:(id)sender{
    [self loadSearchedData:self.searchBar.text];
    [self filterDataWithSegmentBarValue];
}
- (void)filterDataWithSegmentBarValue
{
    if(self.segmentBar.selectedSegmentIndex==0){
        [self filterMainArrayForOptionOffers];
    }
    else if(self.segmentBar.selectedSegmentIndex==1){
        [self filterMainArrayForOptionNews];
    }
    else if(self.segmentBar.selectedSegmentIndex==2){
        [self filterMainArrayForOptionShops];
    }
    else{
        [self filterMainArrayForOptionRestuarants];
    }
    selectedSection=1000; //Assuming never have 100 sections
    [self.tableView reloadData];
}
- (IBAction)backBtnPressed:(id)sender{
//    [self.backBtn setSelected:YES];
//    [appDelegate showSlideMenuForBackAction];
//    [self.navigationController popViewControllerAnimated:YES];
    if(isSlided){
        [appDelegate showHideSlideMenue:YES withCenterName:nil];
        isSlided=NO;
    }
    else{
        [appDelegate showHideSlideMenue:YES withCenterName:nil];
        isSlided=YES;
    }
}
@end
