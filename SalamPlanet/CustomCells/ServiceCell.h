//
//  ServiceCell.h
//  SalamCenterApp
//
//  Created by Globit on 29/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAService.h"

@interface ServiceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *shopLogoImgV;
@property (weak, nonatomic) IBOutlet UILabel *lblShopName;
@property (weak, nonatomic) IBOutlet UILabel *lblShopFloor;
@property (weak, nonatomic) IBOutlet UITextView *briefTextLbl;

@property (weak, nonatomic) IBOutlet UIImageView *imgArrow;
@property (strong, nonatomic) MAService *service;

@end
