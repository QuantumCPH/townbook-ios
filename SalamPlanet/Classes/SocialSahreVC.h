//
//  SocialSahreVC.h
//  SalamPlanet
//
//  Created by Globit on 30/10/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>

@interface SocialSahreVC : UIViewController<MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate,UINavigationControllerDelegate>

- (IBAction)shareFBAction:(id)sender;
- (IBAction)shareTWAction:(id)sender;
- (IBAction)sendSMSAction:(id)sender;
- (IBAction)sendEmailAction:(id)sender;
- (IBAction)shareChatAction:(id)sender;
- (IBAction)backBtnAction:(id)sender;


-(id)initWithEndoreDict:(NSDictionary *)dict;
@end
