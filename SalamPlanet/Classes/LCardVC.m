//
//  LCardVC.h
//  SalamCenterApp
//
//  Created by Globit on 12/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import "LCardVC.h"
#import "AppDelegate.h"
#import "CardImageCell.h"

#define kCellTopCardName @"cellTopCardName"
#define kCellCardImages @"cellCardImages"
#define kCellCardDataEntry  @"cellCardDataEntry"
#define kCellCardDescription @"cellCardDescription"

@interface LCardVC ()
{
    NSMutableArray * mainArray;
    AppDelegate * appDelegate;
}

@end

@implementation LCardVC
-(id)initWithLCObject:(LCObject*)lcObject{
    self = [super initWithNibName:@"LCardVC" bundle:nil];
    if (self) {
        _mainLCObj=lcObject;
        mainArray=[[NSMutableArray alloc]init];
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
    
    if (_mainLCObj.lcTitle) {
        self.lblPageTitle.text=_mainLCObj.lcTitle;
    }
    [self loadMainArray];
    //self.cardImageScrollView.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width*2, self.cardImageScrollView.frame.size.height);
    [self.cardImageCollectionView registerNib:[UINib nibWithNibName:@"CardImageCell" bundle:nil] forCellWithReuseIdentifier:@"CardImageCell"];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [appDelegate hideBottomTabBar:YES];
    [self.editBtn setSelected:NO];
}
-(void)dolocalizationText{
    self.lblBarCode.text=NSLocalizedString(@"Barcode Number", nil);
    self.lblCardNumber.text=NSLocalizedString(@"Card Number", nil);
    self.lblDescription.text=NSLocalizedString(@"Description", nil);
    self.lblFront.text=NSLocalizedString(@"FRONT",nil);
    self.lblBack.text=NSLocalizedString(@"BACK", nil);
    self.cardDescriptionTF.text=NSLocalizedString(@"Shoping Card Description", nil);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-Custom Methods
-(void)loadMainArray{
    [mainArray removeAllObjects];
    
//    [mainArray addObject:kCellTopCardName];
    [mainArray addObject:kCellCardImages];
    [mainArray addObject:kCellCardDataEntry];
    [mainArray addObject:kCellCardDescription];
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
    if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellTopCardName]) {
        return 36.0;
    }
    else if([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellCardImages]){
        return 230.0;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellCardDataEntry]){
        return 200.0;
    }
    else
    {
        return 200.0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellTopCardName]) {
        self.lblCardTitleValue.text=_mainLCObj.lcTitle;
        self.cellTopCardName.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellTopCardName;
    }
    else if([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellCardImages]){
        if (_mainLCObj.lcFrontImgName) {
            self.imgVFront.image=[UIImage imageNamed:_mainLCObj.lcFrontImgName];
        }
        if (_mainLCObj.lcBackImgName) {
            self.imgVBack.image=[UIImage imageNamed:_mainLCObj.lcBackImgName];
        }
        if(_mainLCObj.lcBackImage){
            self.imgVFront.image=_mainLCObj.lcFrontImage;
        }
        if(_mainLCObj.lcFrontImage){
            self.imgVBack.image=_mainLCObj.lcBackImage;
        }
        [UtilsFunctions makeUIImageViewRound:self.imgVFront ANDRadius:17];
        [UtilsFunctions makeUIImageViewRound:self.imgVBack ANDRadius:17];
        
        self.cellCardImages.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellCardImages;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellCardDataEntry]){
        self.lblCardNumberValue.text=_mainLCObj.lcCardNumber;
        self.lblBarcodeNumberValue.text=_mainLCObj.lcBarcodeNumber;
        self.barcodeImgView.image=[UIImage imageNamed:_mainLCObj.lcBarcodeImgName];
        self.cellCardDataEntry.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellCardDataEntry;
    }
    else
    {
        self.cardDescriptionTF.text=_mainLCObj.lcDescription;
        self.cellCardDescription.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellCardDescription;
    }
}
#pragma LCCreateVCDelegate
-(void)newLCObjectHasBeenCreated:(LCObject *)obj{
    _mainLCObj=obj;
    [self.tableView reloadData];
}
#pragma mark-UITextFieldDelegate
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark-UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView*)scrollView{
    self.cardImagePager.currentPage = self.cardImageCollectionView.contentOffset.x/CGRectGetWidth(self.cardImageCollectionView.frame);
//    if (scrollView.contentOffset.x<320) {
//        self.cardImagePager.currentPage=0;
//    }
//    else{
//        self.cardImagePager.currentPage=1;
//    }
}
#pragma mark: UICollectionView Delegates and Datasource Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    return CGSizeMake(width,228);
}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(5, 5, 5, 5);//(top, left, bottom, right);
//}
- (CardImageCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CardImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CardImageCell" forIndexPath:indexPath];

    if (indexPath.row ==0 ) {
        cell.cardImgView.image = [UIImage imageNamed:@"LC_CardImg1.png"];
        cell.cardBorderImgView.image = [UIImage imageNamed:@"LC_Border.png"];
        cell.sideLbl.text = @"FRONT";
    }
    else
    {
        cell.cardImgView.image = [UIImage imageNamed:@"LC_CardImg2.png"];
        cell.cardBorderImgView.image = [UIImage imageNamed:@"LC_Border.png"];
        cell.sideLbl.text = @"BACK";
    }
    return cell;
}
#pragma mark-IBActions and Selectors
- (IBAction)backBtnPressed:(id)sender {
    [self.backBtn setSelected:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)editBtnPressed:(id)sender {
    [self.editBtn setSelected:YES];
    LCCreateVC * lcCreateVC=[[LCCreateVC alloc]initWithLCObject:_mainLCObj];
    lcCreateVC.isCreateNewCard=NO;
    lcCreateVC.delegate=self;
    [self.navigationController pushViewController:lcCreateVC animated:YES];
}

@end
