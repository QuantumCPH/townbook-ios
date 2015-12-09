//
//  ChatSettingsVC.m
//  SalamPlanet
//
//  Created by Globit on 17/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "ChatSettingsVC.h"
#import "ChatPartiCell.h"
#import "AppDelegate.h"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
@interface ChatSettingsVC ()
{
    NSMutableArray * mainArray;
    BOOL isSmartNotiChecked;
    AppDelegate * appDelegate;
}

@end

@implementation ChatSettingsVC
- (id)init
{
    self = [super initWithNibName:@"ChatSettingsVC" bundle:nil];
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
    isSmartNotiChecked=YES;
    if (!IS_IPHONE_5) {
        self.tableView.frame=CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y,self.tableView.frame.size.width, self.tableView.frame.size.height );
    }
}
-(void)dolocalizationText{
    self.lblPageTitle.text=NSLocalizedString(@"Settings", nil);
    self.lblBackground.text=NSLocalizedString(@"Background", nil);
    self.lblAddBackgroundToChat.text=NSLocalizedString(@"Add background to chat", nil);
    self.lblConversationGallery.text=NSLocalizedString(@"Conversation Gallery", nil);
    self.lblDefaultNotifications.text=NSLocalizedString(@"Default notofications", nil);
    self.lblNone.text=NSLocalizedString(@"None", nil);
    self.lblParticipants.text=[NSString stringWithFormat:NSLocalizedString(@"Participants (%@)", nil),@"2"];
    self.lblPlusContact.text=NSLocalizedString(@"+ Contacts", nil);
    self.lblSmartNotifications.text=NSLocalizedString(@"Smart notifications", nil);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadMainArray{
    [mainArray addObject:kChatBGCell];
    [mainArray addObject:kChatSmartNoti];
    [mainArray addObject:kChatConvGallery];
    [mainArray addObject:kChatParHeading];
    [mainArray addObject:@"User One"];
    [mainArray addObject:@"User Two"];
    [mainArray addObject:kChatAddContacts];
}
#pragma mark:TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [mainArray count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kChatBGCell]) {
        return 76;
    }
    if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kChatSmartNoti]) {
        return 76;
    }
    if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kChatConvGallery]) {
        return 76;
    }
    else if([[mainArray objectAtIndex:indexPath.row]isEqualToString:kChatParHeading]){
        return 44;
    }
    else if([[mainArray objectAtIndex:indexPath.row]isEqualToString:kChatAddContacts]){
        return 60;
    }
    else{
        return 76;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*This method sets up the table-view.*/
    
    if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kChatBGCell]) {
        self.cellBG.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellBG;
    }
    else if([[mainArray objectAtIndex:indexPath.row]isEqualToString:kChatParHeading]){
        self.cellParHeading.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellParHeading;
    }
    else if([[mainArray objectAtIndex:indexPath.row]isEqualToString:kChatSmartNoti]){
        self.cellSmartNoti.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellSmartNoti;
    }
    else if([[mainArray objectAtIndex:indexPath.row]isEqualToString:kChatConvGallery]){
        self.cellConvGallery.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellConvGallery;
    }
    else if([[mainArray objectAtIndex:indexPath.row]isEqualToString:kChatAddContacts]){
        self.cellAddContacts.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellAddContacts;
    }
    else{
        ChatPartiCell * cell = [tableView dequeueReusableCellWithIdentifier:@"chatPartiCell"];
        if (!cell) {
            NSArray * nibArray = [[NSBundle mainBundle] loadNibNamed:@"ChatPartiCell" owner:nil options:nil];
            cell = (ChatPartiCell*)[nibArray objectAtIndex:0];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [UtilsFunctions makeUIImageViewRound:cell.partImgV ANDRadius:cell.partImgV.frame.size.width/2];
        return cell;
    }
}

#pragma mark:IBActions
- (IBAction)backBtnAction:(id)sender {
    [self.backBtn setSelected:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)smartNotAction:(id)sender {
    if (isSmartNotiChecked) {
        [self.tickImgV setHidden:YES];
        isSmartNotiChecked=NO;
    }
    else{
        [self.tickImgV setHidden:NO];
        isSmartNotiChecked=YES;
    }
}
@end
