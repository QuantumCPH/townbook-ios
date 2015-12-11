//
//  ShopsVC.m
//  SalamCenterApp
//
//  Created by Globit on 29/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "ShopsVC.h"
#import "AppDelegate.h"
#import "ShopObject.h"
#import "NewShopDetailVC.h"
#import "UtilsFunctions.h"
#import "MBProgressHUD.h"
#import "WebManager.h"
#import "DataManager.h"
#import "Shop.h"
#import "User.h"
#import "MACategory.h"
#import "UIImageView+WebCache.h"

@interface ShopsVC ()
{
    AppDelegate * appDelegate;
    NSMutableArray * mainArray;
    NSMutableArray * mainSearchedArray;
    NSMutableDictionary * mainDictionary;
    NSMutableArray * mainSectionArray;

    NSArray * arrayAtoZ;
    BOOL isFromSearchBar;
    BOOL isSlided;
    NSInteger selectedSection;
}
@end

@implementation ShopsVC
@synthesize delegate;
-(id)init{
    self = [super initWithNibName:@"ShopsVC" bundle:nil];
    if (self) {
        mainArray=[[NSMutableArray alloc]init];
        mainSearchedArray=[[NSMutableArray alloc]init];
        mainDictionary=[[NSMutableDictionary alloc]init];
        mainSectionArray=[[NSMutableArray alloc]init];
        appDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
        [self initializeArrayAtoZ];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dolocalizationText];
    [self.bgImgV setImage:[UIImage imageNamed:[appDelegate getBackgroundImageName]]];
    self.lblPageTitle.font=[appDelegate getFontOfPageTitle];
    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;

    
    [self initializeCustomIndexView];
    
    [self changeTextColorOfSearchBar];

    //[self initializeShopsMainArrayWithDummy];
    [self getShopsList];
    //[self filterMainArrayForOptionOne];
    
    selectedSection=1000; //Assuming never have 100 sections
    
    isSlided=NO;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [appDelegate hideBottomTabBar:YES];
}
-(void)dolocalizationText{
    self.lblPageTitle.text=NSLocalizedString(@"SHOPS", nil);
    [self.segmentBar setTitle:NSLocalizedString(@"Category", nil) forSegmentAtIndex:1];
    [self.segmentBar setTitle:NSLocalizedString(@"Floor", nil) forSegmentAtIndex:2];
}

#pragma mark-Custom Methods
-(void)initializeCustomIndexView{

    CGRect frame = [UIScreen mainScreen].bounds;
    frame.origin.y+=107;
    frame.size.height-=107;
  
    frame.size.height-=20;
    frame.origin.y+=20;

    self.indexView = [[MJNIndexView alloc]initWithFrame:frame];
    self.indexView.dataSource = self;
    [self firstAttributesForMJNIndexView];
    [self.view addSubview:self.indexView];
}
- (void)firstAttributesForMJNIndexView
{
    self.indexView.getSelectedItemsAfterPanGestureIsFinished = YES;
    self.indexView.font = [UIFont fontWithName:@"HelveticaNeue" size:13.0];
    self.indexView.selectedItemFont = [UIFont fontWithName:@"HelveticaNeue" size:24.0];
    self.indexView.backgroundColor = [UIColor clearColor];
    self.indexView.curtainColor = nil;
    self.indexView.curtainFade = 0.0;
    self.indexView.curtainStays = NO;
    self.indexView.curtainMoves = YES;
    self.indexView.curtainMargins = NO;
    self.indexView.ergonomicHeight = NO;
    if(IS_IPHONE_4){
        self.indexView.upperMargin = 0.0;
    }
    else{
        self.indexView.upperMargin = 22.0;
    }
    self.indexView.lowerMargin = 22.0;
    self.indexView.rightMargin = 3.0;//10
    self.indexView.itemsAligment = NSTextAlignmentCenter;
    self.indexView.maxItemDeflection = 100.0;
    self.indexView.rangeOfDeflection = 5;
    self.indexView.fontColor = [UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1];
    self.indexView.selectedItemFontColor = [UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1];
    self.indexView.darkening = NO;
    self.indexView.fading = YES;
}
-(void)changeTextColorOfSearchBar{
    for (UIView *subView in self.searchBar.subviews)
    {
        for (UIView *secondLevelSubview in subView.subviews){
            if ([secondLevelSubview isKindOfClass:[UITextField class]])
            {
                UITextField *searchBarTextField = (UITextField *)secondLevelSubview;
                
                //set font color here
                searchBarTextField.textColor = [UIColor whiteColor];
                
                break;
            }
        }
    }
}
-(void)initializeArrayAtoZ{
    arrayAtoZ=[[NSArray alloc]initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
}
//-(void)initializeShopsMainArrayWithDummy{
//    [mainArray removeAllObjects];
////    for (NSInteger i=0;i<21; i++) {
////        ShopObject * shopObject=[[ShopObject alloc]initWithID:i];
////        [mainArray addObject:shopObject];
////    }
//    for (int i =0 ; i< arrayAtoZ.count; i++) {
//        Shop * shop = [[DataManager sharedInstance] shopWithId:[@(i) stringValue]];
//        shop.name = [NSString stringWithFormat:@"%@ Shop",arrayAtoZ[i]];
//        if (i % 4 == 0)
//            shop.floor = @"floor 1";
//        else if(i % 5 == 0)
//            shop.floor = @"floor 2";
//        else
//            shop.floor = @"floor 3";
//        [mainArray addObject:shop];
//    }
//}
- (void)getShopsList
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WebManager sharedInstance] getShopsList:^(NSArray *resultArray) {
        
         mainArray = [[NSMutableArray alloc] initWithArray:resultArray];
        
        
        NSPredicate * customPredicate = [NSPredicate predicateWithFormat:@"self.categoryName != %@ && self.categoryName != %@",@"Institution",@"Company"];
        NSArray * tempArray = [mainArray filteredArrayUsingPredicate:customPredicate];
        mainArray = [[NSMutableArray alloc] initWithArray:tempArray];

        [self filterMainArrayForOptionOne];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (mainArray.count == 0)
            ShowMessage(kAppName, NSLocalizedString(@"No shops for this Townbook",nil));
        [self.tableView reloadData];
        
    } failure:^(NSString *errorString) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
         ShowMessage(kAppName,errorString);
    }];
}
-(void)filterMainArrayForOptionOne{
    [mainDictionary removeAllObjects];
    [mainSectionArray removeAllObjects];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [mainArray sortUsingDescriptors:@[sortDescriptor]];

    for (Shop * shop in mainArray) {
        if(![shop isKindOfClass:[NSNull class]])
        {
            NSString * name = shop.name;
            if(name && ![name isEqual:[NSNull null]] && name.length > 0)
            {
                NSString * firstChar = [[name substringToIndex:1]capitalizedString];//changed
                if (firstChar && ![firstChar isEqual:[NSNull null]] )
                {
                    if ([mainDictionary valueForKey:firstChar]) {
                        NSMutableArray * array = [mainDictionary valueForKey:firstChar];
                        [array addObject:shop];
                    }
                    else{
                        NSMutableArray * array = [[NSMutableArray alloc] init];
                        [array addObject:shop];
                        [mainDictionary setObject:array forKey:firstChar];
                        [mainSectionArray addObject:firstChar];
                    }
                }
            }
        }
    }
}
-(void)filterMainArrayForOptionTwo{
    [mainDictionary removeAllObjects];
    [mainSectionArray removeAllObjects];
    
    for (Shop * shop in mainArray)
    {
        NSArray * categories = [shop.categories allObjects];
        for (MACategory * category in categories)
        {
            NSString * shopCategory = category.categoryText;
            if (shopCategory && ![shopCategory isEqual:[NSNull null]] )
            {
                if ([mainDictionary valueForKey:shopCategory]) {
                    NSMutableArray * array = [mainDictionary valueForKey:shopCategory];
                    [array addObject:shop];
//                    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
//                    [array sortUsingDescriptors:@[sortDescriptor]];
                }
                else{
                    NSMutableArray * array = [[NSMutableArray alloc] init];
                    [array addObject:shop];
                    [mainDictionary setObject:array forKey:shopCategory];
                    [mainSectionArray addObject:shopCategory];
                }
            }
        }
    }
     NSArray *sortedSections = [mainSectionArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    mainSectionArray = [[NSMutableArray alloc] initWithArray:sortedSections];
}
-(void)filterMainArrayForOptionThree{
    [mainDictionary removeAllObjects];
    [mainSectionArray removeAllObjects];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"floor" ascending:YES];
    [mainArray sortUsingDescriptors:@[sortDescriptor]];
    
    for (Shop * shop in mainArray) {
        if(![shop isKindOfClass:[NSNull class]])
        {
            NSString * shopFloor = shop.floor;

            if ([mainDictionary valueForKey:shopFloor]) {
                NSMutableArray * array = [mainDictionary valueForKey:shopFloor];
                [array addObject:shop];
            }
            else{
                NSMutableArray * array = [[NSMutableArray alloc] init];
                [array addObject:shop];
                [mainDictionary setObject:array forKey:shopFloor];
                [mainSectionArray addObject:shopFloor];
            }
        }
    }
}
-(CGSize)calculateSizeForText:(NSString *)txt{
    
    CGSize maximumLabelSize = CGSizeMake(290, 600);
    CGSize expectedSectionSize = [txt sizeWithFont:[UIFont systemFontOfSize:14]
                                 constrainedToSize:maximumLabelSize
                                     lineBreakMode:NSLineBreakByTruncatingTail];
    return expectedSectionSize;
}
-(void)loadSearchedData:(NSString *)searchText
{
    [mainSearchedArray removeAllObjects];
    for (Shop * shop in mainArray) {
        NSString * name = shop.name;
        //NSString * category=shop.categoryName;
        if(([name rangeOfString:searchText options:NSCaseInsensitiveSearch].location!=NSNotFound || [searchText isEqualToString:@""]) && name){
            [mainSearchedArray addObject:shop];
        }
//        else if(([category rangeOfString:searchText options:NSCaseInsensitiveSearch].location!=NSNotFound || [searchText isEqualToString:@""]) && category){
//            [mainSearchedArray addObject:shop];
//        }
    }
}
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
//For New logic
-(NSInteger)getShopCountForCategory:(NSString *)cat{
    NSArray * shopArray=[mainDictionary objectForKey:cat];
    if (shopArray) {
        return shopArray.count;
    }
    return 0;
}
#pragma mark-MJNIndexView Protocol
- (NSArray *)sectionIndexTitlesForMJNIndexView:(MJNIndexView *)indexView
{
    if(isFromSearchBar)
    {
        return nil;
    }
    else if(self.segmentBar.selectedSegmentIndex==1 || self.segmentBar.selectedSegmentIndex==2){
        return nil;
    }
    return arrayAtoZ;
}

- (void)sectionForSectionMJNIndexTitle:(NSString *)title atIndex:(NSInteger)index;
{
    int i;
    for (i = 0; i< [mainSectionArray count]; i++) {
        // Here you return the name i.e. Honda,Mazda
        // and match the title for first letter of name
        // and move to that row corresponding to that indexpath as below
        NSString *letterString = mainSectionArray[i];
        if ([letterString isEqualToString:title]) {
            
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:i] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            break;
        }
    }
}
#pragma mark-UITableView DataSource and Delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(isFromSearchBar)
    {
        return 1;
    }
    return [mainSectionArray count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(isFromSearchBar)
    {
        return nil;
    }
    return (NSString*)[mainSectionArray objectAtIndex:section];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (isFromSearchBar) {
        return nil;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    //Background Image with 50%opacity
    if (self.segmentBar.selectedSegmentIndex!=0) {
        UIImageView *bgImgV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 36)];
        bgImgV.image=[UIImage imageNamed:@"list-separator-36"];
        [view addSubview:bgImgV];
    }
    else{
        UIImageView *bgImgV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 28)];
        bgImgV.image=[UIImage imageNamed:@"list-separator-28"];
        [view addSubview:bgImgV];
    }
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    [label setFont:[UIFont systemFontOfSize:14]];
    label.textColor=[UIColor colorWithRed:89.0/255.0 green:89.0/255.0 blue:89.0/255.0 alpha:1];//[UIColor whiteColor];
    NSString *string = [mainSectionArray objectAtIndex:section];
    CGSize sizeString=[self calculateSizeForText:string];
    CGRect lblFrame=label.frame;
    lblFrame.size=sizeString;
    label.frame=lblFrame;
    
    if (self.segmentBar.selectedSegmentIndex!=0) {//For New Logic
        view.frame=CGRectMake(0,0, tableView.frame.size.width, 36);
        label.frame=CGRectMake(10, 0, tableView.frame.size.width, 36);
    }
    [label setText:string];
    [view addSubview:label];

    //For new Logic of Viewing
    if (self.segmentBar.selectedSegmentIndex!=0) {
        view.frame=CGRectMake(0,0, tableView.frame.size.width, 36);
        UILabel * countShopInCat=[[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.size.width-(65+12+18),11,65, 14)];

        countShopInCat.text=[NSString stringWithFormat:@"%li %@",(long)[self getShopCountForCategory:[mainSectionArray objectAtIndex:section]],NSLocalizedString(@"Shops", nil)];
        [countShopInCat setFont:[UIFont systemFontOfSize:12]];
        countShopInCat.textColor=[UIColor colorWithRed:89.0/255.0 green:89.0/255.0 blue:89.0/255.0 alpha:1];
        UIImageView * arrowImage=[[UIImageView alloc]initWithFrame:CGRectMake(tableView.frame.size.width-(12+18), 0, 18, 36)];
        arrowImage.contentMode=UIViewContentModeCenter;
        if (section==selectedSection) {
            arrowImage.image=[UIImage imageNamed:@"services_arrow_up"];
        }
        else{
            arrowImage.image=[UIImage imageNamed:@"services_arrow_down"];
        }
        UIButton * buttonSection=[[UIButton alloc]initWithFrame:view.frame];
        [buttonSection setTitle:@"" forState:UIControlStateNormal];
        buttonSection.backgroundColor=[UIColor clearColor];
        buttonSection.tag=section;
        [buttonSection addTarget:self action:@selector(sectionHasBeenPressed:) forControlEvents:UIControlEventTouchUpInside];
//
        [view addSubview:countShopInCat];
        [view addSubview:arrowImage];
        [view addSubview:buttonSection];
    }
    ///
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (isFromSearchBar) {
        return 0;
    }
    //For new Logic of Viewing
    if (self.segmentBar.selectedSegmentIndex!=0) {
        if (selectedSection==section) {
            return 36+10;
        }
        return 36;
    }
    return 28+8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;//80.0;//66.0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(isFromSearchBar)
    {
        return mainSearchedArray.count;
    }
    NSArray * array=[mainDictionary objectForKey:[mainSectionArray objectAtIndex:section]];

    if (self.segmentBar.selectedSegmentIndex!=0) {//For New Logic
        if (selectedSection==section) {
            return [array count];
        }
        else{
            return 0;
        }
    }
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShopCell * cell =[tableView dequeueReusableCellWithIdentifier:@"shopCell"];
    if (cell == nil) {
        NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"ShopCell" owner:self options:nil];
        cell=[array objectAtIndex:0];
    }
    
//    CenterBannerCell * cell = [tableView dequeueReusableCellWithIdentifier:@"centerBannerCell"];
//    if (cell == nil) {
//        NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"CenterBannerCell" owner:self options:nil];
//        cell=[array objectAtIndex:0];
//    }

    Shop * shop;
    if(isFromSearchBar){
        shop=[mainSearchedArray objectAtIndex:indexPath.row];
    }
    else{
//        MASection *maSection = mainSectionArray[indexPath.section];
//        shop = maSection.groupEntities[indexPath.row];
        shop = [[mainDictionary objectForKey:[mainSectionArray objectAtIndex:indexPath.section]]objectAtIndex:indexPath.row];
    }
//    cell.shopLogoImgV.image=[UtilsFunctions imageWithImage:[UIImage imageNamed:shop.shopLogoName] scaledToSize:CGSizeMake(60, 44)];
//    cell.shopLogoImgV.contentMode=UIViewContentModeCenter;
//    cell.shopLogoImgV.backgroundColor=[UIColor whiteColor];
    //cell.shopLogoImgV.frame=CGRectMake(cell.shopLogoImgV.frame.origin.x, cell.shopLogoImgV.frame.origin.y+1, cell.shopLogoImgV.frame.size.width, cell.shopLogoImgV.frame.size.height-1);
    //[self makeUIImageViewRoundedLeftSide:cell.shopLogoImgV ANDRadiues:3.0 ANDTableViewCell:cell];
//    [cell.shopLogoImgV setImageWithURL:[NSURL URLWithString:shop.logoURL]];
//    cell.lblShopName.text = shop.name;
//    cell.lblShopFloor.text = shop.floor;
//    cell.lblShopTitle.text = shop.briefText;
    [cell.btnBookMark setSelected:NO];
    [cell setShop:shop];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopObject * shopObject = [[ShopObject alloc]initWithID:0];
//    if(isFromSearchBar){
//        shop=[mainSearchedArray objectAtIndex:indexPath.row];
//    }
//    else{
//        shop=[[mainDictionary objectForKey:[mainSectionArray objectAtIndex:indexPath.section]]objectAtIndex:indexPath.row];
//    }
    if (_isFromChat) {
        [delegate shopIsSelectedForChat:[shopObject getDictionaryOfObject]];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    Shop *shop = [[mainDictionary objectForKey:[mainSectionArray objectAtIndex:indexPath.section]]objectAtIndex:indexPath.row];
    [[WebManager sharedInstance] logVisitOfEntity:shop];
    NewShopDetailVC *shopDetailVC=[[NewShopDetailVC alloc]initWithOfferCreatedLocally:[shopObject getDictionaryOfObject] ANDCenterName:shopObject.shopCenterName];
    shopDetailVC.shop = shop;
    shopDetailVC.isForShop = YES;
    [self.navigationController pushViewController:shopDetailVC animated:YES];
}
#pragma mark UISearchBarDelegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length==0) {
        isFromSearchBar=NO;
        [self.searchBar resignFirstResponder];
        [self.segmentBar setEnabled:YES];
        [self.tableView reloadData];
        [self.indexView refreshIndexItems];
        return;
    }
    isFromSearchBar=YES;
    [self.segmentBar setEnabled:NO];
    [self loadSearchedData:self.searchBar.text];
    [self.tableView reloadData];
    [self.indexView refreshIndexItems];
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    isFromSearchBar=NO;
    [self.searchBar resignFirstResponder];
    [self.segmentBar setEnabled:YES];
    [self.tableView reloadData];
    [self.indexView refreshIndexItems];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //    [searchBar resignFirstResponder];
    // Do the search...
}
#pragma mark- ShopCellDelegate
- (void)shopCellBookmarkButtonPressedWithOption:(BOOL)isBM forShop:(Shop *)shop
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    User * user = [[DataManager sharedInstance] currentUser];
    if(isBM)
    {
        [[WebManager sharedInstance] markEntity:shop.entityId isShop:YES
                               favouriteDeleted:NO success:^(id response) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            if (response!= nil)
            {
                [user addFavouriteShopsObject:shop];
                [[DataManager sharedInstance] saveContext];
                ShowMessage(kAppName, NSLocalizedString(@"This shop added to your favorites", nil));
            }
        } failure:^(NSString *errorString) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            ShowMessage(kAppName,errorString);
        }];
    }
    else
    {
        [[WebManager sharedInstance] markEntity:shop.entityId isShop:YES
                               favouriteDeleted:YES success:^(id response) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            if (response!= nil)
            {
                [user removeFavouriteShopsObject:shop];
                [[DataManager sharedInstance] saveContext];
                ShowMessage(kAppName, NSLocalizedString(@"This shop removed from your favorites", nil));
            }
        } failure:^(NSString *errorString) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            ShowMessage(kAppName,errorString);
        }];
    }
}
#pragma mark-IBActions & Selectors
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
- (IBAction)backBtnPressed:(id)sender {
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

- (IBAction)segmentBarValueChanged:(id)sender {
    if(self.segmentBar.selectedSegmentIndex==0){
        [self filterMainArrayForOptionOne];
    }
    else if(self.segmentBar.selectedSegmentIndex==1){
        [self filterMainArrayForOptionTwo];
    }
    else{
        [self filterMainArrayForOptionThree];
    }
    selectedSection=1000; //Assuming never have 100 sections
    [self.tableView reloadData];
    [self.indexView refreshIndexItems];
}
@end
