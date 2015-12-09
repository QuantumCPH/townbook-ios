//
//  DemoChatViewController.h
//  SalamPlanet
//
//  Created by Globit on 01/10/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatOptionsView.h"
#import "ActivitiesMainVC.h"
#import "ShopsVC.h"

@interface DemoChatViewController : UIViewController<ChatOptionsViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,EOverViewVCDelegate,ShopsVCDelegate>
@property (strong, nonatomic) IBOutlet UILabel *lblPageTitle;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *mainVIew;
@property (weak, nonatomic) IBOutlet UITextField *msgTV;
@property (weak, nonatomic) IBOutlet UIButton *bottomOptionButton;
@property (weak, nonatomic) IBOutlet UIButton *locBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *settingBtn;

- (IBAction)sendMessageAction:(id)sender;
- (IBAction)bottomOptionBarAction:(id)sender;
- (IBAction)locationBtnPressed:(id)sender;

- (IBAction)backAction:(id)sender;
- (IBAction)btnSettingsAction:(id)sender;


-(id)initWithEndorsementCreatedLocally:(NSDictionary *)edoreDict;
@end
