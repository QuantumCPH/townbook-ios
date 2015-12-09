//
//  ShopsVC.m
//  SalamCenterApp
//
//  Created by Globit on 29/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "ServiceVC.h"
#import "AppDelegate.h"
#import "NewShopDetailVC.h"
#import "UtilsFunctions.h"
#import "WebManager.h"
#import "MAService.h"
#import "MBProgressHUD.h"
#import "EntityMapAddressVC.h"
#import "UIImageView+WebCache.h"

@interface ServiceVC ()
{
    AppDelegate * appDelegate;
    NSMutableArray * mainArray;
    NSMutableArray * mainSearchedArray;
    NSMutableDictionary * mainDictionary;
    NSMutableArray * mainSectionArray;

    NSArray * arrayAtoZ;
    BOOL isFromSearchBar;
    BOOL isSlided;
    IBOutlet UIView *serviceMapView;
}
@property (strong, nonatomic) IBOutlet UIImageView *mapImageView;

@end

@implementation ServiceVC
@synthesize indexPathSelected;
-(id)init{
    self = [super initWithNibName:@"ServiceVC" bundle:nil];
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
    
    [self getMallServicesFromServer];
    //[self initializeShopsMainArrayWithDummy];
    [self filterMainArray];
    isSlided=NO;
    
    [self.tableView setContentInset:UIEdgeInsetsMake(8,0,0,0)];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [appDelegate hideBottomTabBar:YES];
}
-(void)dolocalizationText{
    self.lblPageTitle.text=NSLocalizedString(@"Services", nil);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-Custom Methods
- (void)getMallServicesFromServer
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WebManager sharedInstance] getServicesList:^(NSArray *resultArray, NSString *message) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (message){
            ShowMessage(kAppName,message);
        }
        else if(resultArray.count == 0)
        {
            ShowMessage(kAppName, NSLocalizedString(@"No services available for this Mall",nil));
        }
        else
        {
            mainArray = [[NSMutableArray alloc] initWithArray:resultArray];
            [self filterMainArray];
            [self.tableView reloadData];
        }
    } failure:^(NSString *errorString) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ShowMessage(kAppName,errorString);
    }];
}
-(void)initializeCustomIndexView{
    // initialise MJNIndexView
    CGRect frame = [UIScreen mainScreen].bounds;
    frame.origin.y+=108;
    frame.size.height-=108;
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
//    for (NSInteger i=0;i<26; i++) {
//        ServiceObject * serviceObject=[[ServiceObject alloc]initWithID:i];
//        [mainArray addObject:serviceObject];
//    }
//}
-(void)filterMainArray{
    [mainDictionary removeAllObjects];
    [mainSectionArray removeAllObjects];
    
    for (MAService * service in mainArray) {
        if(![service isKindOfClass:[NSNull class]])
        {
            NSString * name = service.name;
            if(name && ![name isEqual:[NSNull null]] && name.length > 0)
            {
                NSString * firstChar = [[name substringToIndex:1]capitalizedString];//changed
                if (firstChar && ![firstChar isEqual:[NSNull null]] )
                {
                    if ([mainDictionary valueForKey:firstChar]) {
                        NSMutableArray * array = [mainDictionary valueForKey:firstChar];
                        [array addObject:service];
                    }
                    else{
                        NSMutableArray * array = [[NSMutableArray alloc] init];
                        [array addObject:service];
                        [mainDictionary setObject:array forKey:firstChar];
                        [mainSectionArray addObject:firstChar];
                    }
                }
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
    for (MAService * service in mainArray) {
        NSString * name = service.name;
        if(([name rangeOfString:searchText options:NSCaseInsensitiveSearch].location!=NSNotFound || [searchText isEqualToString:@""]) && name){
            [mainSearchedArray addObject:service];
        }
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
-(void)makeUIImageViewRoundedTopSide:(UIImageView*)imgView ANDRadiues:(float)rad ANDTableViewCell:(UITableViewCell *)cell{
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:imgView.bounds
                                     byRoundingCorners:(UIRectCornerTopRight | UIRectCornerTopLeft)
                                           cornerRadii:CGSizeMake(rad, rad)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = cell.bounds;
    maskLayer.path = maskPath.CGPath;
    imgView.layer.mask = maskLayer;
}
#pragma mark-MJNIndexView Protocol
- (NSArray *)sectionIndexTitlesForMJNIndexView:(MJNIndexView *)indexView
{
    if(isFromSearchBar)
    {
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
        NSString *letterString = [mainSectionArray objectAtIndex:i];
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
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//}
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
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPathSelected && [indexPathSelected isEqual:indexPath]) {
        return 375.0;
    }
    return 100.0;//66.0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(isFromSearchBar)
    {
        return mainSearchedArray.count;
    }
    NSArray * array=[mainDictionary objectForKey:[mainSectionArray objectAtIndex:section]];
    return [array count];
}

//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//    if(isFromSearchBar)
//    {
//        return nil;
//    }
//    tableView.sectionIndexColor=[UIColor whiteColor];//[UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1];
//    tableView.sectionIndexBackgroundColor=[UIColor clearColor];
//    return arrayAtoZ;
//}
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
//    int i;
//    for (i = 0; i< [mainSectionArray count]; i++) {
//        // Here you return the name i.e. Honda,Mazda
//        // and match the title for first letter of name
//        // and move to that row corresponding to that indexpath as below
//        NSString *letterString = [mainSectionArray objectAtIndex:i];
//        if ([letterString isEqualToString:title]) {
//            
//            [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:i] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//            break;
//        }
//    }
//    return i;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MAService * service;
    if(isFromSearchBar)
        service = [mainSearchedArray objectAtIndex:indexPath.row];
    else
        service = [[mainDictionary objectForKey:[mainSectionArray objectAtIndex:indexPath.section]]objectAtIndex:indexPath.row];

    if (indexPathSelected && [indexPathSelected isEqual:indexPath]) {
        ServiceDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"serviceDetailCell"];
        if (cell == nil) {
            NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"ServiceDetailCell" owner:self options:nil];
            cell=[array objectAtIndex:0];
        }
        [cell setService:service];
        cell.delegate = self;
//        ServiceObject * service;
//        if(isFromSearchBar){
//            service=[mainSearchedArray objectAtIndex:indexPath.row];
//        }
//        else{
//            service=[[mainDictionary objectForKey:[mainSectionArray objectAtIndex:indexPath.section]]objectAtIndex:indexPath.row];
//        }
//        cell.serviceImage.image=[UIImage imageNamed:service.serviceImgName];
//        //[self makeUIImageViewRoundedTopSide:cell.serviceImage ANDRadiues:4 ANDTableViewCell:cell];
//        
//        cell.serviceNameLbl.text=service.serviceName;
//        cell.serviceFloorLbl.text=service.serviceFloor;
//        cell.telLbl.text=service.serviceTelNumber;
//        cell.descriptionTV.text=service.serviceDescription;
//        cell.addressTV.text=service.serviceAddress;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    ServiceCell * cell = [tableView dequeueReusableCellWithIdentifier:@"serviceCell"];
    if (cell == nil) {
        NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"ServiceCell" owner:self options:nil];
        cell=[array objectAtIndex:0];
    }
    [cell setService:service];
    //    cell.shopLogoImgV.image=[UIImage imageNamed:service.serviceImgName];
//    //[self makeUIImageViewRoundedLeftSide:cell.shopLogoImgV ANDRadiues:4 ANDTableViewCell:cell];
//    
//    cell.lblShopName.text=service.serviceName;
//    cell.lblShopFloor.text=service.serviceFloor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPathSelected isEqual:indexPath]) {
        indexPathSelected=nil;
    }
    else{
        indexPathSelected=indexPath;
    }
    [self.tableView reloadData];
    [self.indexView refreshIndexItems];
}
#pragma mark UISearchBarDelegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length==0) {
        isFromSearchBar=NO;
        [self.searchBar resignFirstResponder];
        [self.tableView reloadData];
        [self.indexView refreshIndexItems];
        return;
    }
    isFromSearchBar=YES;
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

    [self.tableView reloadData];
    [self.indexView refreshIndexItems];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //    [searchBar resignFirstResponder];
    // Do the search...
}
#pragma mark ServiceDetailCellDelegate
- (void)serviceDetailCellLocationButtonTappedForService:(MAService *)service
{
    [serviceMapView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    serviceMapView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [_mapImageView setImageWithURL:[NSURL URLWithString:service.siteMapURL] placeholderImage:[UIImage imageNamed:@"place-holder"]];
    [self.view addSubview:serviceMapView];
   //    ServiceMapVC *serviceMapVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"ServiceMapVC"];
//
//    [self presentViewController:serviceMapVC animated:YES completion:nil];
}
#pragma mark-IBActions & Selectors
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
- (IBAction)mapCloseTapped:(id)sender {
    [serviceMapView removeFromSuperview];
}

@end
