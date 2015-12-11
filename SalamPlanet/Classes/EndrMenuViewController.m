//
//  EndrMenuViewController.m
//  SalamPlanet
//
//  Created by Globit on 25/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "EndrMenuViewController.h"
#import "EndrMenuCell.h"
#import "CategoryCell.h"
#import "AppDelegate.h"
#import "Constants.h"
#import "ShopsVC.h"
#import "ServiceVC.h"
#import "RestaurantVC.h"
#import "UtilsFunctions.h"
#import "CalculateDiscountVC.h"
#import "BookmarkVC.h"
#import "OpeningHoursMainVC.h"
#import "DirectioanAndParkingMainVC.h"
#import "UIImageView+WebCache.h"
#import "NewShopDetailVC.h"
#import "DataManager.h"
#import "CompaniesVC.h"
#import "InstitutionsVC.h"

@interface EndrMenuViewController ()
{
    NSMutableArray * mainArray;
    NSArray * catArray;
    NSDictionary * subCatDict;
    AppDelegate * appDelegate;
    NSMutableString * selectedCat;
    BOOL noCenterSelected;
    NSArray * menuIconArray;
}
@end

@implementation EndrMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    mainArray=[[NSMutableArray alloc]init];
    selectedCat=[[NSMutableString alloc]initWithString:@""];

    [self loadMainArrayToDefault];
    appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    catArray=appDelegate.categoryArray;
    subCatDict=appDelegate.subCategoryDict;

    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sideMenu_background.png"]];
    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [self.bgImgV setImage:[UIImage imageNamed:[appDelegate getBackgroundImageName]]];
}
-(void)viewWillAppearOnScreen{
//    if (appDelegate.audianceType==ALL) {
//        noCenterSelected=YES;
//    }
//    else{
//        noCenterSelected=NO;
//    }
}

#pragma mark-Custom Methods
-(void)animateLabel{
    self.lblNoCenter.alpha = 0;
    
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         // moves label down 100 units in the y axis
                         self.lblNoCenter.transform = CGAffineTransformMakeTranslation(0, 0);
                         // fade label in
                         self.lblNoCenter.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.2
                                               delay:0
                                             options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              // move label down further by 100 units
                                              self.lblNoCenter.transform = CGAffineTransformMakeTranslation(0,400);
                                              // fade label out
                                              self.lblNoCenter.alpha = 0;
                                          }
                                          completion:nil];
                     }];
}
#pragma mark: UITableView Delegates and Datasource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mainArray count]+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==mainArray.count) {
        return 120.0;
    }
    return 50.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==mainArray.count) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AppLogoCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell
        ;
    }
    static NSString *MySecIdentifier = @"catCell";

    CategoryCell * cell = [tableView dequeueReusableCellWithIdentifier:MySecIdentifier];
    if (!cell) {
        NSArray * nibArray = [[NSBundle mainBundle] loadNibNamed:@"CategoryCell" owner:nil options:nil];
        cell = (CategoryCell*)[nibArray objectAtIndex:0];
    }
    cell.txtLbl.text=[mainArray objectAtIndex:indexPath.row];
            cell.txtLbl.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:16];
    cell.imgVw.image=[UIImage imageNamed:[menuIconArray objectAtIndex:indexPath.row]];
    if (noCenterSelected && indexPath.row !=0) {
        cell.txtLbl.textColor=[UIColor lightGrayColor];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    UIView * selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
//    [selectedBackgroundView setBackgroundColor:[UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1.0]]; // set color here
//    [cell setSelectedBackgroundView:selectedBackgroundView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath :(NSIndexPath *)indexPath
{
    if (indexPath.row == mainArray.count)
        return;
    
    if (indexPath.row == 0) {
        [appDelegate popHomeOverViewPage];
    }
    else if (noCenterSelected) {
        ShowMessage(kAppName,NSLocalizedString(@"Please select a Town from Home page first.",nil));
        return;
    }
    else if(indexPath.row == 1){
        //OpeningHoursMainVC * openingHoursMainVC=[[OpeningHoursMainVC alloc]init];
        NewShopDetailVC *shopDetailVC=[[NewShopDetailVC alloc]initWithOfferCreatedLocally:nil ANDCenterName:nil];
        shopDetailVC.mall = [[DataManager sharedInstance] currentMall];
        [appDelegate pushToOverPageVC:shopDetailVC];
    }
    else if(indexPath.row == 2)
    {
        ShopsVC *shopVC=[[ShopsVC alloc]init];
        [appDelegate pushToOverPageVC:shopVC];
    }
    else if(indexPath.row == 3){
        RestaurantVC * restaurantVC=[[RestaurantVC alloc]init];
        [appDelegate pushToOverPageVC:restaurantVC];
    }
    else if(indexPath.row == 4)
    {
        CompaniesVC *companiesVC = [[CompaniesVC alloc] init];
        [appDelegate pushToOverPageVC:companiesVC];
    }
    else
    {
        InstitutionsVC *institutionsVC = [[InstitutionsVC alloc] init];
        [appDelegate pushToOverPageVC:institutionsVC];
    }
}
#pragma mark - Custom methods
-(void)loadMainArrayToDefault{
    [mainArray removeAllObjects];
    [mainArray addObject:NSLocalizedString(@"Home", nil)];
    [mainArray addObject:NSLocalizedString(@"Town Information", nil)];
    [mainArray addObject:NSLocalizedString(@"Shops", nil)];
    [mainArray addObject:NSLocalizedString(@"Restaurants", nil)];
    [mainArray addObject:NSLocalizedString(@"Businesses", nil)];
    [mainArray addObject:NSLocalizedString(@"Institutions", nil)];
    
    menuIconArray=[NSArray arrayWithObjects:@"sideMenu_home",@"towninfoL",@"sideMenu_shops",@"sideMenu_restaurant",@"copanylistL", @"institutuinsL",nil];
   //imageName @"sideMenu_directions",@"sideMenu_map"
}
-(void)changeTheCenterLogoWithImageName:(NSString *)imageName{
    if ([imageName isEqualToString:NSLocalizedString(@"All", nil)]) {
        noCenterSelected=YES;
    }
    else if (imageName == nil)
    {
        
    }
    else{
        noCenterSelected=NO;
        [self.centerLogoImgV setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@"place-holder"]];
    }
    [self.lblNoCenter setHidden:!noCenterSelected];
    [self.centerLogoImgV setHidden:noCenterSelected];
    [self.tableView reloadData];
}
@end
