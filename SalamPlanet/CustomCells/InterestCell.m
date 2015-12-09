//
//  InterestCell.m
//  SalamCenterApp
//
//  Created by Globit on 02/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "InterestCell.h"

@implementation InterestCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)heartBtnPressed:(UIButton*)sender {
    if (isHearPressed) {
        [self.heartBtn setImage:[UIImage imageNamed:@"heart_un"] forState:UIControlStateNormal];
        isHearPressed=NO;
        [self.interNameLbl setTextColor:[UIColor lightGrayColor]];
        [self.delegate interestIsSelectedButtonPressedWithOption:isHearPressed ANDTag:sender.tag];
    }
    else{
        [self.heartBtn setImage:[UIImage imageNamed:@"heart"] forState:UIControlStateNormal];
        isHearPressed=YES;
        [self.interNameLbl setTextColor:[UIColor colorWithRed:135.0/255.0 green:93.0/255.0 blue:169.0/255.0 alpha:1]];
        [self.delegate interestIsSelectedButtonPressedWithOption:isHearPressed ANDTag:sender.tag];
    }
}
-(void)makeHearPressed:(BOOL)showPressed{
    isHearPressed=showPressed;
    if(isHearPressed)
    {
        [self.heartBtn setImage:[UIImage imageNamed:@"heart"] forState:UIControlStateNormal];
        [self.interNameLbl setTextColor:[UIColor colorWithRed:135.0/255.0 green:93.0/255.0 blue:169.0/255.0 alpha:1]];
    }
    else{
        [self.heartBtn setImage:[UIImage imageNamed:@"heart_un"] forState:UIControlStateNormal];
        [self.interNameLbl setTextColor:[UIColor lightGrayColor]];
    }
}

@end
