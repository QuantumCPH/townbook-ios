//
//  SCenterCell.h
//  SalamCenterApp
//
//  Created by Globit on 26/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SCenterCellDelegate
-(void)centerIsSelectedButtonPressedWithOption:(BOOL)isBM ANDTag:(NSInteger)tag;
@end
@interface SCenterCell : UITableViewCell
{
    BOOL isHearPressed;
}
@property (weak, nonatomic) id <SCenterCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *centerImgV;
@property (weak, nonatomic) IBOutlet UILabel *centerNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *placeNameLbl;

@property (weak, nonatomic) IBOutlet UILabel *centerCityLbl;

@property (weak, nonatomic) IBOutlet UIButton *heartBtn;
@property (strong,nonatomic) UIColor * pressedColour;

- (IBAction)heartBtnPressed:(id)sender ;
-(void)makeHearPressed:(BOOL)showPressed;
@end
