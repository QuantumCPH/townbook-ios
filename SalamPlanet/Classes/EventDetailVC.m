//
//  EventDetailVC.m
//  SalamCenterApp
//
//  Created by Globit on 10/12/2015.
//  Copyright © 2015 Globit. All rights reserved.
//

#import "EventDetailVC.h"
#import "SGActionView.h"

#define kDescriptionMinimumHeight   196.0
@interface EventDetailVC ()
{
    NSMutableArray * mainArray;
}
@property (nonatomic,strong)EventItem * event;
@end

@implementation EventDetailVC

-(id)initWithEvent:(EventItem*)item{
    self=[super initWithNibName:@"EventDetailVC" bundle:nil];
    if (self) {
        mainArray=[[NSMutableArray alloc]init];
        [mainArray addObject:@"TopCell"];
        [mainArray addObject:@"ActionCell"];
        [mainArray addObject:@"DetailCell"];
        [mainArray addObject:@"MapCell"];
        _event=item;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lblTitle.text=NSLocalizedString(@"Event Detail", nil);
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
//    CGSize calcDescriptionLblSize=[self getSizeForText:_event.descText maxWidth:self.lblDesc.frame.size.width font:self.lblDesc.font.fontName fontSize:14.0];
//    self.lblDesc.frame=CGRectMake(self.lblDesc.frame.origin.x, self.lblDesc.frame.origin.y, self.lblDesc.frame.size.width,calcDescriptionLblSize.height);

    self.mapView.showsUserLocation=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGSize)getSizeForText:(NSString *)text maxWidth:(CGFloat)width font:(NSString *)fontName fontSize:(float)fontSize {
    CGSize constraintSize;
    constraintSize.height = MAXFLOAT;
    constraintSize.width = width;
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [UIFont fontWithName:fontName size:fontSize], NSFontAttributeName,
                                          nil];
    
    CGRect frame = [text boundingRectWithSize:constraintSize
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:attributesDictionary
                                      context:nil];
    
    CGSize stringSize = frame.size;
    return stringSize;
}
#pragma mark: UITableView Delegates and Datasource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mainArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:@"TopCell"]) {
        return 313;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:@"ActionCell"]) {
        return 40;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:@"DetailCell"]) {
//        return 196;
        CGSize calcDescriptionLblSize=[self getSizeForText:_event.descText maxWidth:self.lblDesc.frame.size.width font:self.lblDesc.font.fontName fontSize:14.0];
//        self.lblDesc.frame=CGRectMake(self.lblDesc.frame.origin.x, self.lblDesc.frame.origin.y, self.lblDesc.frame.size.width,calcDescriptionLblSize.height);
        if (IS_IPHONE_5_OR_LESS) {
            return MAX(kDescriptionMinimumHeight, calcDescriptionLblSize.height+50);
        }
        return MAX(kDescriptionMinimumHeight, calcDescriptionLblSize.height);
//        return MAX(kDescriptionMinimumHeight,self.lblDesc.frame.size.height);
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:@"MapCell"]) {
        return 204;
    }
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:@"TopCell"]) {
        self.lblUserName.text=_event.userName;
        self.imgEvent.image=[UIImage imageNamed:_event.imgName];
        self.lblDateCreated.text=_event.dateCreated;
        self.lblDateHappen.text=_event.dateEvent;
        self.lblPlace.text=_event.place;
        [UtilsFunctions makeUIImageViewRound:self.imgUser ANDRadius:self.imgUser.frame.size.width/2];
        self.cellTop.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellTop;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:@"ActionCell"]) {
        self.cellActionBar.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellActionBar;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:@"DetailCell"]) {
        self.lblEventTitle.text=_event.title;
        self.lblDesc.text=_event.descText;
        self.cellDetail.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellDetail;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:@"MapCell"]) {
        self.cellMap.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellMap;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark-ShareView
-(void)showSGShareView{
    [SGActionView sharedActionView].style=SGActionViewStyleDark;
    SGMenuActionHandler handler=^(NSInteger index){
        NSLog(@"selected index= %li",(long)index);
        [self.btnShare setSelected:NO];
        switch (index) {
            case 1:
                [self shareTheShopOnFacebook];
                break;
            case 2:
                [self shareTheShopOnTwitter];
                break;
            case 3:
                [self shareTheShopOnSMS];
                break;
            case 4:
                [self shareTheShopOnEmail];
                break;

            default:
                break;
        }
    };
    [SGActionView showGridMenuWithTitle:@"Del Begivenheder"
                             itemTitles:@[ @"Facebook", @"Twitter", @"SMS", @"Email"]
                                 images:@[ [UIImage imageNamed:@"share-facebook-button"],
                                           [UIImage imageNamed:@"share-twitter-button"],
                                           [UIImage imageNamed:@"share-sms-button"],
                                           [UIImage imageNamed:@"share-email-button"]]
                         selectedHandle:handler];
}
-(void)shareTheShopOnFacebook{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *fbPostSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [fbPostSheet addImage:[UIImage imageNamed:_event.imgName]];
        [fbPostSheet setInitialText:_event.briefText];
        [self presentViewController:fbPostSheet animated:YES completion:nil];
    } else
    {
        ShowMessage(kAppName,NSLocalizedString(@"You can't post right now, make sure your device has an internet connection and you have at least one facebook account setup", nil));
    }
}
-(void)shareTheShopOnTwitter{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet addImage:[UIImage imageNamed:_event.imgName]];
        [tweetSheet setInitialText:_event.title];
        [self presentViewController:tweetSheet animated:YES completion:nil];
        
    }
    else
    {
        ShowMessage(kAppName,NSLocalizedString(@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup", nil));
    }
}
-(void)shareTheShopOnSMS{
    MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc] init];
    if ([MFMessageComposeViewController canSendText]) {
        
        NSString *smsString = _event.briefText;
        messageVC.body = smsString;
        
        messageVC.messageComposeDelegate = self;
        [self presentViewController:messageVC animated:YES completion:nil];
    }
    else{
        ShowMessage(kAppName,NSLocalizedString(@"Your device doesn't support SMS!", nil));
    }
}
-(void)shareTheShopOnEmail{
    // Email Subject
    NSString *emailTitle ;
    // Email Content
    NSString *messageBody ;
    emailTitle = _event.title;
    messageBody = _event.descText;
    // To address
    //    NSArray *toRecipents = [NSArray arrayWithObject:@"support@appcoda.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    if ([MFMailComposeViewController canSendMail]) {
        mc.mailComposeDelegate = self;
        [mc setSubject:[NSString stringWithFormat:@"Town Book App: %@",emailTitle]];
        [mc setMessageBody:messageBody isHTML:NO];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
    }
    else{
        ShowMessage(kAppName,NSLocalizedString(@"You can't send email", nil));
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
#pragma mark - MFMailComposeViewControllerDelegate methods
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}
#pragma mark-IBActions
- (IBAction)btnBackPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnSharePressed:(id)sender {
    [self showSGShareView];
}
@end
