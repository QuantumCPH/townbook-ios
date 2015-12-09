//
//  RewardsHomeVC.m
//  SalamCenterApp
//
//  Created by Globit on 16/02/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import "RewardsHomeVC.h"
#import "OfferObject.h"
#import "AppDelegate.h"
#import "RewardsTransactionHistoryVC.h"
#import "DBDemoVC.h"

#define kCellInfo @"cellInfo"
#define kCellGotoHistory @"cellGoToHistory"
#define kCellScrollOffer  @"cellScrollOffer"

@interface RewardsHomeVC ()
{
    NSMutableArray * mainArray;
    NSMutableArray * mainArrayOffers;
    NSMutableArray * mainFeaturedProductArray;
    AppDelegate * appDelegate;
    UITapGestureRecognizer * gestureRecognizer;
    UIView * gestureView;
}
@end

@implementation RewardsHomeVC
- (id)init
{
    self = [super initWithNibName:@"RewardsHomeVC" bundle:nil];
    if (self) {
        mainArray=[[NSMutableArray alloc]init];
        mainArrayOffers=[[NSMutableArray alloc]init];
        mainFeaturedProductArray=[[NSMutableArray alloc]init];
        appDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self dolocalizationText];
    [self.bgImgV setImage:[UIImage imageNamed:[appDelegate getBackgroundImageName]]];
    self.lblPageTitle.font=[appDelegate getFontOfPageTitle];
    
    if (GetStringWithKey(kTempUserName)) {
        self.lblPageTitle.text=GetStringWithKey(kTempUserName);
        self.lblPopOverTitle.text=GetStringWithKey(kTempUserName);
    }
    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [self loadMainArray];
    [self loadFeaturedProductsArrayWithDummy];
    [self setOffersInScrollView];
    
    gestureRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnClosePopOverPressed:)];
    gestureView=[[UIView alloc]initWithFrame:self.view.frame];
    [gestureView addGestureRecognizer:gestureRecognizer];
    
    
}
-(void)dolocalizationText{
    self.lblPoints.text=NSLocalizedString(@"Points", nil);//NSLocalizedString(@"Points",nil);
    self.lblCardNumber.text=NSLocalizedString(@"Card Number", nil);
    self.lblMembershipNumber.text=NSLocalizedString(@"Membership Number",nil);
    self.lblPopOverCardNumber.text=NSLocalizedString(@"Card Number", nil);
    self.lblPopOverMembershipNumber.text=NSLocalizedString(@"Membership Number", nil);
    self.lblShopOfferTitle.text=NSLocalizedString(@"The Shop Offers", nil);
    self.lblTransactionHistory.text=NSLocalizedString(@"Transaction History", nil);
    self.lblFeaturedProducts.text=NSLocalizedString(@"Featured Offers", nil);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-Custom Methods
-(void)loadMainArray{
    [mainArray removeAllObjects];
    
    [mainArray addObject:kCellInfo];
    [mainArray addObject:kCellGotoHistory];
    [mainArray addObject:kCellScrollOffer];
}
-(void)setOffersInScrollView{
    [mainArrayOffers removeAllObjects];
    CGSize size=self.offerScrollView.contentSize;
    size.width=5*100;
    self.offerScrollView.contentSize=size;
    for (NSInteger i=0; i<5; i++) {
        OfferObject * obj=[[OfferObject alloc]initWithID:i];
        ShopOfferView * shopOfferView=[[ShopOfferView alloc]initWithOfferObj:obj];
        shopOfferView.frame=CGRectMake(i*100, 0, 100, 122);
        shopOfferView.delegate=self;
        [self.offerScrollView addSubview:shopOfferView];
    }
    //    self.offerScrollView.delegate=self;
}
-(void)loadFeaturedProductsArrayWithDummy{
    [mainFeaturedProductArray removeAllObjects];
    
    NSArray * savedObjects=GetArrayWithKey(kArrayEndorsementCreatedLocally);
    for (NSData * item in savedObjects) {
        NSDictionary * dictnry=[NSKeyedUnarchiver unarchiveObjectWithData:item];
        [mainFeaturedProductArray addObject:dictnry];
        if (mainFeaturedProductArray.count==3) {
            break;
        }
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [mainArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellInfo]) {
        return 164;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellGotoHistory]) {
        return 36;
    }
    else{
        return 170;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellInfo]) {
        self.cellInfo.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellInfo;
    }
    if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellGotoHistory]) {
        self.cellGotoHistory.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellGotoHistory;
    }
    else{
        self.cellScrollOffers.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellScrollOffers;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellInfo]) {
        self.popOverView.frame=CGRectMake((self.view.frame.size.width/2)-(self.popOverView.frame.size.width/2), 70, self.popOverView.frame.size.width, self.popOverView.frame.size.height);
        [self.view addSubview:gestureView];
        [self.view addSubview:self.popOverView];
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellGotoHistory]) {
        RewardsTransactionHistoryVC *rewardsHistoryVC=[[RewardsTransactionHistoryVC alloc]init];
        [self.navigationController pushViewController:rewardsHistoryVC animated:YES];
    }
}
#pragma mark-UIScrolViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint point=scrollView.contentOffset;
    if (point.x==0) {
        [self.imgBackwardArrow setHidden:YES];
    }
    else{
        [self.imgBackwardArrow setHidden:NO];
    }
    if (point.x==self.offerScrollView.contentSize.width-self.offerScrollView.frame.size.width) {
        [self.imgForwardArrow setHidden:YES];
    }
    else{
        [self.imgForwardArrow setHidden:NO];
    }
}
#pragma mark-ShopOfferViewDelegate
-(void)offerHasBeenTappedWithOfferID:(NSInteger)offerID{
    NSDictionary * dict=[mainFeaturedProductArray objectAtIndex:1];
    OfferDetailVC *offerVC=[[OfferDetailVC alloc]initWithOfferCreatedLocally:dict ANDCenterName:nil];
    [self.navigationController pushViewController:offerVC animated:YES];
}
- (IBAction)btnClosePopOverPressed:(id)sender {
    [gestureView removeFromSuperview];
    [self.popOverView removeFromSuperview];
}

- (IBAction)gotoDBDemo:(id)sender {
    DBDemoVC * demoVC=[[DBDemoVC alloc]init];
    [self.navigationController pushViewController:demoVC animated:YES];
}
@end
