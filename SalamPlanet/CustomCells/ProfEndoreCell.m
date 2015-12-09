//
//  ProfEndoreCell.m
//  SalamPlanet
//
//  Created by Globit on 24/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "ProfEndoreCell.h"

@implementation ProfEndoreCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setEndoreRatingWith:(NSInteger)rating{
    switch (rating) {
        case 0:
            [self.moonImgOne setImage:[UIImage imageNamed:@"moonS"]];
            [self.moonImgTwo setImage:[UIImage imageNamed:@"moonS"]];
            [self.moonImgThree setImage:[UIImage imageNamed:@"moonS"]];
            [self.moonImgFour setImage:[UIImage imageNamed:@"moonS"]];
            [self.moonImgFive setImage:[UIImage imageNamed:@"moonS"]];
            break;
        case 1:
            [self.moonImgOne setImage:[UIImage imageNamed:@"moonS-selected"]];
            [self.moonImgTwo setImage:[UIImage imageNamed:@"moonS"]];
            [self.moonImgThree setImage:[UIImage imageNamed:@"moonS"]];
            [self.moonImgFour setImage:[UIImage imageNamed:@"moonS"]];
            [self.moonImgFive setImage:[UIImage imageNamed:@"moonS"]];
            break;
        case 2:
            [self.moonImgOne setImage:[UIImage imageNamed:@"moonS-selected"]];
            [self.moonImgTwo setImage:[UIImage imageNamed:@"moonS-selected"]];
            [self.moonImgThree setImage:[UIImage imageNamed:@"moonS"]];
            [self.moonImgFour setImage:[UIImage imageNamed:@"moonS"]];
            [self.moonImgFive setImage:[UIImage imageNamed:@"moonS"]];
            break;
        case 3:
            [self.moonImgOne setImage:[UIImage imageNamed:@"moonS-selected"]];
            [self.moonImgTwo setImage:[UIImage imageNamed:@"moonS-selected"]];
            [self.moonImgThree setImage:[UIImage imageNamed:@"moonS-selected"]];
            [self.moonImgFour setImage:[UIImage imageNamed:@"moonS"]];
            [self.moonImgFive setImage:[UIImage imageNamed:@"moonS"]];
            break;
        case 4:
            [self.moonImgOne setImage:[UIImage imageNamed:@"moonS-selected"]];
            [self.moonImgTwo setImage:[UIImage imageNamed:@"moonS-selected"]];
            [self.moonImgThree setImage:[UIImage imageNamed:@"moonS-selected"]];
            [self.moonImgFour setImage:[UIImage imageNamed:@"moonS-selected"]];
            [self.moonImgFive setImage:[UIImage imageNamed:@"moonS"]];
            break;
        case 5:
            [self.moonImgOne setImage:[UIImage imageNamed:@"moonS-selected"]];
            [self.moonImgTwo setImage:[UIImage imageNamed:@"moonS-selected"]];
            [self.moonImgThree setImage:[UIImage imageNamed:@"moonS-selected"]];
            [self.moonImgFour setImage:[UIImage imageNamed:@"moonS-selected"]];
            [self.moonImgFive setImage:[UIImage imageNamed:@"moonS-selected"]];
            break;
        default:
            break;
    }
}

@end
