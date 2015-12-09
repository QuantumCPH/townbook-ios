//
//  InterestCell.h
//  SalamCenterApp
//
//  Created by Globit on 02/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InterestCellDelegate
-(void)interestIsSelectedButtonPressedWithOption:(BOOL)isBM ANDTag:(NSInteger)tag;
@end

@interface InterestCell : UITableViewCell{
       BOOL isHearPressed;
}
@property (weak, nonatomic) id <InterestCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *interNameLbl;
@property (weak, nonatomic) IBOutlet UIButton *heartBtn;

- (IBAction)heartBtnPressed:(id)sender ;
-(void)makeHearPressed:(BOOL)showPressed;
@end
