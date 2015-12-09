//
//  BarcodeTypesVC.m
//  SalamCenterApp
//
//  Created by Globit on 19/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import "BarcodeTypesVC.h"
#import "BarcodeTypeCell.h"
#import "BarcodeType.h"
#import "AppDelegate.h"

@interface BarcodeTypesVC ()
{
    NSMutableArray * mainArray;
    AppDelegate * appDelegate;
}
@end

@implementation BarcodeTypesVC
-(id)init{
    self = [super initWithNibName:@"BarcodeTypesVC" bundle:nil];
    if (self) {
        mainArray=[[NSMutableArray alloc]init];
        appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self dolocalizationText];
    self.lblPageTitle.font=[appDelegate getFontOfPageTitle];
    
    [self loadMainArray];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
}
-(void)dolocalizationText{
    self.lblPageTitle.text=NSLocalizedString(@"Barcode preview", nil);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-Custom Methods
-(void)loadMainArray{
    [mainArray removeAllObjects];
    for (NSInteger i=0; i<10; i++) {
        BarcodeType * barcodeType=[[BarcodeType alloc]initWithID:i];
        [mainArray addObject:barcodeType];
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
    return 130;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BarcodeTypeCell * cell=[tableView dequeueReusableCellWithIdentifier:@"barcodeTypeCell"];
    if (!cell) {
        NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"BarcodeTypeCell" owner:self options:nil];
        cell=[array objectAtIndex:0];
    }
    BarcodeType * obj;
    obj=[mainArray objectAtIndex:indexPath.row];

    cell.barcodeName.text=obj.barcodeName;
    cell.barcodeImgV.image=[UIImage imageNamed:obj.barcodeImageName];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate barcodeHasBeenSelected:[mainArray objectAtIndex:indexPath.row]];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark-IBActions and Selector
- (IBAction)backBtnPressed:(id)sender {
    [self.backBtn setSelected:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
