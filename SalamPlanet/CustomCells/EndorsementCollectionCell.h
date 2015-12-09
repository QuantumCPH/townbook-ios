//
//  EndorsementCollectionCell.h
//  SalamPlanet
//
//  Created by Saad Khan on 19/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol EndorsementCollectionCellDelegate
-(void)favouriteButtonPressedWithOption:(BOOL)isFav ANDTag:(NSInteger)tag;
@end

@interface EndorsementCollectionCell : UICollectionViewCell
{
    BOOL isStarPressed;
}
@property (weak, nonatomic) id<EndorsementCollectionCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *endrImageView;
@property (weak, nonatomic) IBOutlet UILabel *endrNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *endrUserNameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *moonImgOne;
@property (weak, nonatomic) IBOutlet UIImageView *moonImgTwo;
@property (weak, nonatomic) IBOutlet UIImageView *moonImgThree;
@property (weak, nonatomic) IBOutlet UIImageView *moonImgFour;
@property (weak, nonatomic) IBOutlet UIImageView *moonImgFive;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLbl;
@property (weak, nonatomic) IBOutlet UIButton *starBtn;
- (IBAction)starBtnPressed:(id)sender;
-(void)makeStarPressed:(BOOL)showPressed;

@end
