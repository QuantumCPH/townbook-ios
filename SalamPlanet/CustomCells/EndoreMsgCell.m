//
//  EndoreMsgself.m
//  SalamPlanet
//
//  Created by Saad Khan on 19/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "EndoreMsgCell.h"

@implementation EndoreMsgCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)setEndoreRatingWith:(NSInteger)rating{
    switch (rating) {
        case 0:
            [self.moonImgOne setImage:[UIImage imageNamed:@"moon"]];
            [self.moonImgTwo setImage:[UIImage imageNamed:@"moon"]];
            [self.moonImgThree setImage:[UIImage imageNamed:@"moon"]];
            [self.moonImgFour setImage:[UIImage imageNamed:@"moon"]];
            [self.moonImgFive setImage:[UIImage imageNamed:@"moon"]];
            break;
        case 1:
            [self.moonImgOne setImage:[UIImage imageNamed:@"moon-selected"]];
            [self.moonImgTwo setImage:[UIImage imageNamed:@"moon"]];
            [self.moonImgThree setImage:[UIImage imageNamed:@"moon"]];
            [self.moonImgFour setImage:[UIImage imageNamed:@"moon"]];
            [self.moonImgFive setImage:[UIImage imageNamed:@"moon"]];
            break;
        case 2:
            [self.moonImgOne setImage:[UIImage imageNamed:@"moon-selected"]];
            [self.moonImgTwo setImage:[UIImage imageNamed:@"moon-selected"]];
            [self.moonImgThree setImage:[UIImage imageNamed:@"moon"]];
            [self.moonImgFour setImage:[UIImage imageNamed:@"moon"]];
            [self.moonImgFive setImage:[UIImage imageNamed:@"moon"]];
            break;
        case 3:
            [self.moonImgOne setImage:[UIImage imageNamed:@"moon-selected"]];
            [self.moonImgTwo setImage:[UIImage imageNamed:@"moon-selected"]];
            [self.moonImgThree setImage:[UIImage imageNamed:@"moon-selected"]];
            [self.moonImgFour setImage:[UIImage imageNamed:@"moon"]];
            [self.moonImgFive setImage:[UIImage imageNamed:@"moon"]];
            break;
        case 4:
            [self.moonImgOne setImage:[UIImage imageNamed:@"moon-selected"]];
            [self.moonImgTwo setImage:[UIImage imageNamed:@"moon-selected"]];
            [self.moonImgThree setImage:[UIImage imageNamed:@"moon-selected"]];
            [self.moonImgFour setImage:[UIImage imageNamed:@"moon-selected"]];
            [self.moonImgFive setImage:[UIImage imageNamed:@"moon"]];
            break;
        case 5:
            [self.moonImgOne setImage:[UIImage imageNamed:@"moon-selected"]];
            [self.moonImgTwo setImage:[UIImage imageNamed:@"moon-selected"]];
            [self.moonImgThree setImage:[UIImage imageNamed:@"moon-selected"]];
            [self.moonImgFour setImage:[UIImage imageNamed:@"moon-selected"]];
            [self.moonImgFive setImage:[UIImage imageNamed:@"moon-selected"]];
            break;
        default:
            break;
    }
}
-(void)updateUserDataViewWith:(NSDictionary *)userDict{
    self.endrUserNameLbl.text=[userDict valueForKey:kTempUserName];
    self.userPicImgV.image=[userDict valueForKey:kTempUserPic];
    [UtilsFunctions makeUIImageViewRound:self.userPicImgV ANDRadius:25];
    [self setFontsOfItemsInView];
}

-(void)setFontsOfItemsInView{
    [self.endrNameLbl setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:18.0f]];
    [self.catSubCatLbl setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:11.0f]];
    [self.tagsLbl setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:11.0f]];
}

-(void)setRatingByUserWith:(NSInteger)rating{
    switch (rating) {
        case 0:
            [self.uMoonImgOne setImage:[UIImage imageNamed:@"moon"]];
            [self.uMoonImgTwo setImage:[UIImage imageNamed:@"moon"]];
            [self.uMoonImgThree setImage:[UIImage imageNamed:@"moon"]];
            [self.uMoonImgFour setImage:[UIImage imageNamed:@"moon"]];
            [self.uMoonImgFive setImage:[UIImage imageNamed:@"moon"]];
            break;
        case 1:
            [self.uMoonImgOne setImage:[UIImage imageNamed:@"moon-selected"]];
            [self.uMoonImgTwo setImage:[UIImage imageNamed:@"moon"]];
            [self.uMoonImgThree setImage:[UIImage imageNamed:@"moon"]];
            [self.uMoonImgFour setImage:[UIImage imageNamed:@"moon"]];
            [self.uMoonImgFive setImage:[UIImage imageNamed:@"moon"]];
            break;
        case 2:
            [self.uMoonImgOne setImage:[UIImage imageNamed:@"moon-selected"]];
            [self.uMoonImgTwo setImage:[UIImage imageNamed:@"moon-selected"]];
            [self.uMoonImgThree setImage:[UIImage imageNamed:@"moon"]];
            [self.uMoonImgFour setImage:[UIImage imageNamed:@"moon"]];
            [self.uMoonImgFive setImage:[UIImage imageNamed:@"moon"]];
            break;
        case 3:
            [self.uMoonImgOne setImage:[UIImage imageNamed:@"moon-selected"]];
            [self.uMoonImgTwo setImage:[UIImage imageNamed:@"moon-selected"]];
            [self.uMoonImgThree setImage:[UIImage imageNamed:@"moon-selected"]];
            [self.uMoonImgFour setImage:[UIImage imageNamed:@"moon"]];
            [self.uMoonImgFive setImage:[UIImage imageNamed:@"moon"]];
            break;
        case 4:
            [self.uMoonImgOne setImage:[UIImage imageNamed:@"moon-selected"]];
            [self.uMoonImgTwo setImage:[UIImage imageNamed:@"moon-selected"]];
            [self.uMoonImgThree setImage:[UIImage imageNamed:@"moon-selected"]];
            [self.uMoonImgFour setImage:[UIImage imageNamed:@"moon-selected"]];
            [self.uMoonImgFive setImage:[UIImage imageNamed:@"moon"]];
            break;
        case 5:
            [self.uMoonImgOne setImage:[UIImage imageNamed:@"moon-selected"]];
            [self.uMoonImgTwo setImage:[UIImage imageNamed:@"moon-selected"]];
            [self.uMoonImgThree setImage:[UIImage imageNamed:@"moon-selected"]];
            [self.uMoonImgFour setImage:[UIImage imageNamed:@"moon-selected"]];
            [self.uMoonImgFive setImage:[UIImage imageNamed:@"moon-selected"]];
            break;
        default:
            break;
    }
}
@end
