//
//  EndoreMsgCell.h
//  SalamPlanet
//
//  Created by Saad Khan on 19/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EndoreMsgCell : UITableViewCell
{
}
@property (weak, nonatomic) IBOutlet UIImageView *endrImageView;
@property (weak, nonatomic) IBOutlet UILabel *endrNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *endrUserNameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *moonImgOne;
@property (weak, nonatomic) IBOutlet UIImageView *moonImgTwo;
@property (weak, nonatomic) IBOutlet UIImageView *moonImgThree;
@property (weak, nonatomic) IBOutlet UIImageView *moonImgFour;
@property (weak, nonatomic) IBOutlet UIImageView *moonImgFive;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLbl;
@property (weak, nonatomic) IBOutlet UIImageView *uMoonImgOne;
@property (weak, nonatomic) IBOutlet UIImageView *uMoonImgTwo;
@property (weak, nonatomic) IBOutlet UIImageView *uMoonImgThree;
@property (weak, nonatomic) IBOutlet UIImageView *uMoonImgFour;
@property (weak, nonatomic) IBOutlet UIImageView *uMoonImgFive;
@property (weak, nonatomic) IBOutlet UIImageView *userPicImgV;
@property (weak, nonatomic) IBOutlet UITextView *userCommentTV;
@property (weak, nonatomic) IBOutlet UILabel *catSubCatLbl;
@property (weak, nonatomic) IBOutlet UILabel *tagsLbl;


-(void)setEndoreRatingWith:(NSInteger)rating;
-(void)setRatingByUserWith:(NSInteger)rating;
-(void)updateUserDataViewWith:(NSDictionary *)userDict;
@end
