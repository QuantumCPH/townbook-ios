//
//  UEndoreMsgCell.m
//  SalamPlanet
//
//  Created by Globit on 18/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "UEndoreMsgCell.h"

@implementation UEndoreMsgCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadDataToViewWithDict:(NSDictionary *)dict ANDUserDict:(NSDictionary *)userDict{
    self.eNameLbl.text=[dict objectForKey:kTempEndrName];
    NSArray * arrayImages=[dict valueForKey:kTempEndrImageArray];
    if([arrayImages count]>0){
        self.eImgV.image=[UtilsFunctions imageWithImage:[arrayImages objectAtIndex:0] scaledToSize:CGSizeMake(280*2, 172*2)];
    }
    else{
        self.eImgV.image=nil;
    }
    self.eUserNameLbl.text=[NSString stringWithFormat:@"Last updated by %@",[userDict objectForKey:kTempUserName]];
    
    if([dict valueForKey:kTempEndrCategory] && [dict valueForKey:kTempEndrSubCategory]){
        self.eCatSubCatLbl.text=[NSString stringWithFormat:@"%@,%@",[dict valueForKey:kTempEndrCategory],[dict valueForKey:kTempEndrSubCategory]];
    }
    if([dict valueForKey:kTempEndrComment]){
        self.eQuoteLbl.text=[dict valueForKey:kTempEndrComment];
    }
    if ([dict valueForKey:kTempEndrTime]) {
        self.eTimeLbl.text=[dict valueForKey:kTempEndrTime];
    }
    NSInteger rating=[[dict valueForKey:kTempEndrRating]integerValue];
    [self setEndoreRatingWith:rating];
}
-(void)setEndoreRatingWith:(NSInteger)rating{
    switch (rating) {
        case 0:
            [self.moonImgOne setImage:[UIImage imageNamed:@"moon-empty.png"]];
            [self.moonImgTwo setImage:[UIImage imageNamed:@"moon-empty.png"]];
            [self.moonImgThree setImage:[UIImage imageNamed:@"moon-empty.png"]];
            [self.moonImgFour setImage:[UIImage imageNamed:@"moon-empty.png"]];
            [self.moonImgFive setImage:[UIImage imageNamed:@"moon-empty.png"]];
            break;
        case 1:
            [self.moonImgOne setImage:[UIImage imageNamed:@"moon-filled.png"]];
            [self.moonImgTwo setImage:[UIImage imageNamed:@"moon-empty.png"]];
            [self.moonImgThree setImage:[UIImage imageNamed:@"moon-empty.png"]];
            [self.moonImgFour setImage:[UIImage imageNamed:@"moon-empty.png"]];
            [self.moonImgFive setImage:[UIImage imageNamed:@"moon-empty.png"]];
            break;
        case 2:
            [self.moonImgOne setImage:[UIImage imageNamed:@"moon-filled.png"]];
            [self.moonImgTwo setImage:[UIImage imageNamed:@"moon-filled.png"]];
            [self.moonImgThree setImage:[UIImage imageNamed:@"moon-empty.png"]];
            [self.moonImgFour setImage:[UIImage imageNamed:@"moon-empty.png"]];
            [self.moonImgFive setImage:[UIImage imageNamed:@"moon-empty.png"]];
            break;
        case 3:
            [self.moonImgOne setImage:[UIImage imageNamed:@"moon-filled.png"]];
            [self.moonImgTwo setImage:[UIImage imageNamed:@"moon-filled.png"]];
            [self.moonImgThree setImage:[UIImage imageNamed:@"moon-filled.png"]];
            [self.moonImgFour setImage:[UIImage imageNamed:@"moon-empty.png"]];
            [self.moonImgFive setImage:[UIImage imageNamed:@"moon-empty.png"]];
            break;
        case 4:
            [self.moonImgOne setImage:[UIImage imageNamed:@"moon-filled.png"]];
            [self.moonImgTwo setImage:[UIImage imageNamed:@"moon-filled.png"]];
            [self.moonImgThree setImage:[UIImage imageNamed:@"moon-filled.png"]];
            [self.moonImgFour setImage:[UIImage imageNamed:@"moon-filled.png"]];
            [self.moonImgFive setImage:[UIImage imageNamed:@"moon-empty.png"]];
            break;
        case 5:
            [self.moonImgOne setImage:[UIImage imageNamed:@"moon-filled.png"]];
            [self.moonImgTwo setImage:[UIImage imageNamed:@"moon-filled.png"]];
            [self.moonImgThree setImage:[UIImage imageNamed:@"moon-filled.png"]];
            [self.moonImgFour setImage:[UIImage imageNamed:@"moon-filled.png"]];
            [self.moonImgFive setImage:[UIImage imageNamed:@"moon-filled.png"]];
            break;
        default:
            break;
    }
}

@end
