//
//  AddProfileVC.h
//  SalamPlanet
//
//  Created by Globit on 12/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+APParallaxHeader.h"
#import "FBLogin.h"

@interface AddProfileVC : UITableViewController<APParallaxViewDelegate,FBLoginDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
//@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellNametf;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellFBBtn;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellContinueBtn;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIButton *continueBtn;
@property (weak, nonatomic) IBOutlet UIButton *fbButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *toolBarDone;

- (IBAction)continueAction:(id)sender;
- (IBAction)synchFBAction:(id)sender;
- (IBAction)hideKeyboard:(id)sender ;
@end
