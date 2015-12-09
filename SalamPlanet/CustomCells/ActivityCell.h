//
//  ActivityCell.h
//  SalamCenterApp
//
//  Created by Waseem Asif on 17/11/2015.
//  Copyright © 2015 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ActivityCellDelegate

- (void)bannerBookmarkButtonPressedWithOption:(BOOL)isBM ANDTag:(NSInteger)tag;

@end

@interface ActivityCell : UITableViewCell
{
    BOOL isHearPressed;
}
@property (weak, nonatomic) IBOutlet UIImageView *offerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *entityPlaceLbl;
@property (weak, nonatomic) IBOutlet UILabel *timingLbl;
@property (weak, nonatomic) IBOutlet UILabel *briefTxtLbl;
@property (weak, nonatomic) IBOutlet UIImageView *entityLogoImgView;

@property (weak, nonatomic) id <ActivityCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *heartBtn;
@property (nonatomic) BOOL isForFavourites;

-(void)makeHearPressed:(BOOL)showPressed;
- (IBAction)heartBtnPressed:(id)sender ;
@end
