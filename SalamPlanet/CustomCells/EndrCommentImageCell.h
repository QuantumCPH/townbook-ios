//
//  EndrCommentImageCell.h
//  SalamPlanet
//
//  Created by Globit on 13/10/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EndorsementComment.h"

@interface EndrCommentImageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userPicImgView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLbl;
@property (weak, nonatomic) IBOutlet UIImageView *sharedImgView;


-(void)loadEndrCommentData:(EndorsementComment*)endrCmt;

@end
