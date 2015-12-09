//
//  EndoreCommentViewCell.m
//  SalamPlanet
//
//  Created by Globit on 26/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "EndoreCommentViewCell.h"
#import "UtilsFunctions.h"

@implementation EndoreCommentViewCell
@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadEndorsementData:(Endorsement *)endore{
    self.endrImgView.image=[UIImage imageNamed:endore.endrImageURL];
    self.endrUserProfileImgView.image=[UIImage imageNamed:endore.endrByUser.userPicURL];
    [UtilsFunctions makeUIImageViewRound:self.endrUserProfileImgView ANDRadius:self.endrUserProfileImgView.frame.size.width/2];
    self.endrUserNameLbl.text=endore.endrByUser.userName;
    self.dateTimeLabel.text=endore.endrDates;
    self.mainCommentTV.text=endore.endrComment;
    switch (endore.endrRating) {
        case 0:
            [self.moonOne setImage:[UIImage imageNamed:@"moon.png"]];
            [self.moonTwo setImage:[UIImage imageNamed:@"moon.png"]];
            [self.moonThree setImage:[UIImage imageNamed:@"moon.png"]];
            [self.moonFour setImage:[UIImage imageNamed:@"moon.png"]];
            [self.moonFive setImage:[UIImage imageNamed:@"moon.png"]];
            break;
        case 1:
            [self.moonOne setImage:[UIImage imageNamed:@"moon-selected.png"]];
            [self.moonTwo setImage:[UIImage imageNamed:@"moon.png"]];
            [self.moonThree setImage:[UIImage imageNamed:@"moon.png"]];
            [self.moonFour setImage:[UIImage imageNamed:@"moon.png"]];
            [self.moonFive setImage:[UIImage imageNamed:@"moon.png"]];
            break;
        case 2:
            [self.moonOne setImage:[UIImage imageNamed:@"moon-selected.png"]];
            [self.moonTwo setImage:[UIImage imageNamed:@"moon-selected.png"]];
            [self.moonThree setImage:[UIImage imageNamed:@"moon.png"]];
            [self.moonFour setImage:[UIImage imageNamed:@"moon.png"]];
            [self.moonFive setImage:[UIImage imageNamed:@"moon.png"]];
            break;
        case 3:
            [self.moonOne setImage:[UIImage imageNamed:@"moon-selected.png"]];
            [self.moonTwo setImage:[UIImage imageNamed:@"moon-selected.png"]];
            [self.moonThree setImage:[UIImage imageNamed:@"moon-selected.png"]];
            [self.moonFour setImage:[UIImage imageNamed:@"moon.png"]];
            [self.moonFive setImage:[UIImage imageNamed:@"moon.png"]];
            break;
        case 4:
            [self.moonOne setImage:[UIImage imageNamed:@"moon-selected.png"]];
            [self.moonTwo setImage:[UIImage imageNamed:@"moon-selected.png"]];
            [self.moonThree setImage:[UIImage imageNamed:@"moon-selected.png"]];
            [self.moonFour setImage:[UIImage imageNamed:@"moon-selected.png"]];
            [self.moonFive setImage:[UIImage imageNamed:@"moon.png"]];
            break;
        case 5:
            [self.moonOne setImage:[UIImage imageNamed:@"moon-selected.png"]];
            [self.moonTwo setImage:[UIImage imageNamed:@"moon-selected.png"]];
            [self.moonThree setImage:[UIImage imageNamed:@"moon-selected.png"]];
            [self.moonFour setImage:[UIImage imageNamed:@"moon-selected.png"]];
            [self.moonFive setImage:[UIImage imageNamed:@"moon-selected.png"]];
            break;
        default:
            break;
    }
}
-(void)loadDictData:(NSDictionary *)dict ANDUserDict:(NSDictionary *)userDict{
    NSArray * imgArray=[dict valueForKey:kTempEndrImageArray];
    if([imgArray count]>0){
        self.endrImgView.image=[imgArray objectAtIndex:0];
    }
    else{
        self.endrImgView.image=nil;
    }
    self.endrUserProfileImgView.image=[userDict valueForKey:kTempUserPic];
    [UtilsFunctions makeUIImageViewRound:self.endrUserProfileImgView ANDRadius:self.endrUserProfileImgView.frame.size.width/2];
    self.endrUserNameLbl.text=[userDict valueForKey:kTempUserName];
    self.dateTimeLabel.text=[dict valueForKey:kTempEndrDate];
    self.mainCommentTV.text=[dict valueForKey:kTempEndrComment];
    switch ([[dict valueForKey:kTempEndrRating]integerValue]) {
        case 0:
            [self.moonOne setImage:[UIImage imageNamed:@"ecomments-rating-icon"]];
            [self.moonTwo setImage:[UIImage imageNamed:@"ecomments-rating-icon"]];
            [self.moonThree setImage:[UIImage imageNamed:@"ecomments-rating-icon"]];
            [self.moonFour setImage:[UIImage imageNamed:@"ecomments-rating-icon"]];
            [self.moonFive setImage:[UIImage imageNamed:@"ecomments-rating-icon"]];
            break;
        case 1:
            [self.moonOne setImage:[UIImage imageNamed:@"ecomments-rating"]];
            [self.moonTwo setImage:[UIImage imageNamed:@"ecomments-rating-icon"]];
            [self.moonThree setImage:[UIImage imageNamed:@"ecomments-rating-icon"]];
            [self.moonFour setImage:[UIImage imageNamed:@"ecomments-rating-icon"]];
            [self.moonFive setImage:[UIImage imageNamed:@"ecomments-rating-icon"]];
            break;
        case 2:
            [self.moonOne setImage:[UIImage imageNamed:@"ecomments-rating"]];
            [self.moonTwo setImage:[UIImage imageNamed:@"ecomments-rating"]];
            [self.moonThree setImage:[UIImage imageNamed:@"ecomments-rating-icon"]];
            [self.moonFour setImage:[UIImage imageNamed:@"ecomments-rating-icon"]];
            [self.moonFive setImage:[UIImage imageNamed:@"ecomments-rating-icon"]];
            break;
        case 3:
            [self.moonOne setImage:[UIImage imageNamed:@"ecomments-rating"]];
            [self.moonTwo setImage:[UIImage imageNamed:@"ecomments-rating"]];
            [self.moonThree setImage:[UIImage imageNamed:@"ecomments-rating"]];
            [self.moonFour setImage:[UIImage imageNamed:@"ecomments-rating-icon"]];
            [self.moonFive setImage:[UIImage imageNamed:@"ecomments-rating-icon"]];
            break;
        case 4:
            [self.moonOne setImage:[UIImage imageNamed:@"ecomments-rating"]];
            [self.moonTwo setImage:[UIImage imageNamed:@"ecomments-rating"]];
            [self.moonThree setImage:[UIImage imageNamed:@"ecomments-rating"]];
            [self.moonFour setImage:[UIImage imageNamed:@"ecomments-rating"]];
            [self.moonFive setImage:[UIImage imageNamed:@"ecomments-rating-icon"]];
            break;
        case 5:
            [self.moonOne setImage:[UIImage imageNamed:@"ecomments-rating"]];
            [self.moonTwo setImage:[UIImage imageNamed:@"ecomments-rating"]];
            [self.moonThree setImage:[UIImage imageNamed:@"ecomments-rating"]];
            [self.moonFour setImage:[UIImage imageNamed:@"ecomments-rating"]];
            [self.moonFive setImage:[UIImage imageNamed:@"ecomments-rating"]];
            break;
        default:
            break;
    }
}

- (IBAction)shareAction:(id)sender {
}

- (IBAction)gotoLikeEndrAction:(id)sender {
    [self.likeBtn setSelected:YES];
    self.likeLbl.text=@"1 Likes";
}

- (IBAction)gotoChatAction:(id)sender {

}

- (IBAction)gotoProfileAction:(id)sender {

}
@end
