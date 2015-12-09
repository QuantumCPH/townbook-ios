//
//  DBDemoTableView.m
//  SalamCenterApp
//
//  Created by Globit on 18/02/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import "DBDemoTableView.h"

@interface DBDemoTableView ()

@end

@implementation DBDemoTableView

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}
#pragma mark - Table view data source
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    [headerView setBackgroundColor:[UIColor colorWithRed:0.062745098 green:0.380392157 blue:1 alpha:0.7]];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 1, 200, 20)];
    label.text = [NSString stringWithFormat:@"User %li",(long)section + 1];
    label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    label.textColor = [UIColor whiteColor];
    [headerView addSubview:label];
    
    return headerView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _results.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_results[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell =[[UITableViewCell alloc]init];
    
    cell.textLabel.text = [_results[indexPath.section] objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end