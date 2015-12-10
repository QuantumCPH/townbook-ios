//
//  EventHomeCell.m
//  SalamCenterApp
//
//  Created by Globit on 10/12/2015.
//  Copyright © 2015 Globit. All rights reserved.
//

#import "EventHomeCell.h"

@implementation EventHomeCell

- (void)awakeFromNib {
    // Initialization code
    [UtilsFunctions makeUIImageViewRound:self.imgUser ANDRadius:self.imgUser.frame.size.width/2];
    [UtilsFunctions makeUIImageViewRound:self.imgEvent ANDRadius:7];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
