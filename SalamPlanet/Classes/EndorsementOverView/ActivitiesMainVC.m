//
//  EOverViewVC.m
//  SalamPlanet
//
//  Created by Globit on 22/10/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "ActivitiesMainVC.h"
#import "AppDelegate.h"
#import "User.h"
#import "DataManager.h"
#import "MallCenter.h"
#import "MBProgressHUD.h"
#import "WebManager.h"
#import "Offer.h"
#import "Activity.h"
#import "UIImageView+WebCache.h"
#import "Constants.h"


@interface ActivitiesMainVC ()
{
    AppDelegate * appDelegate;
    BOOL isSlided;
    NSMutableArray * pagesMainArray;
    NSMutableArray * mainArrayOfCollectionViews;
    NSMutableArray * mainActivitiesArray;
    NSMutableArray * colours;
    NSArray * colourNames;
    NSInteger currentCenterPageIndex;
//    HMSegmentedControl *segmentedControl;
}
@end

@implementation ActivitiesMainVC
@synthesize audienceType;
- (id)init
{
    self = [super initWithNibName:@"ActivitiesMainVC" bundle:nil];
    if (self) {
        pagesMainArray=[[NSMutableArray alloc]init];
        mainArrayOfCollectionViews=[[NSMutableArray alloc]init];
        
        [pagesMainArray addObject:NSLocalizedString(@"All", nil)];
        User *user = [[DataManager sharedInstance] currentUser];
        NSArray * array = [user.selectedMalls allObjects];
        NSArray *sortedArray = [self sortMallArrayWithName:array];
        //array = [array sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        for (MallCenter *mallCenter in sortedArray) {
            [pagesMainArray addObject:mallCenter];
        }
//        for (NSString * str in array) {
//            if (![str isEqualToString:NSLocalizedString(@"All", nil)]) {
//                [pagesMainArray addObject:str];
//            }
//        }
        currentCenterPageIndex=0;
        self.pager.isForActivitiesTab = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fillColourNames];
    [self dolocalizationText];
    appDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
//    [self addSegmentBarToViewNew];
    isSlided=NO;
    [self getActivitiesList];
    [self loadMainArrayOfCollectionView];
    [self.pager reloadData];
    self.pager.isForActivitiesTab = YES;
    
    if(_isFromChat){
        [self.btnMenu setImage:[UIImage imageNamed:@"back-button"] forState:UIControlStateNormal];
        [self.btnMenu setImage:[UIImage imageNamed:@"back-button-press"] forState:UIControlStateHighlighted];
        [self.btnCreate setHidden:YES];
    }
    
    [UtilsFunctions makeUIViewRound:self.searchBGView ANDRadius:4];
    
    audienceType=ALL;
    
    //Color
    self.topBarBGView.backgroundColor=[appDelegate getTheGeneralColor];
    [self.centerLogoImgV setImage:[UIImage imageNamed: @"Applogo"]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMalls) name:kUserSelectedMallsEditedNotification object:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    if (!_isFromActivityDetail)
//        
//    else
//        _isFromActivityDetail = NO;

    if (!_isFromChat) {
        [appDelegate hideBottomTabBar:NO];
    }
    [self.pager addSwipeGesturesAgain];
    //[self.pager changeIndexToTheIndex:currentCenterPageIndex];
    self.pager.isForViewWillAppear = YES;
    [self.pager moveToTargetIndex];
}
//-(void)viewWillLayoutSubviews
//{
//    [super viewWillLayoutSubviews];
//    
//    // fixes bug for scrollview's content offset reset.
//    // check SHViewPager's reloadData method to get the idea.
//    // this is a hacky solution, any better solution is welcome.
//    // check closed issues #1 & #2 for more details.
//    // this is the example to fix the bug, to test this
//    // comment out the following lines
//    // and check what happens.
//    
//    if (pagesMainArray.count)
//    {
//        [_pager pagerWillLayoutSubviews];
//    }
//}

#pragma mark-Custom Methods
- (void)reloadMalls
{
    if (pagesMainArray.count>0)
        [pagesMainArray removeAllObjects];

    [pagesMainArray addObject:NSLocalizedString(@"All", nil)];
    User *user = [[DataManager sharedInstance] currentUser];
    NSArray * array = [user.selectedMalls allObjects];
    NSArray *sortedArray = [self sortMallArrayWithName:array];
    for (MallCenter *mallCenter in sortedArray) {
        [pagesMainArray addObject:mallCenter];
    }
    [self loadMainArrayOfCollectionView];
    [self.pager reloadData];
}
- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}
- (NSArray*)sortMallArrayWithName:(NSArray*)array
{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"
                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray;
    sortedArray = [array sortedArrayUsingDescriptors:sortDescriptors];
    return sortedArray;
}
-(void)fillColourNames
{
    colourNames = @[@"Black",@"White",@"Gray",@"DarkGray",@"LightGray",@"Orange",@"Brown",@"Blue",@"Cyan",@"Green",@"Magenta",@"Purple",@"Red",@"Yellow"];
    colours = [[NSMutableArray alloc] init];
    
    [colours addObject:[UIColor blackColor]];
    [colours addObject:[UIColor whiteColor]];
    [colours addObject:[UIColor grayColor]];
    [colours addObject:[UIColor darkGrayColor]];
    [colours addObject:[UIColor lightGrayColor]];
    [colours addObject:[UIColor orangeColor]];
    [colours addObject:[UIColor brownColor]];
    [colours addObject:[UIColor blueColor]];
    [colours addObject:[UIColor cyanColor]];
    [colours addObject:[UIColor greenColor]];
    [colours addObject:[UIColor magentaColor]];
    [colours addObject:[UIColor purpleColor]];
    [colours addObject:[UIColor redColor]];
    [colours addObject:[UIColor yellowColor]];
}

-(void)dolocalizationText{
    [self.segmentControl setTitle:NSLocalizedString(@"All", nil) forSegmentAtIndex:0];
    [self.segmentControl setTitle:NSLocalizedString(@"Offers", nil) forSegmentAtIndex:1];
    [self.segmentControl setTitle:NSLocalizedString(@"News", nil) forSegmentAtIndex:2];
}
- (void)informActivitiesCollectionView
{
    if (_isCollectionReloading)
    {
        _isCollectionReloading = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:kAcitivitesReloadedNotification object:nil];
    }
//    else
//        [self.pager reloadData];
}
- (void)showProgressView
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
- (void)hideProgressView
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}
- (void)loadActivities
{
    MallCenter * currentMall = currentCenterPageIndex == 0? nil:pagesMainArray[currentCenterPageIndex];
    [[WebManager sharedInstance] getOffersListPageNumber:1 forMall:currentMall.mallPlaceId success:^(NSArray *resultArray,int totalRecords) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        //mainActivitiesArray = [[NSMutableArray alloc] initWithArray:resultArray];
        ActivitiesCollecttionVC *ecolVC = (ActivitiesCollecttionVC*)mainArrayOfCollectionViews[currentCenterPageIndex];
        ecolVC.mainArray =[[NSMutableArray alloc] initWithArray:resultArray];;
        ecolVC.pageNumber = 1;
        ecolVC.totalRecords = totalRecords;
        [ecolVC.tableView reloadData];
        if (currentCenterPageIndex == 0)
            [self.pager reloadData];
//        for (int i = 0; i<mainArrayOfCollectionViews.count; i++)
//        {
//            ActivitiesCollecttionVC *ecolVC = (ActivitiesCollecttionVC*)mainArrayOfCollectionViews[i];
//            if (i == 0) {
//                
//                ecolVC.mainArray = mainActivitiesArray;
//            }
//            else
//            {
//                NSPredicate * customPredicate = [NSPredicate predicateWithFormat:@"self.mall.mallPlaceId = %@",[(MallCenter*)pagesMainArray[i] mallPlaceId]];
//                ecolVC.mainArray = (NSMutableArray*)[mainActivitiesArray filteredArrayUsingPredicate:customPredicate];
//            }
//            [ecolVC.tableView reloadData];
//        }
        
        [self informActivitiesCollectionView];
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ShowMessage(kAppName,[error localizedDescription]);
        [self informActivitiesCollectionView];
    }];
}
- (void)getActivitiesList
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [self loadActivities];
}

-(void)loadMainArrayOfCollectionView{
    [mainArrayOfCollectionViews removeAllObjects];
    for (int i=0; i<pagesMainArray.count; i++) {
        ActivitiesCollecttionVC *ecollectVC = [[ActivitiesCollecttionVC alloc] initWithMall:[pagesMainArray objectAtIndex:i] ANDAudianceType:audienceType];
        ecollectVC.delegate=self;
        ecollectVC.isFromChat=_isFromChat;
        [mainArrayOfCollectionViews addObject:ecollectVC];
    }
}
-(void)updateTheViewColorSchemeAccordingToSelectedCenterWithIndex:(NSInteger)indx{
    UIColor * color = [appDelegate getTheGeneralColor];//TODO:Should be nil and parese colour with #
    if (indx == 0)
    {
        color = [appDelegate getTheGeneralColor];
        [self.centerLogoImgV setImage:[UIImage imageNamed: @"Applogo"]];
    }
    else
    {
        MallCenter *mallCenter = (MallCenter*)[pagesMainArray objectAtIndex:indx];
        if (mallCenter.corporateColor && ![mallCenter.corporateColor hasPrefix:@"#"])
        {
            NSUInteger index = [colourNames indexOfObject:mallCenter.corporateColor];
            color = [colours objectAtIndex:index];
        }
        else if(mallCenter.corporateColor && [mallCenter.corporateColor hasPrefix:@"#"])
        {
            color = [self colorFromHexString:mallCenter.corporateColor];
        }
        [self.centerLogoImgV setImageWithURL:[NSURL URLWithString:mallCenter.logoURL] placeholderImage:[UIImage imageNamed:@"place-holder"]];
    }
    [self.topBarBGView setBackgroundColor:color];
}
#pragma mark - SHViewPagerDataSource stack

- (NSInteger)numberOfPagesInViewPager:(SHViewPager *)viewPager
{
    return pagesMainArray.count;
}

- (UIViewController *)containerControllerForViewPager:(SHViewPager *)viewPager
{
    return self;
}

- (UIViewController *)viewPager:(SHViewPager *)viewPager controllerForPageAtIndex:(NSInteger)index
{
    return [mainArrayOfCollectionViews objectAtIndex:index];
}

- (UIImage *)indexIndicatorImageForViewPager:(SHViewPager *)viewPager
{
    return [UIImage imageNamed:@"horizontal_line"];
}

- (UIImage *)indexIndicatorImageDuringScrollAnimationForViewPager:(SHViewPager *)viewPager
{
    return [UIImage imageNamed:@"horizontal_line_moving"];
}

- (NSString *)viewPager:(SHViewPager *)viewPager titleForPageMenuAtIndex:(NSInteger)index
{
    if (index == 0)
        return [pagesMainArray objectAtIndex:index];
    else
        return [(MallCenter*)[pagesMainArray objectAtIndex:index] name];
}

- (SHViewPagerMenuWidthType)menuWidthTypeInViewPager:(SHViewPager *)viewPager
{
    return SHViewPagerMenuWidthTypeDefault;
}
- (UIColor *)colorForMenuInViewPager:(SHViewPager *)viewPager{
    return [UIColor colorWithRed:214.0/255.0 green:214.0/255.0 blue:214.0/255.0 alpha:1.0];
    //return [UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0];
    //return [UIColor colorWithRed:206.0/255.0 green:206.0/255.0 blue:206.0/255.0 alpha:1.0];
}
#pragma mark - SHViewPagerDelegate stack

- (void)firstContentPageLoadedForViewPager:(SHViewPager *)viewPager
{
    //NSLog(@"first viewcontroller content loaded");
}

- (void)viewPager:(SHViewPager *)viewPager :(NSInteger)toIndex fromIndex:(NSInteger)fromIndex
{
   // NSLog(@"content will move to page %ld from page: %ld", (long)toIndex, (long)fromIndex);
}

- (void)viewPager:(SHViewPager *)viewPager didMoveToPageAtIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex
{
   // NSLog(@"content moved to page%ld from page: %ld", (long) toIndex, (long)fromIndex);
    currentCenterPageIndex=toIndex;
    [self updateTheViewColorSchemeAccordingToSelectedCenterWithIndex:toIndex];
    if (toIndex == 0 )
    {
        [[DataManager sharedInstance] setCurrentMall:nil];
    }
    else
    {
        [[DataManager sharedInstance] setCurrentMall:pagesMainArray[toIndex]];
        [[WebManager sharedInstance] logVisitOfEntity:pagesMainArray[toIndex]];
         [self getActivitiesList];
    }
//    ActivitiesCollecttionVC *activityCollectionVC = (ActivitiesCollecttionVC *)[self viewPager:viewPager controllerForPageAtIndex:toIndex];
//    
//    [activityCollectionVC.tableView reloadData];
}
-(void)rightSwipedWhenIndexisZero{
    [self showSliderAction:nil];
}
#pragma mark:ActivitiesCollectionVCDelegate
-(void)addTheCategorySubCategorInFavList:(BOOL)isCat ANDName:(NSString *)name{
    for (NSString * str in pagesMainArray) {
        if ([str isEqualToString:name]) {
            return;
        }
    }
    [pagesMainArray addObject:name];
    SaveArrayWithKey(pagesMainArray, kArrayFavouriteCatSubCat);
    [self sortArrayWithAlphaOrder];
    [self loadMainArrayOfCollectionView];
    [self.pager reloadData];
}
-(void)endorementIsSelectedForChat:(NSDictionary *)endoreD{
    [_delegate endoreIsSelectForChat:endoreD];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)sortArrayWithAlphaOrder{
    
    [pagesMainArray removeObject:NSLocalizedString(@"All", nil)];
    NSArray*  array = [pagesMainArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    [pagesMainArray removeAllObjects];
    [pagesMainArray addObject:NSLocalizedString(@"All", nil)];
    for (NSString * str in array) {
        [pagesMainArray addObject:str];
    }

}
#pragma mark-Selectors
- (IBAction)segmentedControlChangedValue:(UISegmentedControl *)segmentedControl {
    audienceType=segmentedControl.selectedSegmentIndex;
    appDelegate.audianceType = audienceType;
    for (ActivitiesCollecttionVC * ecolVC in mainArrayOfCollectionViews) {
        [ecolVC doActionOnAudienceSegmentChange:audienceType];
    }
}
#pragma mark:IBActions
- (IBAction)showSliderAction:(id)sender {
    if (_isFromChat) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    NSString * centerName = nil;
    if (currentCenterPageIndex == 0)
        centerName = NSLocalizedString(@"All", nil);
    else
        centerName=[(MallCenter*)[pagesMainArray objectAtIndex:currentCenterPageIndex] logoURL];
    if(isSlided){
        [appDelegate showHideSlideMenue:YES withCenterName:centerName];
        isSlided=NO;
    }
    else{
        [appDelegate showHideSlideMenue:YES withCenterName:centerName];
        isSlided=YES;
    }
}

@end
