//
//  DetailTextCell.m
//  SalamCenterApp
//
//  Created by Waseem Asif on 07/12/2015.
//  Copyright © 2015 Globit. All rights reserved.
//

#import "DetailTextCell.h"

@implementation DetailTextCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)updateConstraints
{
    [super updateConstraints];
    self.textViewHeightConstraint.constant = _detailTextHeight;
}

//- (void)setDetailTextHeight:(int)detailTextHeight
//{
//    _detailTextHeight = detailTextHeight;
//    _textViewHeightConstraint.constant = _detailTextHeight;
//    [self.contentView setNeedsLayout];
//    [self.contentView layoutIfNeeded];
//}
@end
