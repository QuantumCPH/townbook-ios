//
//  CenterBannerCell.h
//  SalamCenterApp
//
//  Created by Globit on 26/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CenterBannerCellDelegate
-(void)bannerBookmarkButtonPressedWithOption:(BOOL)isBM ANDTag:(NSInteger)tag;
-(void)gotoShopDetailForTag:(NSInteger)tag;
@end
@interface CenterBannerCell : UITableViewCell
{
    BOOL isHearPressed;
}
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;
@property (weak, nonatomic) id <CenterBannerCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *objImgV;
@property (weak, nonatomic) IBOutlet UILabel *objNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *objPlaceLbl;
@property (weak, nonatomic) IBOutlet UILabel *objShopLbl;
@property (weak, nonatomic) IBOutlet UIImageView *dividerImgV;

@property (weak, nonatomic) IBOutlet UITextView *objDetail;
@property (weak, nonatomic) IBOutlet UIButton *heartBtn;
@property (nonatomic) BOOL isForFavourites;
- (IBAction)heartBtnPressed:(id)sender ;
-(void)makeHearPressed:(BOOL)showPressed;
- (IBAction)gotoShopDetailAcion:(id)sender;
@end
