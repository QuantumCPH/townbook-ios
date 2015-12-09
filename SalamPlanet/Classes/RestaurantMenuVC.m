//
//  RestaurantMenuVC.m
//  SalamCenterApp
//
//  Created by Globit on 09/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import "RestaurantMenuVC.h"
#import "AppDelegate.h"
#import "RestMenuDish.h"
#import "Restaurant.h"
#import "MenuCategory.h"
#import "MBProgressHUD.h"
#import "WebManager.h"

@interface RestaurantMenuVC ()
{
    AppDelegate * appDelegate;
    NSMutableArray * mainArrayOfVC;
    NSMutableArray * mainArrayAllMenuTypes;
    NSMutableArray * mainArrayAllMenuTypesTitles;
    NSArray * menuCategories;
    NSMutableArray *mainMenuItems;
}
@end

@implementation RestaurantMenuVC
- (id)init
{
    self = [super initWithNibName:@"RestaurantMenuVC" bundle:nil];
    if (self) {
        appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
        mainArrayOfVC=[[NSMutableArray alloc]init];
        mainArrayAllMenuTypes=[[NSMutableArray alloc]init];
        mainArrayAllMenuTypesTitles=[[NSMutableArray alloc]init];
        mainMenuItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dolocalizationText];
    [self.bgImgV setImage:[UIImage imageNamed:[appDelegate getBackgroundImageName]]];
    self.lblPageTitle.font=[appDelegate getFontOfPageTitle];
    menuCategories = [self.restaurant.menuCategories allObjects];
    
    //[self loadDummyData];
    [self laodMenuItemsFromServer];
    [self loadMainArrayOfCollectionView];
    
    [self.pagerView reloadData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [appDelegate hideBottomTabBar:YES];
    self.pagerView.isForViewWillAppear = YES;
    [self.pagerView moveToTargetIndex];
    //[self.pagerView changeIndexToTheIndex:0];
}
-(void)dolocalizationText{
    self.lblPageTitle.text=NSLocalizedString(@"MENU", nil);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-Custom Methods
- (void)laodMenuItemsFromServer
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WebManager sharedInstance] getMenuListOfRestaurant:_restaurant.entityId success:^(NSArray *resultArray, NSString *message) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (!message)
        {
            mainMenuItems = [[NSMutableArray alloc] initWithArray:resultArray];
            for (int i = 0;i < mainArrayOfVC.count; i++)
            {
                RestMenuTableVC *menuTableVC = (RestMenuTableVC*)mainArrayOfVC[i];
                NSPredicate * customPredicate = [NSPredicate predicateWithFormat:@"self.itemCategory.menuCategoryId = %@",[(MenuCategory*)menuCategories[i] menuCategoryId]];
                menuTableVC.menuItems = (NSMutableArray*)[mainMenuItems filteredArrayUsingPredicate:customPredicate];
                [menuTableVC.tableView reloadData];
            }
            [self.pagerView reloadData];
        }
        else
            ShowMessage(kAppName, message);
        
    } failure:^(NSString *errorString) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ShowMessage(kAppName,errorString);
    }];
}
-(void)loadDummyData{
    [mainArrayAllMenuTypes removeAllObjects];
    [mainArrayAllMenuTypesTitles removeAllObjects];
    
    for (NSInteger i=0; i<24; i++) {
        RestMenuDish * restMenuDish=[[RestMenuDish alloc]initWithID:i];
        if (![mainArrayAllMenuTypesTitles containsObject:restMenuDish.dishType]) {
            [mainArrayAllMenuTypesTitles addObject:restMenuDish.dishType];
        }
        [mainArrayAllMenuTypes addObject:restMenuDish];
    }
}
-(void)loadMainArrayOfCollectionView{
    [mainArrayOfVC removeAllObjects];
    
    for ( int i = 0;i<menuCategories.count;i++)
    {
        RestMenuTableVC * tableVC = [[RestMenuTableVC alloc] initWithDishesArray:nil];
        [mainArrayOfVC addObject:tableVC];
    }
//    for (int i=0;i<mainArrayAllMenuTypesTitles.count;i++) {
//        NSMutableArray * tempArray=[[NSMutableArray alloc]init];
//        NSString * type=[mainArrayAllMenuTypesTitles objectAtIndex:i];
//        for (RestMenuDish * restMenuDish in mainArrayAllMenuTypes) {
//            if ([restMenuDish.dishType isEqualToString:type]) {
//                [tempArray addObject:restMenuDish];
//            }
//        }
//        RestMenuTableVC * tableVC=[[RestMenuTableVC alloc]initWithDishesArray:tempArray];
//        [mainArrayOfVC addObject:tableVC];
//    }
}
#pragma mark - SHViewPagerDataSource stack

- (NSInteger)numberOfPagesInViewPager:(SHViewPager *)viewPager
{
//    return mainArrayAllMenuTypesTitles.count;
    return menuCategories.count;
}

- (UIViewController *)containerControllerForViewPager:(SHViewPager *)viewPager
{
    return self;
}

- (UIViewController *)viewPager:(SHViewPager *)viewPager controllerForPageAtIndex:(NSInteger)index
{
    return [mainArrayOfVC objectAtIndex:index];
}

- (UIImage *)indexIndicatorImageForViewPager:(SHViewPager *)viewPager
{
    return [UIImage imageNamed:@"horizontal_line.png"];
}

- (UIImage *)indexIndicatorImageDuringScrollAnimationForViewPager:(SHViewPager *)viewPager
{
    return [UIImage imageNamed:@"horizontal_line_moving.png"];
}

- (NSString *)viewPager:(SHViewPager *)viewPager titleForPageMenuAtIndex:(NSInteger)index
{
    //return [mainArrayAllMenuTypesTitles objectAtIndex:index];
    return [(MenuCategory*)menuCategories[index] title];
}

- (SHViewPagerMenuWidthType)menuWidthTypeInViewPager:(SHViewPager *)viewPager
{
    return SHViewPagerMenuWidthTypeDefault;
}
- (UIColor *)colorForMenuInViewPager:(SHViewPager *)viewPager{
    return [UIColor colorWithRed:206.0/255.0 green:206.0/255.0 blue:206.0/255.0 alpha:1.0];
}
#pragma mark - SHViewPagerDelegate stack

- (void)firstContentPageLoadedForViewPager:(SHViewPager *)viewPager
{
    NSLog(@"first viewcontroller content loaded");
}

- (void)viewPager:(SHViewPager *)viewPager :(NSInteger)toIndex fromIndex:(NSInteger)fromIndex
{
    NSLog(@"content will move to page %ld from page: %ld", (long)toIndex, (long)fromIndex);
}

- (void)viewPager:(SHViewPager *)viewPager didMoveToPageAtIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex
{
    NSLog(@"content moved to page%ld from page: %ld", (long) toIndex, (long)fromIndex);
}
-(void)rightSwipedWhenIndexisZero{
    //do nothing
}

#pragma mark-IBActions and Selectors
- (IBAction)backBtnPressed:(id)sender {
    [self.backBtn setSelected:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
