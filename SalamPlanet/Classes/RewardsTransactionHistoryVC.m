//
//  RewardsTransactionHistoryVC.m
//  SalamCenterApp
//
//  Created by Globit on 17/02/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import "RewardsTransactionHistoryVC.h"
#import "AppDelegate.h"
#import "RewardsTransactionObject.h"

@interface RewardsTransactionHistoryVC ()
{
    AppDelegate * appDelegate;
    NSMutableArray * mainArray;
    NSMutableArray * mainSearchedArray;
    BOOL isFromSearchBar;
}
@end

@implementation RewardsTransactionHistoryVC
- (id)init
{
    self = [super initWithNibName:@"RewardsTransactionHistoryVC" bundle:nil];
    if (self) {
        appDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
        mainArray=[[NSMutableArray alloc]init];
        mainSearchedArray=[[NSMutableArray alloc]init];
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
-(void)dolocalizationText{
    self.lblPageTitle.text=NSLocalizedString(@"Transaction History", nil);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- Custom Methods
-(void)loadMainArrayWithDummy{
    [mainArray removeAllObjects];
    
    for (NSInteger i=0; i<4; i++) {
        RewardsTransactionObject * obj=[[RewardsTransactionObject alloc]initWithID:i];
        [mainArray addObject:obj];
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
-(void)loadSearchedData:(NSString *)searchText
{
    [mainSearchedArray removeAllObjects];
    for (RewardsTransactionObject * trans in mainArray) {
        NSString * name = trans.transTitle;
        NSString * category=trans.transShop;
        if(([name rangeOfString:searchText options:NSCaseInsensitiveSearch].location!=NSNotFound || [searchText isEqualToString:@""]) && name){
            [mainSearchedArray addObject:trans];
        }
        else if(([category rangeOfString:searchText options:NSCaseInsensitiveSearch].location!=NSNotFound || [searchText isEqualToString:@""]) && category){
            [mainSearchedArray addObject:trans];
        }
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(isFromSearchBar)
    {
        return mainSearchedArray.count;
    }
    return [mainArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RewardsTransCell * cell = [tableView dequeueReusableCellWithIdentifier:@"rewardsTransCell"];
    if (cell == nil) {
        NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"RewardsTransCell" owner:self options:nil];
        cell=[array objectAtIndex:0];
    }
    RewardsTransactionObject * obj;
    if (isFromSearchBar) {
        obj=[mainSearchedArray objectAtIndex:indexPath.row];
    }
    else{
        obj=[mainArray objectAtIndex:indexPath.row];
    }
    cell.transImgV.image=[UIImage imageNamed:obj.transImageName];
    [self makeUIImageViewRoundedLeftSide:cell.transImgV ANDRadiues:3.0 ANDTableViewCell:cell];
    
    cell.lblTransName.text=obj.transTitle;
    cell.lblTransShop.text=obj.transShop;
    cell.lblTransTime.text=obj.transDate;
    if (obj.isPositive) {
        cell.lblTransPoints.text=[NSString stringWithFormat:@"+%li pts",(long)obj.transPoints];
    }
    else{
        cell.lblTransPoints.text=[NSString stringWithFormat:@"-%li pts",(long)obj.transPoints];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

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
- (IBAction)btnBackPressed:(id)sender {
    [self.btnBack setSelected:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
