//
//  EShareView.m
//  SalamPlanet
//
//  Created by Globit on 12/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "EShareView.h"

@implementation EShareView
@synthesize delegate;

- (id)init{
    self = [self loadFromNib];
    if (self)
    {
    }
    return self;
}
- (id)loadFromNib
{
    NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"EShareView" owner:nil options:nil];
    return [array objectAtIndex:0];
}
- (IBAction)fbBtnPressed:(id)sender {
    [delegate shareTheEndorsementOnFacebook];
}

- (IBAction)twBtnPressed:(id)sender {
    [delegate shareTheEndorsementOnTwitter];
}

- (IBAction)chatBtnPressed:(id)sender {
    [delegate shareTheEndorsementOnChat];
}

- (IBAction)smsBtnPressed:(id)sender {
    [delegate shareTheEndorsementOnSMS];
}

- (IBAction)emailBtnPressed:(id)sender {
    [delegate shareTheEndorsementOnEmail];
}
@end
