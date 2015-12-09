//
//  ShopCell.h
//  SalamCenterApp
//
//  Created by Globit on 29/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RewardsTransCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblTransName;
@property (strong, nonatomic) IBOutlet UIImageView *transImgV;
@property (strong, nonatomic) IBOutlet UILabel *lblTransPoints;
@property (strong, nonatomic) IBOutlet UILabel *lblTransTime;
@property (strong, nonatomic) IBOutlet UILabel *lblTransShop;


@end
