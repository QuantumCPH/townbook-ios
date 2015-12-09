//
//  EndorsementViewCell.h
//  SalamPlanet
//
//  Created by Globit on 26/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZTextView.h"
#import "Endorsement.h"

@protocol EndorsementCellDelegate
-(void)goToChat;
-(void)shareEndore;
-(void)goToLikeEndr;
-(void)goToSeeComments;
-(void)goToUserProfileAction;
@end

@interface EndorsementViewCell : UITableViewCell

@property (weak, nonatomic) id<EndorsementCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *endrImgView;
@property (weak, nonatomic) IBOutlet UIImageView *endrUserProfileImgView;
@property (weak, nonatomic) IBOutlet UILabel *endrUserNameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *moonTwo;
@property (weak, nonatomic) IBOutlet UIImageView *moonFive;
@property (weak, nonatomic) IBOutlet UIImageView *moonThree;
@property (weak, nonatomic) IBOutlet UIImageView *moonOne;
@property (weak, nonatomic) IBOutlet UIImageView *moonFour;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalEndrLbl;
@property (weak, nonatomic) IBOutlet UITextView *mainCommentTV;
@property (weak, nonatomic) IBOutlet UIView *btnOptnView;
@property (weak, nonatomic) IBOutlet UIImageView *borderBoxImgView;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UILabel *likeLbl;
@property (weak, nonatomic) IBOutlet UILabel *noCommentLbl;
@property (weak, nonatomic) IBOutlet UILabel *noLikeLbl;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

- (IBAction)gotoCommentsAction:(id)sender;
- (IBAction)shareAction:(id)sender;
- (IBAction)gotoLikeEndrAction:(id)sender;
- (IBAction)gotoChatAction:(id)sender;
- (IBAction)gotoProfileAction:(id)sender;

-(void)loadEndorsementData:(Endorsement *)endore;
-(void)loadDictData:(NSDictionary *)dict ANDUserDict:(NSDictionary *)userDict;
-(void)makeBtnVieHiddenAndAdjustSize;
-(void)setFontsOfItemsInView;
@end
