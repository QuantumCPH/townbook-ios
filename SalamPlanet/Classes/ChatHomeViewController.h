//
//  ChatHomeViewController.h
//  SalamPlanet
//
//  Created by Globit on 26/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatHomeViewController : UIViewController<UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *bgImgV;
@property (strong, nonatomic) IBOutlet UILabel *lblPageTitle;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *composeBtn;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (strong, nonatomic) IBOutlet UIButton *btnContacts;

- (IBAction)compseBtnAction:(id)sender;
- (IBAction)segmentedControlChanged:(UISegmentedControl *)segmentedControl;
- (IBAction)btnContactsPressed:(id)sender;
@end
