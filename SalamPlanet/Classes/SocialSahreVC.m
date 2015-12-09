//
//  SocialSahreVC.m
//  SalamPlanet
//
//  Created by Globit on 30/10/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "SocialSahreVC.h"

@interface SocialSahreVC ()
{
    NSDictionary *endoreDictMain;
}
@end

@implementation SocialSahreVC
-(id)initWithEndoreDict:(NSDictionary *)dict{
    self = [super initWithNibName:@"SocialSahreVC" bundle:nil];
    if (self) {
         endoreDictMain=[[NSDictionary alloc]initWithDictionary:dict];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)shareFBAction:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *fbPostSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [fbPostSheet setInitialText:@"This is a Facebook post!"];
        [self presentViewController:fbPostSheet animated:YES completion:nil];
    } else
    {
        ShowMessage(kAppName,NSLocalizedString(@"You can't post right now, make sure your device has an internet connection and you have at least one facebook account setup", nil));
    }
}

- (IBAction)shareTWAction:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"This is a tweet!"];
        [self presentViewController:tweetSheet animated:YES completion:nil];
        
    }
    else
    {
        ShowMessage(kAppName,NSLocalizedString(@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup", nil));
    }
}

- (IBAction)sendSMSAction:(id)sender {
    MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc] init];
    if ([MFMessageComposeViewController canSendText]) {
        
        NSString *smsString = [endoreDictMain valueForKey:kTempEndrName]
        ;
        messageVC.body = smsString;

        messageVC.messageComposeDelegate = self;
        [self presentViewController:messageVC animated:YES completion:nil];
    }
    else{
        ShowMessage(kAppName,NSLocalizedString(@"Your device doesn't support SMS!", nil));
    }
}

- (IBAction)sendEmailAction:(id)sender {
    // Email Subject
    NSString *emailTitle = @"Salam Mobile Invitation ";
    // Email Content
    NSString *messageBody = [endoreDictMain valueForKey:kTempEndrName];
    // To address
    //    NSArray *toRecipents = [NSArray arrayWithObject:@"support@appcoda.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    if ([MFMailComposeViewController canSendMail]) {
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];

        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
    }
    else{
        ShowMessage(kAppName,NSLocalizedString(@"You can't send email", nil));
    }

}

- (IBAction)shareChatAction:(id)sender {

}

- (IBAction)backBtnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
@end
