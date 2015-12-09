//
//  ECollectionCellAll.h
//  SalamPlanet
//
//  Created by Saad Khan on 19/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionSheetStringPicker.h"

@protocol ECollectionCellAllDelegate
-(void)eCollAllfavouriteButtonPressedWithOption:(BOOL)isFav ANDTag:(NSInteger)tag ANDSelectedItem:(NSString *)itemCatSubCat ANDIsCat:(BOOL)isCat;
-(void)eCollAllBookmarkButtonPressedWithOption:(BOOL)isBookmark ANDTag:(NSInteger)tag;
@end

@interface ECollectionCellAll : UICollectionViewCell
{
    BOOL isStarPressed;
    BOOL isBookmarked;
}
@property (weak, nonatomic) id<ECollectionCellAllDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *endrImageView;
@property (weak, nonatomic) IBOutlet UILabel *endrNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *endrUserNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *quoteLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UIImageView *moonImgOne;
@property (weak, nonatomic) IBOutlet UIImageView *moonImgTwo;
@property (weak, nonatomic) IBOutlet UIImageView *moonImgThree;
@property (weak, nonatomic) IBOutlet UIImageView *moonImgFour;
@property (weak, nonatomic) IBOutlet UIImageView *moonImgFive;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLbl;
@property (weak, nonatomic) IBOutlet UIButton *starBtn;
@property (weak, nonatomic) IBOutlet UILabel *totalECountLbl;
@property (weak, nonatomic) IBOutlet UILabel *catLbl;
@property (weak, nonatomic) IBOutlet UIButton *bookMarkBtn;

@property (strong,nonatomic)NSString * category;
@property (strong,nonatomic)NSString * subCategory;

- (IBAction)bookMarkBtnPressed:(id)sender;
- (IBAction)starBtnPressed:(id)sender;
-(void)makeStarPressed:(BOOL)showPressed;
-(void)makeBookmarkedPressed:(BOOL)bookmarkPressed;
- (void) reLayoutView:(UIImage *)image;
@end
