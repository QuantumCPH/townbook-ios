//
//  CenterBannerCell.m
//  SalamCenterApp
//
//  Created by Globit on 26/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "CenterBannerCell.h"

@implementation CenterBannerCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    UIBezierPath *maskPath;
    CGRect imageRect = self.objImgV.bounds;
    imageRect.size.width+= 50;//50 is for correcting error in iphone 6 and iphone 6+
    maskPath = [UIBezierPath bezierPathWithRoundedRect:imageRect
                                     byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerTopLeft)
                                           cornerRadii:CGSizeMake(3.0, 3.0)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.objImgV.layer.mask = maskLayer;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)makeHearPressed:(BOOL)showPressed{
    isHearPressed=showPressed;
    if(isHearPressed)
    {
        [self.heartBtn setImage:[UIImage imageNamed:@"heart"] forState:UIControlStateNormal];
    }
    else{
        [self.heartBtn setImage:[UIImage imageNamed:@"heart_un"] forState:UIControlStateNormal];
    }
}

- (IBAction)gotoShopDetailAcion:(id)sender {
    //[self.delegate gotoShopDetailForTag:self.tag];
}
- (IBAction)heartBtnPressed:(UIButton*)sender {
    if (_isForFavourites)
        return ;
    
    if (isHearPressed) {
        [self.heartBtn setImage:[UIImage imageNamed:@"heart_un"] forState:UIControlStateNormal];
        isHearPressed=NO;
        [self.delegate bannerBookmarkButtonPressedWithOption:isHearPressed ANDTag:sender.tag];
    }
    else{
        [self.heartBtn setImage:[UIImage imageNamed:@"heart"] forState:UIControlStateNormal];
        isHearPressed=YES;
        [self.delegate bannerBookmarkButtonPressedWithOption:isHearPressed ANDTag:sender.tag];
    }
}
@end
