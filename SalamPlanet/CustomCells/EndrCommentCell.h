//
//  EndrCommentCell.h
//  SalamPlanet
//
//  Created by Globit on 29/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EndorsementComment.h"
#import "SZTextView.h"

@protocol EndrCommentCellDelegate
-(void)goToUserProfileFromCommentCellAction;
@end

@interface EndrCommentCell : UITableViewCell
@property (weak, nonatomic)id<EndrCommentCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIImageView *userPicImgView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLbl;
@property (weak, nonatomic) IBOutlet SZTextView *cmtTV;
@property (weak, nonatomic) IBOutlet UIImageView *sharedImgView;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLbl;

- (IBAction)likeBtnAction:(id)sender;
- (IBAction)gotoUserProfileBtnAction:(id)sender;

-(void)loadEndrCommentData:(EndorsementComment*)endrCmt;

@end
