//
//  TransportInfoCell.m
//  SalamCenterApp
//
//  Created by Globit on 28/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import "TransportInfoCell.h"

@implementation TransportInfoCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize optimumSize = [self.rtLabel optimumSize];
    CGRect frame = [self.rtLabel frame];
    frame.size.height = (int)optimumSize.height; // +5 to fix height issue, this should be automatically fixed in iOS5
    [self.rtLabel setFrame:frame];
    self.imgVBottomLine.frame=CGRectMake(0, frame.origin.y+frame.size.height-1+20.0, self.imgVBottomLine.frame.size.width, 1);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)initializrRTLabel{
    // Initialization code.
    _rtLabel = [TransportInfoCell textLabel];
    [self.contentView addSubview:_rtLabel];
    [_rtLabel setBackgroundColor:[UIColor clearColor]];
}
+ (RTLabel*)textLabel
{
    RTLabel *label = [[RTLabel alloc] initWithFrame:CGRectMake(10,50,300,100)];
    [label setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    [label setParagraphReplacement:@""];
    return label;
}
@end
