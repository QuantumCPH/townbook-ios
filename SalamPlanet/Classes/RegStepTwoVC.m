//
//  RegStepTwoVC.m
//  SalamCenterApp
//
//  Created by Globit on 02/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "RegStepTwoVC.h"
#import "AppDelegate.h"
#import "Constants.h"
#import "UtilsFunctions.h"
#import "DataManager.h"
#import "WebManager.h"
#import "MBProgressHUD.h"
#import "MACategory.h"
#import "User.h"


@interface RegStepTwoVC ()
{
    NSMutableArray * mainArray;
    NSMutableArray * selectedCategories;
    AppDelegate * appDelegate;
    User *user;
    BOOL shouldDisplayProgress;
}
@end

@implementation RegStepTwoVC

-(id)init{
    self = [super initWithNibName:@"RegStepTwoVC" bundle:nil];
    if (self) {
        selectedCategories = [[NSMutableArray alloc]init];
        appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dolocalizationText];
    [self.bgImgV setImage:[UIImage imageNamed:[appDelegate getBackgroundImageName]]];
    self.lblPageTitle.font=[appDelegate getFontOfPageTitle];
    if (_isFromEdit)
    {
        [appDelegate hideWithoutAnimationBottomTabBar:YES];
    }
    user = [[DataManager sharedInstance] currentUser];
    [self getMainCategories];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
}
#pragma mark:Custom Methods
-(void)dolocalizationText{
    self.lblPageTitle.text=NSLocalizedString(@"Select your interest", nil);
    self.lblSelectAll.text=NSLocalizedString(@"Select all", nil);
    if (!_isFromEdit)
    {
        [self.btnContinue setTitle:NSLocalizedString(@"Continue", nil) forState:UIControlStateNormal];
        [self.btnContinue setTitle:NSLocalizedString(@"Continue", nil) forState:UIControlStateSelected];
    }
    else
    {
        [self.btnContinue setTitle:NSLocalizedString(@"Update", nil) forState:UIControlStateNormal];
        [self.btnContinue setTitle:NSLocalizedString(@"Update", nil) forState:UIControlStateSelected];
    }
}
- (void)checkForSelectAllBtnSelection
{
    if (selectedCategories.count!=0 && selectedCategories.count == mainArray.count)
        [self.seleactAllBtn setSelected:YES];
}
- (void)getMainCategories
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WebManager sharedInstance] getInterestsList:^(NSArray *resultArray) {
        if (user.mainInterests.count != 0 && !shouldDisplayProgress)
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        mainArray =[[NSMutableArray alloc] initWithArray:resultArray];
        if (_isFromEdit)
        {
            [selectedCategories addObjectsFromArray:user.mainInterests.allObjects];
            
        }
        [self checkForSelectAllBtnSelection];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ShowMessage(kAppName, [error localizedDescription]);
    }];
    
    if (user.mainInterests.count == 0)
    {
        shouldDisplayProgress = YES;
        [[WebManager sharedInstance] getSelectedInterests:^(NSArray *resultArray) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            shouldDisplayProgress = NO;
            if (resultArray.count>0) {
                [selectedCategories addObjectsFromArray:resultArray];
                [self saveUserInterests];
                [self checkForSelectAllBtnSelection];
                [self.tableView reloadData];
            }
        } failure:^(NSError *error) {
            shouldDisplayProgress = NO;
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }];
    }
}
- (void)saveUserInterests
{
    if (user.mainInterests.count>0)
        [user removeMainInterests:user.mainInterests];
    [user addMainInterests:[NSSet setWithArray:selectedCategories]];
    [[DataManager sharedInstance] saveContext];
}
- (void)saveUserInterestsAndChangeRootView
{
    [self saveUserInterests];
    [appDelegate changeRootViewToStartApp];
}
#pragma mark: UITableView Delegates and Datasource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return mainArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InterestCell * cell=[tableView dequeueReusableCellWithIdentifier:@"interestCell"];
    if (!cell) {
        NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"InterestCell" owner:self options:nil];
        cell=[array objectAtIndex:0];
    }
    

    MACategory *category = [mainArray objectAtIndex:indexPath.row];
    cell.interNameLbl.text= category.categoryText;
    cell.heartBtn.tag = indexPath.row;
    if ([selectedCategories containsObject:category]) {
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
- (void)tableView:(UITableView *)tableView2 didSelectRowAtIndexPath :(NSIndexPath *)indexPath{
//    InterestCell *cell = (InterestCell *)[tableView2 cellForRowAtIndexPath:indexPath];
//    [cell heartBtnPressed:nil];
}
#pragma mark:InterestCellDelegate
-(void)interestIsSelectedButtonPressedWithOption:(BOOL)isSel ANDTag:(NSInteger)tag{
    
    MACategory *category = [mainArray objectAtIndex:tag];
    if ([selectedCategories containsObject:category]) {
        [selectedCategories removeObject:category];
        [self.seleactAllBtn setSelected:NO];
    }
    else
    {
        [selectedCategories addObject:category];
        [self checkForSelectAllBtnSelection];
    }
}
#pragma mark:IBActions and Selectors
- (IBAction)backBtnAction:(id)sender {
    [self.backBtn setSelected:YES];    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doneBtnAction:(id)sender {
    if (selectedCategories.count == 0) {
        ShowMessage(kAppName,NSLocalizedString(@"Please select at least one interest", nil));
        return;
    }
    [self.btnContinue setSelected:YES];
    NSString *selectedInterests = @"";
    selectedInterests = [selectedInterests stringByAppendingString:[(MACategory*)selectedCategories.firstObject categoryId]];
    if (selectedCategories.count>=2)
    {
        for (int i = 1; i<selectedCategories.count; i++) {
            selectedInterests = [selectedInterests stringByAppendingString:@","];
            selectedInterests = [selectedInterests stringByAppendingString:[(MACategory*)selectedCategories[i] categoryId]];
        }
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WebManager sharedInstance] saveSelectedInterests:selectedInterests success:^(id response) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (!_isFromEdit)
        {
            SaveStringWithKey(@"YES", kisLoggedIn);
            ShowMessage(kAppName,NSLocalizedString(@"Your preferences have been saved successfully", nil));
            [self saveUserInterestsAndChangeRootView];
        }
        else
        {
            [self saveUserInterests];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
         NSLog(@"Save user Interests error %@",[error localizedDescription]);
        //[self saveUserInterestsAndChangeRootView];
    }];
}

- (IBAction)selectAllAction:(id)sender {
    if (self.seleactAllBtn.selected)
    {
        if (selectedCategories.count>0)
            [selectedCategories removeAllObjects];
    }
    else{
        for (MACategory *category in mainArray) {
            if (![selectedCategories containsObject:category]) {
                [selectedCategories addObject:category];
            }
        }
    }
    [self.tableView reloadData];
    [self.seleactAllBtn setSelected:!self.seleactAllBtn.selected];
}
@end
