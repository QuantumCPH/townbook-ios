//
//  ContactsHomeVC.h
//  SalamPlanet
//
//  Created by Globit on 19/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import "HMSegmentedControl.h"
#import "NonEContactCell.h"
#import <MessageUI/MessageUI.h>
#import "ContactDetailVC.h"

@interface ContactsHomeVC : UIViewController<UISearchBarDelegate,NonEContactCellDelegate,MFMessageComposeViewControllerDelegate>
{
    ContactsType contactsType;
}
@property (weak, nonatomic) IBOutlet UIImageView *bgImgV;
@property (strong, nonatomic) IBOutlet UILabel *lblPageTitle;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) ABAddressBookRef addressBookRef;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIView *searchBGView;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;

- (IBAction)btnBackPressed:(id)sender;
- (IBAction)segmentedControlChanged:(UISegmentedControl *)segmentedControl;
@end
