//
//  ContactDetailVC.m
//  SalamCenterApp
//
//  Created by Globit on 15/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import "ContactDetailVC.h"
#import "AppDelegate.h"
#import "DemoChatViewController.h"

#define kImageCell    @"imageCell"
#define kDetailCell   @"detailCell"

@interface ContactDetailVC ()
{
    NSMutableArray * mainArray;
    AppDelegate * appDelegate;
}
@end

@implementation ContactDetailVC
-(id)initWithContac:(THContact *)contactObj AndIsAppUser:(BOOL)isAppUsr{
    self = [super initWithNibName:@"ContactDetailVC" bundle:nil];
    if (self) {
        _contactObj=contactObj;
        _isAppUser=isAppUsr;
        mainArray=[[NSMutableArray alloc]init];
        appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dolocalizationText];
    [self.bgImgV setImage:[UIImage imageNamed:[appDelegate getBackgroundImageName]]];
    self.lblPageTitle.font=[appDelegate getFontOfPageTitle];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.lblPhoneNumber.text=[_contactObj phone];
    self.lblPageTitle.text=[_contactObj fullName];
    if(_contactObj.image) {
        self.userImgV.image = _contactObj.image;
    }
    if (_isAppUser) {
        [self.btnInviteChat setImage:[UIImage imageNamed:@"contact-sms"] forState:UIControlStateNormal];
        [self.btnInviteChat setImage:[UIImage imageNamed:@"contact-sms-p"] forState:UIControlStateHighlighted];
        [self.btnInviteChat setImage:[UIImage imageNamed:@"contact-sms-p"] forState:UIControlStateSelected];
        self.lblBtnTitle.text=@"Start a Chat";
    }
    else{
        [self.btnInviteChat setImage:[UIImage imageNamed:@"contact-invite"] forState:UIControlStateNormal];
        [self.btnInviteChat setImage:[UIImage imageNamed:@"contact-invite-p"] forState:UIControlStateHighlighted];
        [self.btnInviteChat setImage:[UIImage imageNamed:@"contact-invite-p"] forState:UIControlStateSelected];
        self.lblBtnTitle.text=@"Invite";
    }
    [self loadMainArray];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.btnInviteChat setSelected:NO];
}
-(void)dolocalizationText{
    self.lblBtnTitle.text=NSLocalizedString(@"Invite", nil);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadMainArray{
    [mainArray removeAllObjects];
    
    [mainArray addObject:kImageCell];
    [mainArray addObject:kDetailCell];
}
#pragma mark-TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return mainArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 226;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kImageCell]) {
        self.cellTopProfile.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellTopProfile;
    }
    else{
        self.cellBottomDetail.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellBottomDetail;
    }
}

#pragma mark - MFMessageComposeViewControllerDelegate methods
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            ShowMessage(kAppName,NSLocalizedString(@"Failed to send SMS!", nil));
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark-IBActions and Selectors
- (IBAction)btnInviteChatPressed:(id)sender {
    if (![_contactObj phone]) {
        ShowMessage(kAppName,NSLocalizedString(@"No phone number is present", nil));
        return;
    }
    [self.btnInviteChat setSelected:YES];
    if (_isAppUser) {
        DemoChatViewController * chatVC=[[DemoChatViewController alloc]init];
        [self.navigationController pushViewController:chatVC animated:YES];
        return;
    }
    MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc] init];
    if ([MFMessageComposeViewController canSendText]) {
        
        NSString *smsString =[NSString stringWithFormat:NSLocalizedString(@"You are Invited by %@ to use The Mall App", nil),GetStringWithKey(kTempUserName)];
        messageVC.body = smsString;
        messageVC.recipients=[NSArray arrayWithObject:[_contactObj phone]];
        messageVC.messageComposeDelegate = self;
        [self presentViewController:messageVC animated:YES completion:nil];
    }
    else{
        ShowMessage(kAppName, NSLocalizedString(@"Your device doesn't support SMS!", nil));
    }
}
- (IBAction)backBtnPressed:(id)sender {
    [self.backBtn setSelected:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
