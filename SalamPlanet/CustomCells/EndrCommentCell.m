//
//  EndrCommentCell.m
//  SalamPlanet
//
//  Created by Globit on 29/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "EndrCommentCell.h"
#import "UtilsFunctions.h"
@implementation EndrCommentCell
@synthesize delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)likeBtnAction:(id)sender {
    [self.likeBtn setSelected:YES];
    self.likeCountLbl.text=@"1 likes";
}

- (IBAction)gotoUserProfileBtnAction:(id)sender {
    [delegate goToUserProfileFromCommentCellAction];
}

-(void)loadEndrCommentData:(EndorsementComment*)endrCmt
{
    self.userPicImgView.image=[UIImage imageNamed:endrCmt.commentUser.userPicURL];
        [UtilsFunctions makeUIImageViewRound:self.userPicImgView ANDRadius:self.userPicImgView.frame.size.width/2];
    self.userNameLbl.text=endrCmt.commentUser.userName;
    self.dateTimeLbl.text=(NSString *)endrCmt.commentDate;
    self.cmtTV.text=endrCmt.commentText;
    CGRect frame=self.cmtTV.frame;
    frame.size=[self calculateSizeForText:endrCmt.commentText];
    self.cmtTV.frame=frame;
    
//    if (endrCmt.imgShared) {
//        self.sharedImgView.frame=CGRectMake(frame.origin.x, frame.origin.y+frame.size.height, self.sharedImgView.frame.size.width, self.sharedImgView.frame.size.height);
//    }
}
-(CGSize)calculateSizeForText:(NSString *)txt{
    
    CGSize maximumLabelSize = CGSizeMake(self.cmtTV.frame.size.width, 180);
    CGSize expectedSectionSize = [txt sizeWithFont:self.cmtTV.font
                                 constrainedToSize:maximumLabelSize
                                     lineBreakMode:NSLineBreakByTruncatingTail];
    expectedSectionSize.height+=20;
    return expectedSectionSize;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
