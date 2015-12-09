//
//  EndorsementViewCell.m
//  SalamPlanet
//
//  Created by Globit on 26/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "EndorsementViewCell.h"
#import "UtilsFunctions.h"

@implementation EndorsementViewCell
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

-(void)setFontsOfItemsInView{
    [self.endrUserNameLbl setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:15.0f]];
    [self.dateTimeLabel setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:9.0f]];
    [self.mainCommentTV setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:13.0f]];
    [self.noCommentLbl setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:9.0f]];
    [self.noLikeLbl setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:9.0f]];
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
-(void)makeBtnVieHiddenAndAdjustSize{
    [self.btnOptnView setHidden:YES];
    self.borderBoxImgView.frame=CGRectMake(self.borderBoxImgView.frame.origin.x, self.borderBoxImgView.frame.origin.y, self.borderBoxImgView.frame.size.width, self.borderBoxImgView.frame.size.height-self.btnOptnView.frame.size.height);
}
- (IBAction)gotoCommentsAction:(id)sender {
    [delegate goToSeeComments];
}

- (IBAction)shareAction:(UIButton *)sender {
    if (sender) {
        sender.selected = !sender.selected;
    }
    [delegate shareEndore];
}
-(void)makeShareBtnSelected:(BOOL)makeSelect{
    if (makeSelect) {
        [self.shareBtn setImage:[UIImage imageNamed:@"share-icon"] forState:UIControlStateNormal];
    }
    else{
        [self.shareBtn setImage:[UIImage imageNamed:@"share-icon-press"] forState:UIControlStateNormal];
    }
}
- (IBAction)gotoLikeEndrAction:(id)sender {
    [self.likeBtn setSelected:YES];
    self.likeLbl.text=@"1 Likes";
    [delegate goToLikeEndr];
}

- (IBAction)gotoChatAction:(id)sender {
    [delegate goToChat];
}

- (IBAction)gotoProfileAction:(id)sender {
    [delegate goToUserProfileAction];
}
@end
