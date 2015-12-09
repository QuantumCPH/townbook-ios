//
//  ChatSettingsVC.h
//  SalamPlanet
//
//  Created by Globit on 17/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatSettingsVC : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *lblPageTitle;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellBG;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellParHeading;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellSmartNoti;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellConvGallery;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellAddContacts;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UILabel *lblBackground;
@property (strong, nonatomic) IBOutlet UILabel *lblAddBackgroundToChat;
@property (strong, nonatomic) IBOutlet UILabel *lblSmartNotifications;
@property (strong, nonatomic) IBOutlet UILabel *lblDefaultNotifications;
@property (strong, nonatomic) IBOutlet UILabel *lblNone;
@property (strong, nonatomic) IBOutlet UILabel *lblConversationGallery;
@property (strong, nonatomic) IBOutlet UILabel *lblParticipants;
@property (strong, nonatomic) IBOutlet UILabel *lblPlusContact;

- (IBAction)backBtnAction:(id)sender;
- (IBAction)smartNotAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *tickImgV;

@end
