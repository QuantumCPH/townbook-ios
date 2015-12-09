//
//  LCMainVC.m
//  SalamCenterApp
//
//  Created by Globit on 08/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import "LCMainVC.h"
#import "LCObject.h"
#import "LCMainCell.h"
#import "AppDelegate.h"
#import "LCardVC.h"

@interface LCMainVC ()
{
    NSMutableArray * mainArray;
    NSMutableArray * mainSearchedArray;
    AppDelegate * appDelegate;
    BOOL isFromSearchBar;
}
@end

@implementation LCMainVC
-(id)init{
    self = [super initWithNibName:@"LCMainVC" bundle:nil];
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
    
    [self loadMainArrayWithDummy];
    
//    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //Add Searchbar tablew Header View
//    self.tableView.tableHeaderView=self.searchBarView;
//    [self.tableView setContentOffset:CGPointMake(0, 44)];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"LCMainCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"lCMainCollectionCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [appDelegate hideBottomTabBar:NO];
    [self.btnCreate setSelected:NO];
//    [self.tableView setContentOffset:CGPointMake(0, 44)];
}
-(void)dolocalizationText{
    self.lblPageTitle.text=NSLocalizedString(@"Loyalty Cards", nil);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-Custom Methods
-(void)loadMainArrayWithDummy{
    [mainArray removeAllObjects];
    for (NSInteger i=0; i<4; i++) {
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
//#pragma mark-UITableView DataSource and Delegates
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    if (isFromSearchBar) {
//        return mainSearchedArray.count;
//    }
//    else{
//        return mainArray.count;
//    }
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 80.0;
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    LCMainCell * cell=[tableView dequeueReusableCellWithIdentifier:@"lCMainCell"];
//    if (!cell) {
//        NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"LCMainCell" owner:self options:nil];
//        cell=[array objectAtIndex:0];
//    }
//    LCObject * obj;
//    if (isFromSearchBar) {
//        obj=[mainSearchedArray objectAtIndex:indexPath.row];
//    }
//    else{
//        obj=[mainArray objectAtIndex:indexPath.row];
//    }
//    cell.centerNameLbl.text=obj.lcTitle;
//    cell.centerCityLbl.text=obj.lcShopName;
//    if (obj.lcFrontImgName) {
//        cell.centerImgV.image=[UIImage imageNamed:obj.lcFrontImgName];
//    }
//    else if(obj.lcFrontImage){
//        cell.centerImgV.image=obj.lcFrontImage;
//    }
//    [UtilsFunctions makeUIImageViewRound:cell.centerImgV ANDRadius:7.0];
//    cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    return cell;
//}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    LCObject * obj;
//    if (isFromSearchBar) {
//        obj=[mainSearchedArray objectAtIndex:indexPath.row];
//    }
//    else{
//        obj=[mainArray objectAtIndex:indexPath.row];
//    }
//    LCardVC * lcardVC=[[LCardVC alloc]initWithLCObject:obj];
//    [self.navigationController pushViewController:lcardVC animated:YES];
//}
#pragma mark: UICollectionView Delegates and Datasource Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (isFromSearchBar) {
        return mainSearchedArray.count;
    }
    else{
        return mainArray.count;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(150,115);//142
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);//(top, left, bottom, right);
}
- (LCMainCollectionCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LCMainCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"lCMainCollectionCell" forIndexPath:indexPath];
    LCObject * obj;
    if (isFromSearchBar) {
        obj=[mainSearchedArray objectAtIndex:indexPath.row];
    }
    else{
        obj=[mainArray objectAtIndex:indexPath.row];
    }
    cell.cardNameLbl.text=obj.lcTitle;
    cell.cardShopNameLbl.text=obj.lcShopName;
    if (obj.lcFrontImgName) {
        cell.cardImgV.image=[UIImage imageNamed:obj.lcFrontImgName];
    }
    else if(obj.lcFrontImage){
        cell.cardImgV.image=obj.lcFrontImage;
    }
    [UtilsFunctions makeUIImageViewRound:cell.cardImgV ANDRadius:7.0];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LCObject * obj;
    if (isFromSearchBar) {
        obj=[mainSearchedArray objectAtIndex:indexPath.row];
    }
    else{
        obj=[mainArray objectAtIndex:indexPath.row];
    }
    LCardVC * lcardVC=[[LCardVC alloc]initWithLCObject:obj];
    [self.navigationController pushViewController:lcardVC animated:YES];
}

#pragma mark-LCCreateMainVCDelegate
-(void)newMainLCObjectHasBeenCreated:(LCObject *)obj{
    [mainArray addObject:obj];
//    [self.tableView reloadData];
    [self.collectionView reloadData];
}
#pragma mark-UISearchBarDelegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length==0) {
        isFromSearchBar=NO;
        [self.searchBar resignFirstResponder];
//        [self.tableView reloadData];
        [self.collectionView reloadData];
        return;
    }
    isFromSearchBar=YES;
    [self loadSearchedData:self.searchBar.text];
//    [self.tableView reloadData];
    [self.collectionView reloadData];
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    isFromSearchBar=NO;
    [self.searchBar resignFirstResponder];
//    [self.tableView reloadData];
    [self.collectionView reloadData];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //    [searchBar resignFirstResponder];
    // Do the search...
}
#pragma mark-IBActions and Selectors
- (IBAction)createBtnPressed:(id)sender {
    [self.btnCreate setSelected:YES];
    LCCreateMainVC * lcCreateVC=[[LCCreateMainVC alloc]init];
    lcCreateVC.delegate=self;
    UINavigationController * navCOntroller=[[UINavigationController alloc]initWithRootViewController:lcCreateVC];
    [navCOntroller.navigationBar setHidden:YES];
    [self.navigationController presentViewController:navCOntroller animated:YES completion:nil];
}
@end
