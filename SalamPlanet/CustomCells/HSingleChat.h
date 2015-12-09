//
//  HSingleChat.h
//  SalamPlanet
//
//  Created by Globit on 19/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OnlineStatusView.h"

@interface HSingleChat : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *usrImgV;
@property (weak, nonatomic) IBOutlet UILabel *usrNameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *usrStatusImgV;
@property (weak, nonatomic) IBOutlet UITextView *chatMsgTV;
@property (weak, nonatomic) IBOutlet UILabel *dateLbl;
@property (strong, nonatomic) OnlineStatusView *statusView;

-(void)loadDataWithDummy;
@end
