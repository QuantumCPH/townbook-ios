//
//  RatingCellTableViewCell.m
//  SalamPlanet
//
//  Created by Globit on 23/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "RatingCellTableViewCell.h"

@implementation RatingCellTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
