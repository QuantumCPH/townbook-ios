//
//  NonEContactCell.m
//  SalamPlanet
//
//  Created by Globit on 19/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "NonEContactCell.h"

@implementation NonEContactCell
@synthesize delegate;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)inviteUser:(id)sender {
    [delegate inviteTheUserWithCellTag:self.tag];
}
@end
