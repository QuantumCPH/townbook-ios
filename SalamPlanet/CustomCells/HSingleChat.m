//
//  HSingleChat.m
//  SalamPlanet
//
//  Created by Globit on 19/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "HSingleChat.h"

@implementation HSingleChat

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setFontsOfItemsInView{
    [self.usrNameLbl setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:17.0f]];
    [self.chatMsgTV setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:10.0f]];
    [self.dateLbl setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:10.0f]];
}
-(void)loadDataWithDummy{
//    self.statusView=[[OnlineStatusView alloc]init];
//    CGRect frame=self.statusView.frame;
//    frame.origin.x=150;
//    frame.origin.y=5;
//    [self.statusView setStatusViewWithIsOnline:YES];
//    self.statusView.frame=frame;
//    [self addSubview:self.statusView];
    
    [self setFontsOfItemsInView];
    [self.usrImgV setImage:[UIImage imageNamed:@"parallax_avatar@2x"]];
    [UtilsFunctions makeUIImageViewRound:self.usrImgV ANDRadius:self.usrImgV.frame.size.width/2];
}
@end
