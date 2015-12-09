//
//  TransportHelpVC.m
//  SalamCenterApp
//
//  Created by Globit on 28/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import "TransportHelpVC.h"
#import "AppDelegate.h"
#import "WebVC.h"
@interface TransportHelpVC ()
{
    NSMutableArray * mainArray;
    AppDelegate * appDelegate;
}
@end

@implementation TransportHelpVC
-(id)init{
    self = [super initWithNibName:@"TransportHelpVC" bundle:nil];
    if (self) {
        appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
        mainArray=[[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self.bgImgV setImage:[UIImage imageNamed:[appDelegate getBackgroundImageName]]];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self loadMainArrayWithDummy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-Custom Methods
-(void)loadMainArrayWithDummy{
    [mainArray removeAllObjects];
    
    [mainArray addObject:@"Taking the car to the fishing town square , it is easy to find your way . from kobenhavn cores you at the Hans Christian Andersen Boulevard towards the bridge langebro . Turn right at Kalvebod brew . you come from the south ? Ring 2 runs straight to the fishing town square . fishing Square is only five minutes from Radhusplades and has 2,000 parking spaces. You can park for free in 3 hours - remember P- slice. <a href='http://www.google.com'><u color=blue><font color=blue>www.google.com</font></u></a>"];
    
    [mainArray addObject:@"Taking the car to the fishing town square , it is easy to find your way . from kobenhavn cores you at the Hans Christian Andersen Boulevard towards the bridge langebro . Turn right at Kalvebod brew . you come from the south ? Ring 2 runs straight to the fishing town square . fishing Square is only five minutes from Radhusplades and has 2,000 parking spaces. You can park for free in 3 hours - remember P- slice. <a href='http://www.google.com'><u color=blue><font color=blue>www.google.com</font></u></a>"];

    [mainArray addObject:@"Taking the car to the fishing town square , it is easy to find your way . from kobenhavn cores you at the Hans Christian Andersen Boulevard towards the bridge langebro . Turn right at Kalvebod brew . you come from the south ? Ring 2 runs straight to the fishing town square . fishing Square is only five minutes from Radhusplades and has 2,000 parking spaces. You can park for free in 3 hours - remember P- slice. <a href='http://www.google.com'><u color=blue><font color=blue>www.google.com</font></u></a>"];

    [mainArray addObject:@"Taking the car to the fishing town square , it is easy to find your way . from kobenhavn cores you at the Hans Christian Andersen Boulevard towards the bridge langebro . Turn right at Kalvebod brew . you come from the south ? Ring 2 runs straight to the fishing town square . fishing Square is only five minutes from Radhusplades and has 2,000 parking spaces. You can park for free in 3 hours - remember P- slice. <a href='http://www.google.com'><u color=blue><font color=blue>www.google.com</font></u></a>"];

}
#pragma mark-UITableView DataSource and Delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mainArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RTLabel *rtLabel = [TransportInfoCell textLabel];
//    rtLabel.lineSpacing = 20.0;
    [rtLabel setText:[mainArray objectAtIndex:indexPath.row]];
    CGSize optimumSize = [rtLabel optimumSize];
    return optimumSize.height+60+20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TransportInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"transportInfoCell"];
    if (cell == nil) {
        NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"TransportInfoCell" owner:self options:nil];
        cell=[array objectAtIndex:0];
    }
    [cell initializrRTLabel];
    switch (indexPath.row) {
        case 0:
            cell.lblHeading.text=@"By Car";
            break;
        case 1:
            cell.lblHeading.text=@"Taxi";
            break;
        case 2:
            cell.lblHeading.text=@"Train";
            break;
        case 3:
            cell.lblHeading.text=@"By Cycle";
            break;
            
        default:
            break;
    }
    [cell.rtLabel setText:[mainArray objectAtIndex:indexPath.row]];
    cell.rtLabel.delegate=self;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark RTLabel delegate
- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url
{
    NSLog(@"did select url %@", url);
    WebVC * webVC=[[WebVC alloc]initWithUrl:[url absoluteString]];
    [self.navigationController pushViewController:webVC animated:YES];
}
#pragma mark-IBActions & Selectors
- (IBAction)btnBackPressed:(id)sender {
    [self.btnBack setSelected:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
