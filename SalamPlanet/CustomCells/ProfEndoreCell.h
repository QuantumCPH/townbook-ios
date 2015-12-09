//
//  ProfEndoreCell.h
//  SalamPlanet
//
//  Created by Globit on 24/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfEndoreCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *endrImageView;
@property (weak, nonatomic) IBOutlet UILabel *endrNameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *moonImgOne;
@property (weak, nonatomic) IBOutlet UIImageView *moonImgTwo;
@property (weak, nonatomic) IBOutlet UIImageView *moonImgThree;
@property (weak, nonatomic) IBOutlet UIImageView *moonImgFour;
@property (weak, nonatomic) IBOutlet UIImageView *moonImgFive;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;

-(void)setEndoreRatingWith:(NSInteger)rating;
@end
