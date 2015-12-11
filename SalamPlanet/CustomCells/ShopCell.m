//
//  ShopCell.m
//  SalamCenterApp
//
//  Created by Globit on 29/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "ShopCell.h"
#import "Restaurant.h"
#import "Shop.h"
#import "User.h"
#import "DataManager.h"
#import "UIImageView+WebCache.h"

@implementation ShopCell

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
- (void)setShop:(Shop *)shop
{
    _shop = shop;
    [self configureCell];
    
}
- (void)configureCell
{
    [self.shopLogoImgV setImageWithURL:[NSURL URLWithString:_shop.logoURL] placeholderImage:[UIImage imageNamed:@"place-holder"]];
    self.lblShopName.text = _shop.name;
    //self.lblShopFloor.text = _shop.floor;
    self.lblShopTitle.text = _shop.briefText;
    User * user = [[DataManager sharedInstance] currentUser];
    if ([user.favouriteShops containsObject:self.shop])
        [self makeHeartPressed:YES];
    else
        [self makeHeartPressed:NO];
}
- (void)setRestaurant:(Restaurant *)restaurant
{
    _restaurant = restaurant;
    [self configureCellForRestaurant];
}
- (void)configureCellForRestaurant
{
    self.isForRestuarant = YES;
    [self.shopLogoImgV setImageWithURL:[NSURL URLWithString:_restaurant.logoURL] placeholderImage:[UIImage imageNamed:@"place-holder"]];
    self.lblShopName.text = _restaurant.name;
    //self.lblShopFloor.text = _restaurant.floor;
    self.lblShopTitle.text = _restaurant.briefText;
    User * user = [[DataManager sharedInstance] currentUser];
    if ([user.favouriteRestaurants containsObject:self.restaurant])
        [self makeHeartPressed:YES];
    else
        [self makeHeartPressed:NO];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)makeHeartPressed:(BOOL)isPress{
    [self.btnBookMark setSelected:isPress];
}
- (IBAction)btnBookmarkPressed:(UIButton*)sender {
    [self.btnBookMark setSelected:!self.btnBookMark.selected];
    if (isHearPressed) {
        //[self.btnBookMark setImage:[UIImage imageNamed:@"heart_un"] forState:UIControlStateNormal];
        isHearPressed = NO;
        if (_isForRestuarant)
            [self.delegate shopCellBookmarkButtonPressedWithOption:isHearPressed forRestaurant:self.restaurant];
        else
            [self.delegate shopCellBookmarkButtonPressedWithOption:isHearPressed forShop:self.shop];
    }
    else{
        //[self.btnBookMark setImage:[UIImage imageNamed:@"heart"] forState:UIControlStateNormal];
        isHearPressed = YES;
        if (_isForRestuarant)
            [self.delegate shopCellBookmarkButtonPressedWithOption:isHearPressed forRestaurant:self.restaurant];
        else
            [self.delegate shopCellBookmarkButtonPressedWithOption:isHearPressed forShop:self.shop];
    }
}
@end
