//
//  EndorsementCollectionCell.m
//  SalamPlanet
//
//  Created by Saad Khan on 19/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "EndorsementCollectionCell.h"

@implementation EndorsementCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        isStarPressed=YES;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)makeStarPressed:(BOOL)showPressed{
    isStarPressed=showPressed;
    if(isStarPressed)
    {
        [self.starBtn setImage:[UIImage imageNamed:@"star-thumb"] forState:UIControlStateNormal];
    }
    else{
        [self.starBtn setImage:[UIImage imageNamed:@"star-thumb-pressed"] forState:UIControlStateNormal];        
    }
}
- (IBAction)starBtnPressed:(id)sender {
    if (isStarPressed) {
        [self.starBtn setImage:[UIImage imageNamed:@"star-thumb-pressed"] forState:UIControlStateNormal];
        isStarPressed=NO;
    }
    else{
        [self.starBtn setImage:[UIImage imageNamed:@"star-thumb"] forState:UIControlStateNormal];
        isStarPressed=YES;
    }
    [self.delegate favouriteButtonPressedWithOption:isStarPressed ANDTag:self.tag];
}
@end
