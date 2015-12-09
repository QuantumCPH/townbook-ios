//
//  SCenterCell.m
//  SalamCenterApp
//
//  Created by Globit on 26/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "SCenterCell.h"

@implementation SCenterCell

- (void)awakeFromNib {
    // Initialization code
    _pressedColour = [UIColor colorWithRed:135.0/255.0 green:93.0/255.0 blue:169.0/255.0 alpha:1];
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
        [self.centerNameLbl setTextColor:_pressedColour];
        [self.placeNameLbl setTextColor:_pressedColour];
        [self.centerCityLbl setTextColor:_pressedColour];
    }
    else{
        [self.heartBtn setImage:[UIImage imageNamed:@"heart_un"] forState:UIControlStateNormal];
        [self.centerNameLbl setTextColor:[UIColor lightGrayColor]];
        [self.placeNameLbl setTextColor:[UIColor lightGrayColor]];
        [self.centerCityLbl setTextColor:[UIColor lightGrayColor]];
    }
}

- (IBAction)heartBtnPressed:(UIButton*)sender {
    if (isHearPressed) {
        [self.heartBtn setImage:[UIImage imageNamed:@"heart_un"] forState:UIControlStateNormal];
        isHearPressed=NO;
        [self.centerNameLbl setTextColor:[UIColor lightGrayColor]];
        [self.placeNameLbl setTextColor:[UIColor lightGrayColor]];
        [self.centerCityLbl setTextColor:[UIColor lightGrayColor]];
        [self.delegate centerIsSelectedButtonPressedWithOption:isHearPressed ANDTag:sender.tag];
    }
    else{
        [self.heartBtn setImage:[UIImage imageNamed:@"heart"] forState:UIControlStateNormal];
        isHearPressed=YES;
        [self.centerNameLbl setTextColor:_pressedColour];
        [self.placeNameLbl setTextColor:_pressedColour];
        [self.centerCityLbl setTextColor:_pressedColour];
        [self.delegate centerIsSelectedButtonPressedWithOption:isHearPressed ANDTag:sender.tag];
    }
}
@end
