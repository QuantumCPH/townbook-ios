//
//  LCCreateMainVC.m
//  SalamCenterApp
//
//  Created by Globit on 08/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import "LCCreateMainVC.h"
#import "LCObject.h"
#import "LCMainCell.h"
#import "AppDelegate.h"

@interface LCCreateMainVC ()
{
    NSMutableArray * mainArray;
    NSMutableArray * mainSearchedArray;
    AppDelegate * appDelegate;
    BOOL isFromSearchBar;
}
@end

@implementation LCCreateMainVC
-(id)init{
    self = [super initWithNibName:@"LCCreateMainVC" bundle:nil];
    if (self) {
        mainArray=[[NSMutableArray alloc]init];
        mainSearchedArray=[[NSMutableArray alloc]init];
        appDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self dolocalizationText];
    [self.bgImgV setImage:[UIImage imageNamed:[appDelegate getBackgroundImageName]]];
    self.lblPageTitle.font=[appDelegate getFontOfPageTitle];
    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self loadMainArrayWithDummy];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [appDelegate hideBottomTabBar:YES];
}
-(void)dolocalizationText{
    self.lblPageTitle.text=NSLocalizedString(@"Loyalty Cards", nil);
    self.lblAddOtherCard.text=NSLocalizedString(@"Add other card", nil);
    self.lblIfYouCantFindItHere.text=NSLocalizedString(@"(If you can't find it here)", nil);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-Custom Methods
-(void)loadMainArrayWithDummy{
    [mainArray removeAllObjects];
    for (NSInteger i=0; i<5; i++) {
        LCObject * lcObj=[[LCObject alloc]initWithID:i];
        [mainArray addObject:lcObj];
    }
}
-(void)loadSearchedData:(NSString *)searchText{
    [mainSearchedArray removeAllObjects];
    for (LCObject * obj in mainArray) {
        NSString * name = obj.lcTitle;
        if(([name rangeOfString:searchText options:NSCaseInsensitiveSearch].location!=NSNotFound || [searchText isEqualToString:@""]) && name){
            [mainSearchedArray addObject:obj];
        }
    }
}
#pragma mark-UITableView DataSource and Delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isFromSearchBar) {
        return mainSearchedArray.count+1;
    }
    return mainArray.count+1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (isFromSearchBar && indexPath.row==mainSearchedArray.count) {
        self.cellAddCard.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellAddCard;
    }
    if (indexPath.row==mainArray.count) {
        self.cellAddCard.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellAddCard;
    }
    LCMainCell * cell=[tableView dequeueReusableCellWithIdentifier:@"lCMainCell"];
    if (!cell) {
        NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"LCMainCell" owner:self options:nil];
        cell=[array objectAtIndex:0];
    }
    LCObject * obj;
    if (isFromSearchBar) {
        obj=[mainSearchedArray objectAtIndex:indexPath.row];
    }
    else{
        obj=[mainArray objectAtIndex:indexPath.row];
    }
    cell.centerNameLbl.text=obj.lcTitle;
    cell.centerCityLbl.text=obj.lcShopName;
    cell.centerImgV.image=[UIImage imageNamed:obj.lcFrontImgName];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==mainArray.count || (isFromSearchBar && indexPath.row==mainSearchedArray.count)) {
        LCCreateVC * lcCreateVC=[[LCCreateVC alloc]init];
        lcCreateVC.delegate=self;
        lcCreateVC.isCreateNewCard=YES;
        [self.navigationController pushViewController:lcCreateVC animated:YES];
        return;
    }
    LCObject * obj;
    if (isFromSearchBar) {
        obj=[mainSearchedArray objectAtIndex:indexPath.row];
    }
    else{
        obj=[mainArray objectAtIndex:indexPath.row];
    }
    LCCreateVC * lcCreateVC=[[LCCreateVC alloc]initWithLCObject:obj];
    lcCreateVC.isCreateNewCard=YES;
    lcCreateVC.delegate=self;
    [self.navigationController pushViewController:lcCreateVC animated:YES];
}
#pragma mark-LCCreateVCDelegate
-(void)newLCObjectHasBeenCreated:(LCObject *)obj{
    [self.delegate newMainLCObjectHasBeenCreated:obj];
}
#pragma mark UISearchBarDelegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length==0) {
        isFromSearchBar=NO;
        [self.searchBar resignFirstResponder];
        [self.tableView reloadData];
        return;
    }
    isFromSearchBar=YES;

    [self loadSearchedData:self.searchBar.text];
    [self.tableView reloadData];
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    isFromSearchBar=NO;
    [self.searchBar resignFirstResponder];
    [self.tableView reloadData];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //    [searchBar resignFirstResponder];
    // Do the search...
}
#pragma mark-IBActions and Selectors
- (IBAction)backBtnPressed:(id)sender {
    [self.backBtn setSelected:YES];
//    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
@end
