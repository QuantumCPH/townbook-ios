//
//  ServiceCell.m
//  SalamCenterApp
//
//  Created by Globit on 29/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "ServiceCell.h"
#import "UIImageView+WebCache.h"

@implementation ServiceCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    UIBezierPath *maskPath;
    CGRect imageRect = self.shopLogoImgV.bounds;
    imageRect.size.width+= 50;//50 is for correcting error in iphone 6 and iphone 6+
    maskPath = [UIBezierPath bezierPathWithRoundedRect:imageRect
                                     byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerTopLeft)
                                           cornerRadii:CGSizeMake(3.0, 3.0)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.shopLogoImgV.layer.mask = maskLayer;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setService:(MAService *)service
{
    _service = service;
    [self configureServiceCell];
}
- (void)configureServiceCell
{
    self.lblShopName.text = _service.name;
    self.lblShopFloor.text = _service.floor? _service.floor :@"";
    self.briefTextLbl.text = _service.briefText;
    [self.shopLogoImgV setImageWithURL:[NSURL URLWithString:_service.imageURL] placeholderImage:[UIImage imageNamed:@"place-holder"]];
}
@end
