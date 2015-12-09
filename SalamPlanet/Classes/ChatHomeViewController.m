//
//  ChatHomeViewController.m
//  SalamPlanet
//
//  Created by Globit on 26/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "ChatHomeViewController.h"
#import "HSingleChat.h"
#import "DemoChatViewController.h"
#import "AppDelegate.h"
#import "ContactsHomeVC.h"

@interface ChatHomeViewController (){
    NSMutableArray * mainArray;
    AppDelegate * appDelegate;
    NSMutableArray * searchedArray;
    BOOL isSearched;
}

@end

@implementation ChatHomeViewController
-(id)init{
    self = [super initWithNibName:@"ChatHomeViewController" bundle:nil];
    if (self) {
        mainArray=[[NSMutableArray alloc]init];
        [mainArray addObject:@"John Doe"];
        [mainArray addObject:@"John Doe"];
        [mainArray addObject:@"John Doe"];
        appDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
        searchedArray=[[NSMutableArray alloc]init];
        isSearched=NO;

    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self dolocalizationText];
    [self.bgImgV setImage:[UIImage imageNamed:[appDelegate getBackgroundImageName]]];
    self.lblPageTitle.font=[appDelegate getFontOfPageTitle];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [appDelegate hideBottomTabBar:NO];
    [self.composeBtn setSelected:NO];
    [self.btnContacts setSelected:NO];
}
-(void)dolocalizationText{
    self.lblPageTitle.text=NSLocalizedString(@"MESSAGES", nil);
    [self.segmentControl setTitle:NSLocalizedString(@"ALL", nil) forSegmentAtIndex:0];
    [self.segmentControl setTitle:NSLocalizedString(@"Group", nil) forSegmentAtIndex:1];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark:Custom Methods
-(void)loadSearchedDataWithText:(NSString *)searchText{
    [searchedArray removeAllObjects];
    for (NSString *msgOwner in mainArray) {
        if(([msgOwner rangeOfString:searchText options:NSCaseInsensitiveSearch].location!=NSNotFound || [searchText isEqualToString:@""]) && msgOwner){
            [searchedArray addObject:msgOwner];
        }
    }
    [self.tableView reloadData];
}
#pragma mark:TableView DataSource and Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isSearched) {
        return searchedArray.count;
    }
    return [mainArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*This method sets up the table-view.*/
    HSingleChat * cell=[tableView dequeueReusableCellWithIdentifier:@"hSingleChat"];
    if (cell==nil) {
        NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"HSingleChat" owner:self options:nil];
        cell=[array objectAtIndex:0];
    }
    [cell loadDataWithDummy];
//    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DemoChatViewController * chatVC=[[DemoChatViewController alloc]init];
    [self.navigationController pushViewController:chatVC animated:YES];
}
#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    isSearched=YES;
    return YES;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self loadSearchedDataWithText:searchText];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    isSearched=NO;
    [self.searchBar resignFirstResponder];
    [self.tableView reloadData];
}
#pragma mark:IBActions
- (IBAction)compseBtnAction:(id)sender {
    [self.composeBtn setSelected:YES];
    DemoChatViewController * chatVC=[[DemoChatViewController alloc]init];
    [self.navigationController pushViewController:chatVC animated:YES];
}
- (IBAction)segmentedControlChanged:(UISegmentedControl *)segmentedControl{
}

- (IBAction)btnContactsPressed:(id)sender {
    [self.btnContacts setSelected:YES];
    ContactsHomeVC * contactsHomeVC=[[ContactsHomeVC alloc]init];
    [self.navigationController pushViewController:contactsHomeVC animated:YES];
}

@end
