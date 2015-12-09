//
//  ProfDetailCell.m
//  SalamPlanet
//
//  Created by Globit on 24/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "ProfDetailCell.h"
#import <Social/Social.h>

@implementation ProfDetailCell
@synthesize delegate;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setTheViewForOtherUserDetail{
    [self.viewShare setHidden:YES];
    [self.bottomSeparator setHidden:YES];
}
- (IBAction)fbBtnAction:(id)sender {

    [delegate shareTheAppOnSocialMediumWithOption:Facebook];
}

- (IBAction)twBtnAction:(id)sender {

    [delegate shareTheAppOnSocialMediumWithOption:Twitter];
}

- (IBAction)inBtnAction:(id)sender {
    [delegate shareTheAppOnSocialMediumWithOption:LinkedIn];
}

- (IBAction)gPlesBtnAction:(id)sender {
    [delegate shareTheAppOnSocialMediumWithOption:GooglePlus];
}
@end
