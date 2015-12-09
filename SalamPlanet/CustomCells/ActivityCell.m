//
//  ActivityCell.m
//  SalamCenterApp
//
//  Created by Waseem Asif on 17/11/2015.
//  Copyright © 2015 Globit. All rights reserved.
//

#import "ActivityCell.h"

@implementation ActivityCell

- (void)awakeFromNib {
    self.entityLogoImgView.layer.borderColor =[UIColor grayColor].CGColor;
    self.entityLogoImgView.layer.borderWidth = 1.0f;
    self.entityLogoImgView.layer.masksToBounds = YES;
    self.entityLogoImgView.layer.cornerRadius = CGRectGetWidth(_entityLogoImgView.frame) / 2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)makeHearPressed:(BOOL)showPressed{
    [self.heartBtn setSelected:showPressed];
}
- (IBAction)heartBtnPressed:(UIButton*)sender {
    if (_isForFavourites)
        return ;
    
     [self.heartBtn setSelected:!self.heartBtn.selected];
    if (isHearPressed) {
        isHearPressed=NO;
        [self.delegate bannerBookmarkButtonPressedWithOption:isHearPressed ANDTag:sender.tag];
    }
    else{
        isHearPressed=YES;
        [self.delegate bannerBookmarkButtonPressedWithOption:isHearPressed ANDTag:sender.tag];
    }
}
@end
