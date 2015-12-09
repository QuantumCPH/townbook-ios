//
//  EndrCommentImageCell.m
//  SalamPlanet
//
//  Created by Globit on 13/10/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "EndrCommentImageCell.h"
#import "EndorsementComment.h"

@implementation EndrCommentImageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)loadEndrCommentData:(EndorsementComment*)endrCmt
{
    self.userPicImgView.image=[UIImage imageNamed:endrCmt.commentUser.userPicURL];
    [UtilsFunctions makeUIImageViewRound:self.userPicImgView ANDRadius:self.userPicImgView.frame.size.width/2];
    self.userNameLbl.text=endrCmt.commentUser.userName;
    self.dateTimeLbl.text=(NSString *)endrCmt.commentDate;
    if (endrCmt.imgSharedTemp) {
        self.sharedImgView.image=endrCmt.imgSharedTemp;
    }
    else{
        self.sharedImgView.image=[UIImage imageNamed:endrCmt.imgShared];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
