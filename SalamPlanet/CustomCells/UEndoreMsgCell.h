//
//  UEndoreMsgCell.h
//  SalamPlanet
//
//  Created by Globit on 18/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UEndoreMsgCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *eImgV;
@property (weak, nonatomic) IBOutlet UILabel *eNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *eCatSubCatLbl;
@property (weak, nonatomic) IBOutlet UILabel *eQuoteLbl;
@property (weak, nonatomic) IBOutlet UILabel *eUserNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *eCmtLikeCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *eTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *msgTimeLbl;
@property (weak, nonatomic) IBOutlet UIImageView *moonImgOne;
@property (weak, nonatomic) IBOutlet UIImageView *moonImgTwo;
@property (weak, nonatomic) IBOutlet UIImageView *moonImgThree;
@property (weak, nonatomic) IBOutlet UIImageView *moonImgFour;
@property (weak, nonatomic) IBOutlet UIImageView *moonImgFive;

-(void)loadDataToViewWithDict:(NSDictionary *)dict ANDUserDict:(NSDictionary *)userDict;
@end
