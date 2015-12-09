//
//  ProfDetailCell.h
//  SalamPlanet
//
//  Created by Globit on 24/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProfDetailCellDelegate
-(void)shareTheAppOnSocialMediumWithOption:(SocialMedium)medium;
@end

@interface ProfDetailCell : UITableViewCell
@property (weak, nonatomic) id <ProfDetailCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *bdayLbl;
@property (weak, nonatomic) IBOutlet UILabel *lblGender;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblUniversity;
@property (weak, nonatomic) IBOutlet UIView *viewShare;
@property (weak, nonatomic) IBOutlet UIImageView *bottomSeparator;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleBirthday;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleGender;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleLocation;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleEducation;
@property (strong, nonatomic) IBOutlet UILabel *lblTellFriendsAboutApp;

- (IBAction)fbBtnAction:(id)sender;
- (IBAction)twBtnAction:(id)sender;
- (IBAction)inBtnAction:(id)sender;
- (IBAction)gPlesBtnAction:(id)sender;

-(void)setTheViewForOtherUserDetail;
@end
