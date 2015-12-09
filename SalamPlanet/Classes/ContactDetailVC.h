//
//  ContactDetailVC.h
//  SalamCenterApp
//
//  Created by Globit on 15/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THContact.h"
#import <MessageUI/MessageUI.h>

@interface ContactDetailVC : UIViewController<MFMessageComposeViewControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *bgImgV;
@property (strong, nonatomic) IBOutlet UILabel *lblPageTitle;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellBottomDetail;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellTopProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblPhoneNumber;
@property (weak, nonatomic) IBOutlet UIButton *btnInviteChat;
@property (nonatomic) BOOL isAppUser;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) THContact * contactObj;
@property (weak, nonatomic) IBOutlet UIImageView *userImgV;
@property (weak, nonatomic) IBOutlet UILabel *lblBtnTitle;

- (IBAction)backBtnPressed:(id)sender;
- (IBAction)btnInviteChatPressed:(id)sender;
-(id)initWithContac:(THContact *)contactObj AndIsAppUser:(BOOL)isAppUsr;
@end
