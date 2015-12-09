//
//  NotificationsVC.m
//  SalamCenterApp
//
//  Created by Waseem Asif on 04/11/2015.
//  Copyright © 2015 Globit. All rights reserved.
//

#import "NotificationsVC.h"
#import "NotificationCell.h"
#import "WebManager.h"
#import "MBProgressHUD.h"
#import "User.h"
#import "DataManager.h"

#define kIsNotificationEnabled     @"isNotificationEnabled"

@interface NotificationsVC ()
{
    User *user;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) BOOL isNotificationEnabled;
@end

@implementation NotificationsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //NSString * notiEnabled = [[NSUserDefaults standardUserDefaults] objectForKey:kIsNotificationEnabled];
    user = [[DataManager sharedInstance] currentUser];
    
    NotificationCell * notiCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [notiCell.notificationSwtch setOn:user.isNotificationAllowed];
}
- (void)saveNotificationPreference:(BOOL)isEnabled
{
    [[NSUserDefaults standardUserDefaults] setObject:isEnabled? @"YES":@"NO" forKey:kIsNotificationEnabled];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark:IBActions
- (IBAction)backBtnTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)switchValueChanged:(UISwitch *)sender {
    _isNotificationEnabled = sender.on;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WebManager sharedInstance] changeNotificationPreference:_isNotificationEnabled success:^(NSString *message) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        user.isNotificationAllowed =_isNotificationEnabled;
        [[DataManager sharedInstance] saveContext];
        ShowMessage(kAppName, message);
    } failure:^(NSString *errorString) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        sender.on = !_isNotificationEnabled;
        ShowMessage(kAppName, errorString);
    }];
}

#pragma mark-UITableView DataSource and Delegates
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor grayColor]];
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return NSLocalizedString(@"Notifications Setting",nil);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotificationCell"];
    cell.titleLbl.text = NSLocalizedString(@"Notifications",nil);
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
