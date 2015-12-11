//
//  RegStepOneVC.m
//  SalamCenterApp
//
//  Created by Globit on 02/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "RegStepOneVC.h"
#import "CenterObject.h"
#import "HMSegmentedControl.h"
#import "AppDelegate.h"
#import "UtilsFunctions.h"
#import "Constants.h"
#import "MBProgressHUD.h"
#import "WebManager.h"
#import "MallCenter.h"
#import "UIImageView+WebCache.h"
#import "DataManager.h"
#import "User.h"

@interface RegStepOneVC ()
{
    NSMutableArray * mainArray;
    NSMutableArray * mainArrayAll;
    NSMutableArray * mainArrayNearby;
    NSMutableArray * selectedMalls;
    CenterType centerType;
    AppDelegate * appDelegate;
    NSInteger selectedCount;
    User *user;
    BOOL shouldDisplayProgress;
}
@end

@implementation RegStepOneVC
-(id)init{
    self = [super initWithNibName:@"RegStepOneVC" bundle:nil];
    if (self) {
        mainArray=[[NSMutableArray alloc]init];
        mainArrayAll=[[NSMutableArray alloc]init];
        mainArrayNearby=[[NSMutableArray alloc]init];
        selectedMalls = [[NSMutableArray alloc] init];
        appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
        selectedCount=0;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self dolocalizationText];
    [self.bgImgV setImage:[UIImage imageNamed:[appDelegate getBackgroundImageName]]];
    self.lblPageTitle.font=[appDelegate getFontOfPageTitle];

    user = [[DataManager sharedInstance] currentUser];
    if (_isFromEdit)
    {
        [appDelegate hideWithoutAnimationBottomTabBar:YES];
    }
    else
        self.backBtn.hidden = YES;
    
    [self getMallsList];
    centerType = Nearby;
    [self.segmentBar setSelectedSegmentIndex:1];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.btnNext setSelected:NO];
}
-(void)dolocalizationText{
    self.lblPageTitle.text=NSLocalizedString(@"Select your favourite town", nil);
    [self.segmentBar setTitle:NSLocalizedString(@"All", nil) forSegmentAtIndex:0];
    [self.segmentBar setTitle:NSLocalizedString(@"Nearby", nil) forSegmentAtIndex:1];
    if (!_isFromEdit)
    {
        [self.btnNext setTitle:NSLocalizedString(@"Next", nil) forState:UIControlStateNormal];
        [self.btnNext setTitle:NSLocalizedString(@"Next", nil) forState:UIControlStateHighlighted];
        [self.btnNext setTitle:NSLocalizedString(@"Next", nil) forState:UIControlStateSelected];
    }
    else
    {
        [self.btnNext setTitle:NSLocalizedString(@"Update", nil) forState:UIControlStateNormal];
        [self.btnNext setTitle:NSLocalizedString(@"Update", nil) forState:UIControlStateSelected];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark: Custom Methods
- (void)sortMallsWithDistance
{
    if (user.latitude != 0.00 && user.longitude != 0.00)
    {
        CLLocation *userLocation = [[CLLocation alloc] initWithLatitude:(CLLocationDegrees)user.latitude longitude:(CLLocationDegrees)user.longitude];
        for (MallCenter *mall in mainArrayNearby)
        {
            CLLocation *mallLocation = [[CLLocation alloc] initWithLatitude:mall.latitude longitude:mall.longitude];
            CLLocationDistance distanceMeters = [userLocation distanceFromLocation:mallLocation];
            mall.currentDistance = distanceMeters;
        }
        [self applySortDiscriptorOnNearbyArray];
        NSArray *filteredArray  = [mainArrayNearby filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"currentDistance<100000"]];
        mainArrayNearby = [[NSMutableArray alloc] initWithArray:filteredArray];
        [self applySortDiscriptorOnNearbyArray];
        [self.tableView reloadData];
        if (mainArrayNearby.count == 0)
        {
            ShowMessage(kAppName, NSLocalizedString(@"No towns are nearby",nil));
        }
    }
}
- (void)applySortDiscriptorOnNearbyArray
{
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"currentDistance" ascending:YES];
    [mainArrayNearby sortUsingDescriptors:@[sortDescriptor]];
}
- (void)getMallsList
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WebManager sharedInstance] getMallsList:^(NSArray *resultArray) {
        if (user.selectedMalls.count != 0 && !shouldDisplayProgress)
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        mainArray =[[NSMutableArray alloc] initWithArray:resultArray];
        mainArrayNearby = [[NSMutableArray alloc] initWithArray:resultArray];
        [self sortMallsWithDistance];
        if (_isFromEdit)
        {
            [selectedMalls addObjectsFromArray:user.selectedMalls.allObjects];
        }
        [self.tableView reloadData];
        
    } failure:^(NSString *errorString) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ShowMessage(kAppName, errorString);
    }];
    if (user.selectedMalls.count == 0)
    {
        shouldDisplayProgress = YES;
        [[WebManager sharedInstance] getSelectedMalls:^(NSArray *resultArray) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            shouldDisplayProgress = NO;
            if (resultArray.count>0) {
                [selectedMalls addObjectsFromArray:resultArray];
                //[self sortMallsWithDistance];
                [self saveSelectedMalls];
                [self.tableView reloadData];
            }
            else
                [self.tableView reloadData];
        } failure:^(NSError *error) {
            shouldDisplayProgress = NO;
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }];
    }
}
- (void)saveSelectedMalls
{
    if (user.selectedMalls.count>0)
        [user removeSelectedMalls:user.selectedMalls];
    
    [user addSelectedMalls:[NSSet setWithArray:selectedMalls]];
    [[DataManager sharedInstance] saveContext];
}
- (void)saveMallsAndShowNextScreen
{
    [self saveSelectedMalls];
    [appDelegate changeRootViewToStartApp];
}
#pragma mark: UITableView Delegates and Datasource Methods=
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(centerType==All){
        return mainArray.count;
    }
    else{
        return mainArrayNearby.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SCenterCell * cell=[tableView dequeueReusableCellWithIdentifier:@"sCenterCell"];
    if (!cell) {
        NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"SCenterCell" owner:self options:nil];
        cell=[array objectAtIndex:0];
    }
    
    MallCenter * mallCenter;
    if(centerType==All){
        mallCenter = [mainArray objectAtIndex:indexPath.row];
    }
    else{
        mallCenter = [mainArrayNearby objectAtIndex:indexPath.row];
    }
    
    cell.centerNameLbl.text = mallCenter.name;
    cell.placeNameLbl.text = mallCenter.placeName;
    cell.centerCityLbl.text = mallCenter.city;
    
    cell.heartBtn.tag = indexPath.row;
    
    [cell.centerImgV setImageWithURL:[NSURL URLWithString:mallCenter.logoURL] placeholderImage:[UIImage imageNamed:@"place-holder"]];
    if ([selectedMalls containsObject:mallCenter])
    {
        [cell makeHearPressed:YES];
    }
    else
    {
        [cell makeHearPressed:NO];
    }
    cell.delegate=self;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath :(NSIndexPath *)indexPath{
    NSLog(@"%li",(long)indexPath.row);
}
#pragma mark: SCenterCellDelegate
-(void)centerIsSelectedButtonPressedWithOption:(BOOL)isSel ANDTag:(NSInteger)tag{
    
    MallCenter *mallCenter;
    if (centerType == All)
    {
        mallCenter = [mainArray objectAtIndex:tag];
    }
    else if (centerType == Nearby)
    {
        mallCenter = [mainArrayNearby objectAtIndex:tag];
    }
    
    if ([selectedMalls containsObject:mallCenter]) {
        [selectedMalls removeObject:mallCenter];
    }
    else
    {
        [selectedMalls addObject:mallCenter];
    }
}
#pragma mark-IBActions and Selectors
- (IBAction)backBtnTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)segmentedControlChanged:(UISegmentedControl*)sender {
    centerType = sender.selectedSegmentIndex;
    if (centerType == Nearby) {
        [self sortMallsWithDistance];
    }
    [self.tableView reloadData];
}
- (IBAction)btnNextPressed:(id)sender {

    if (selectedMalls.count == 0) {
        ShowMessage(kAppName,NSLocalizedString(@"Please select at least one town", nil));
        return;
    }
    [self.btnNext setSelected:YES];
 
    NSString *mallPlaceIds = @"";
    mallPlaceIds = [mallPlaceIds stringByAppendingString:[(MallCenter*)selectedMalls.firstObject mallPlaceId]];
    if (selectedMalls.count>=2)
    {
        for (int i = 1; i<selectedMalls.count; i++) {
            mallPlaceIds = [mallPlaceIds stringByAppendingString:@","];
            mallPlaceIds = [mallPlaceIds stringByAppendingString:[(MallCenter*)selectedMalls[i] mallPlaceId]];
        }
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WebManager sharedInstance] saveSelectedMalls:mallPlaceIds success:^(id response){
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (!_isFromEdit)
        {
            SaveStringWithKey(@"YES", kisLoggedIn);
            ShowMessage(kAppName,NSLocalizedString(@"Your preferences have been saved successfully", nil));
            [self saveMallsAndShowNextScreen];
        }
        else
        {
            [self saveSelectedMalls];
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserSelectedMallsEditedNotification object:nil];
        }

    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"Save selected malls error %@",[error localizedDescription]);
        //ShowMessage(kAppName, NSLocalizedString([error localizedDescription],nil));
        //[self saveMallsAndShowNextScreen];
    }];
//    [self saveCategoriesAsFavourite];

}
@end
