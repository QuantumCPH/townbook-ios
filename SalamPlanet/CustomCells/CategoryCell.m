//
//  CategoryCell.m
//  SalamPlanet
//
//  Created by Globit on 25/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        self.backgroundColor = [UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1];
    }
    else{
        self.backgroundColor = [UIColor clearColor];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.backgroundColor = [UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1];
    } else {
        self.backgroundColor = [UIColor clearColor];
    }
    // Configure the view for the selected state
}
//- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
//{
//    if (highlighted) {
//        self.backgroundColor = [UIColor lightGrayColor];
//    } else {
//        self.backgroundColor = [UIColor whiteColor];
//    }
//}
@end
