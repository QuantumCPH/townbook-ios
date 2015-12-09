//
//  LCMainCollectionCell.h
//  SalamCenterApp
//
//  Created by Globit on 10/02/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCMainCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cardImgV;
@property (weak, nonatomic) IBOutlet UILabel *cardNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *cardShopNameLbl;

@end
