//
//  DemoChatVCWithParralax.h
//  SalamPlanet
//
//  Created by Globit on 01/10/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatOptionsView.h"
#import "EOverViewVC.h"

@interface DemoChatVCWithParralax : UIViewController<ChatOptionsViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,EOverViewVCDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *mainVIew;
@property (weak, nonatomic) IBOutlet UITextField *msgTV;
@property (weak, nonatomic) IBOutlet UIButton *bottomOptionButton;

- (IBAction)sendMessageAction:(id)sender;
- (IBAction)bottomOptionBarAction:(id)sender;

- (IBAction)backAction:(id)sender;
- (IBAction)btnSettingsAction:(id)sender;


-(id)initWithEndorsementCreatedLocally:(NSDictionary *)edoreDict;
@end
