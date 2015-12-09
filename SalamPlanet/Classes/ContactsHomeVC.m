//
//  ContactsHomeVC.m
//  SalamPlanet
//
//  Created by Globit on 19/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "ContactsHomeVC.h"
#import "THContact.h"
#import "AppDelegate.h"

@interface ContactsHomeVC ()
{
    NSMutableArray * mainContactsArray;
    NSMutableArray * eContactsArray;
    NSMutableArray * searchedArray;
    BOOL isSearched;
    UITapGestureRecognizer * tapGesture;
    AppDelegate * appDelegate;
}
@end

@implementation ContactsHomeVC
-(id)init{
    self = [super initWithNibName:@"ContactsHomeVC" bundle:nil];
    if (self) {
        ABAddressBookRequestAccessWithCompletion(self.addressBookRef, ^(bool granted, CFErrorRef error) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self getContactsFromAddressBook];
                    [self.tableView reloadData];
                });
            } else {
                // TODO: Show alert
            }
        });
        searchedArray=[[NSMutableArray alloc]init];
        eContactsArray=[[NSMutableArray alloc]init];
        isSearched=NO;
        appDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dolocalizationText];
    [self.bgImgV setImage:[UIImage imageNamed:[appDelegate getBackgroundImageName]]];
    self.lblPageTitle.font=[appDelegate getFontOfPageTitle];
    
    tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHasBeenDetected)];
    
    contactsType=AllContacts;
    self.segmentControl.selectedSegmentIndex=1;
    [UtilsFunctions makeUIViewRound:self.searchBGView ANDRadius:4];
    
    //iOS UITableView Hide Header Space
//    self.tableView.contentInset = UIEdgeInsetsMake(-20.0f, 0.0f, 0.0f, 0.0f);
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [eContactsArray removeAllObjects];
    
    for (THContact *contact in mainContactsArray) {
        if (1) {//Contact is not Endoresed
        }
        else{
            [eContactsArray addObject:contact];
        }
    }
}
-(void)dolocalizationText{
    self.lblPageTitle.text=NSLocalizedString(@"CONTACTS", nil);
    [self.segmentControl setTitle:NSLocalizedString(@"ALL", nil) forSegmentAtIndex:1];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark:Custom Methods
-(void)loadSearchedDataWithText:(NSString *)searchText{
    [searchedArray removeAllObjects];
    NSArray * arrayToBeSearched;
    if (contactsType==eContacts) {
        arrayToBeSearched=eContactsArray;
    }
    else{
        arrayToBeSearched=mainContactsArray;
    }
    for (THContact *contact in arrayToBeSearched) {
        NSString * name = [contact fullName];
        if(([name rangeOfString:searchText options:NSCaseInsensitiveSearch].location!=NSNotFound || [searchText isEqualToString:@""]) && name){
            [searchedArray addObject:contact];
        }
    }
    [self.tableView reloadData];
}
#pragma mark:Contacts Methods
-(void)getContactsFromAddressBook
{
    CFErrorRef error = NULL;
    mainContactsArray = [[NSMutableArray alloc]init];
    
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    if (addressBook) {
        NSArray *allContacts = (__bridge_transfer NSArray*)ABAddressBookCopyArrayOfAllPeople(addressBook);
        
        NSUInteger i = 0;
        for (i = 0; i<[allContacts count]; i++)
        {
            THContact *contact = [[THContact alloc] init];
            ABRecordRef contactPerson = (__bridge ABRecordRef)allContacts[i];
            contact.recordId = ABRecordGetRecordID(contactPerson);
            
            // Get first and last names
            NSString *firstName = (__bridge_transfer NSString*)ABRecordCopyValue(contactPerson, kABPersonFirstNameProperty);
            NSString *lastName = (__bridge_transfer NSString*)ABRecordCopyValue(contactPerson, kABPersonLastNameProperty);
            
            // Set Contact properties
            contact.firstName = firstName;
            contact.lastName = lastName;
            
            // Get mobile number
            ABMultiValueRef phonesRef = ABRecordCopyValue(contactPerson, kABPersonPhoneProperty);
            contact.phone = [self getMobilePhoneProperty:phonesRef];
            if(phonesRef) {
                CFRelease(phonesRef);
            }
            
            // Get image if it exists
            NSData  *imgData = (__bridge_transfer NSData *)ABPersonCopyImageData(contactPerson);
            contact.image = [UIImage imageWithData:imgData];
            if (!contact.image) {
                contact.image = [UIImage imageNamed:@"new_avatar.png"];//@"parallax_avatar"];
            }
            
            [mainContactsArray addObject:contact];
        }
        
        if(addressBook) {
            CFRelease(addressBook);
        }
    }
    else
    {
        NSLog(@"Error");
        
    }
}
- (NSString *)getMobilePhoneProperty:(ABMultiValueRef)phonesRef
{
    for (int i=0; i < ABMultiValueGetCount(phonesRef); i++) {
        CFStringRef currentPhoneLabel = ABMultiValueCopyLabelAtIndex(phonesRef, i);
        CFStringRef currentPhoneValue = ABMultiValueCopyValueAtIndex(phonesRef, i);
        
        if(currentPhoneLabel) {
            if (CFStringCompare(currentPhoneLabel, kABPersonPhoneMobileLabel, 0) == kCFCompareEqualTo) {
                return (__bridge NSString *)currentPhoneValue;
            }
            
            if (CFStringCompare(currentPhoneLabel, kABHomeLabel, 0) == kCFCompareEqualTo) {
                return (__bridge NSString *)currentPhoneValue;
            }
        }
        if(currentPhoneLabel) {
            CFRelease(currentPhoneLabel);
        }
        if(currentPhoneValue) {
            CFRelease(currentPhoneValue);
        }
    }
    
    return nil;
}
#pragma mark:TableView DataSource and Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isSearched) {
        return [searchedArray count];
    }
    else{
        if (contactsType==eContacts) {
            return [eContactsArray count];
        }
        else{
            return [mainContactsArray count];
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;//75.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    THContact *contact;
    if (isSearched) {
           contact = [searchedArray objectAtIndex:indexPath.row];
    }
    else{
        if (contactsType==eContacts) {
            contact = [eContactsArray objectAtIndex:indexPath.row];
        }
        else{
            contact = [mainContactsArray objectAtIndex:indexPath.row];
        }
    }
    
    // Initialize the table view cell
    NonEContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nonEContactCell"];
    if (cell == nil){
        NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"NonEContactCell" owner:self options:nil];
        cell=[array objectAtIndex:0];
    }
    
    cell.userNameLbl.text = [contact fullName];
    if(contact.image) {
        cell.userImgV.image = contact.image;
    }
    [UtilsFunctions makeUIImageViewRound:cell.userImgV ANDRadius:cell.userImgV.frame.size.width/2];
    cell.tag=indexPath.row;//[contact recordId];
    cell.delegate=self;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    THContact *contact;
    if (isSearched) {
        contact = [searchedArray objectAtIndex:indexPath.row];
    }
    else{
        if (contactsType==eContacts) {
            contact = [eContactsArray objectAtIndex:indexPath.row];
        }
        else{
            contact = [mainContactsArray objectAtIndex:indexPath.row];
        }
    }
    ContactDetailVC * contactDetailVC=[[ContactDetailVC alloc]initWithContac:contact AndIsAppUser:NO];
    [self.navigationController pushViewController:contactDetailVC animated:YES];
}
#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    isSearched=YES;
    [self.tableView addGestureRecognizer:tapGesture];
    return YES;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self loadSearchedDataWithText:searchText];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{

}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    isSearched=NO;
    [self.searchBar resignFirstResponder];
    [self.tableView reloadData];
}
#pragma mark - NonEContactCellDelegate
-(void)inviteTheUserWithCellTag:(NSInteger)tag{
    THContact *contact;
    if (isSearched) {
        contact = [searchedArray objectAtIndex:tag];
    }
    else{
        contact = [mainContactsArray objectAtIndex:tag];
    }
    MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc] init];
    if ([MFMessageComposeViewController canSendText]){
        if ([contact phone]) {
            messageVC.recipients=[NSArray arrayWithObject:[contact phone]];
        }
        NSString *smsString =NSLocalizedString(@"Hey, check the new wonderful app. Please join Salam mobile app", nil);
        messageVC.body = smsString;
        
        messageVC.messageComposeDelegate = self;
        [self presentViewController:messageVC animated:YES completion:nil];
    }
    else{
        ShowMessage(kAppName,NSLocalizedString(@"Your device doesn't support SMS!", nil));
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
#pragma mark:IBActions and Selectors
-(void)tapHasBeenDetected{
    isSearched=NO;
    [self.tableView removeGestureRecognizer:tapGesture];
    [self.searchBar resignFirstResponder];
}
- (IBAction)btnBackPressed:(id)sender {
    [self.btnBack setSelected:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)segmentedControlChanged:(UISegmentedControl *)segmentedControl{
    contactsType=segmentedControl.selectedSegmentIndex;
    if (isSearched) {
        [self loadSearchedDataWithText:self.searchBar.text];
    }
    [self.tableView reloadData];
}
@end
