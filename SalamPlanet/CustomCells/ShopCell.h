//
//  ShopCell.h
//  SalamCenterApp
//
//  Created by Globit on 29/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Shop;
@class Restaurant;

@protocol ShopCellDelegate

@optional
-(void)shopCellBookmarkButtonPressedWithOption:(BOOL)isBM forShop:(Shop*)shop;
-(void)shopCellBookmarkButtonPressedWithOption:(BOOL)isBM forRestaurant:(Restaurant*)restaurant;

@end

@interface ShopCell : UITableViewCell
{
    BOOL isHearPressed;
}

@property (weak, nonatomic) IBOutlet UIImageView *shopLogoImgV;
@property (weak, nonatomic) id <ShopCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *lblShopName;
@property (weak, nonatomic) IBOutlet UILabel *lblShopFloor;
@property (weak, nonatomic) IBOutlet UILabel *lblShopTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnBookMark;


@property (strong, nonatomic) Shop * shop;
@property (strong, nonatomic) Restaurant * restaurant;
@property (assign, nonatomic) BOOL isForRestuarant;

-(void)makeHeartPressed:(BOOL)isPress;
- (IBAction)btnBookmarkPressed:(id)sender;
@end
