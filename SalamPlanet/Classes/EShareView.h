//
//  EShareView.h
//  SalamPlanet
//
//  Created by Globit on 12/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EShareViewDelegate
-(void)shareTheEndorsementOnFacebook;
-(void)shareTheEndorsementOnTwitter;
-(void)shareTheEndorsementOnChat;
-(void)shareTheEndorsementOnSMS;
-(void)shareTheEndorsementOnEmail;
@end


@interface EShareView : UIView

@property (weak,nonatomic) id <EShareViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *fbBtn;
@property (weak, nonatomic) IBOutlet UIButton *twbtn;
@property (weak, nonatomic) IBOutlet UIButton *chatBtn;
@property (weak, nonatomic) IBOutlet UIButton *smsBtn;
@property (weak, nonatomic) IBOutlet UIButton *emailBtn;


- (IBAction)fbBtnPressed:(id)sender;
- (IBAction)twBtnPressed:(id)sender;
- (IBAction)chatBtnPressed:(id)sender;
- (IBAction)smsBtnPressed:(id)sender;
- (IBAction)emailBtnPressed:(id)sender;


@end
