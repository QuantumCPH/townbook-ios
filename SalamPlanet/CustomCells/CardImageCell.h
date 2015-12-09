//
//  CardImageCell.h
//  SalamCenterApp
//
//  Created by Waseem Asif on 10/11/2015.
//  Copyright © 2015 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardImageCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cardBorderImgView;
@property (weak, nonatomic) IBOutlet UIImageView *cardImgView;
@property (weak, nonatomic) IBOutlet UILabel *sideLbl;


@end
