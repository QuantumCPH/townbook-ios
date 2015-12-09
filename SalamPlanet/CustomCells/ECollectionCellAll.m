//
//  ECollectionCellAll.m
//  SalamPlanet
//
//  Created by Saad Khan on 19/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "ECollectionCellAll.h"

@implementation ECollectionCellAll
@synthesize category;
@synthesize subCategory;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        isStarPressed=YES;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)makeStarPressed:(BOOL)showPressed{
    isStarPressed=showPressed;
    if(isStarPressed)
    {
        [self.starBtn setImage:[UIImage imageNamed:@"star-thumb"] forState:UIControlStateNormal];
    }
    else{
        [self.starBtn setImage:[UIImage imageNamed:@"star-thumb-pressed"] forState:UIControlStateNormal];        
    }
}
-(void)makeBookmarkedPressed:(BOOL)bookmarkPressed{
    isBookmarked=bookmarkPressed;
    if(isBookmarked)
    {
        [self.bookMarkBtn setImage:[UIImage imageNamed:@"bookmark-checked"] forState:UIControlStateNormal];
    }
    else{
        [self.bookMarkBtn setImage:[UIImage imageNamed:@"bookmark-uncheck"] forState:UIControlStateNormal];
    }
}

- (IBAction)bookMarkBtnPressed:(id)sender {
    if (isBookmarked) {
        [self.bookMarkBtn setImage:[UIImage imageNamed:@"bookmark-uncheck"] forState:UIControlStateNormal];
        isBookmarked=NO;
    }
    else{
        [self.bookMarkBtn setImage:[UIImage imageNamed:@"bookmark-checked"] forState:UIControlStateNormal];
        isBookmarked=YES;
    }
    [self.delegate eCollAllBookmarkButtonPressedWithOption:isBookmarked ANDTag:self.tag];
}

- (IBAction)starBtnPressed:(id)sender {
    if (isStarPressed) {
//        [self.starBtn setImage:[UIImage imageNamed:@"star-thumb-pressed"] forState:UIControlStateNormal];
//        isStarPressed=NO;
//        [self.delegate eCollAllfavouriteButtonPressedWithOption:isStarPressed ANDTag:self.tag ANDSelectedItem:nil ANDIsCat:NO];
    }
    else{
        [self.starBtn setImage:[UIImage imageNamed:@"star-thumb"] forState:UIControlStateNormal];
        isStarPressed=YES;
        [self showOptionToSelectCatVSSubCat];
    }
}
-(void)showOptionToSelectCatVSSubCat{
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        [self optionSelect:selectedIndex];
    };
    ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
        NSLog(@"Block Picker Canceled");
    };
    [ActionSheetStringPicker showPickerWithTitle:@"Add to favourite" rows:[NSArray arrayWithObjects:category,subCategory, nil] initialSelection:0 doneBlock:done cancelBlock:cancel origin:self];
    
}
-(void)optionSelect:(NSInteger)index{
    NSLog(@"%li",(long)index);
    if (index==0) {
        [self.delegate eCollAllfavouriteButtonPressedWithOption:isStarPressed ANDTag:self.tag ANDSelectedItem:category ANDIsCat:YES];
    }
    else{
        [self.delegate eCollAllfavouriteButtonPressedWithOption:isStarPressed ANDTag:self.tag ANDSelectedItem:subCategory ANDIsCat:NO];
    }
}
- (void) reLayoutView:(UIImage *)image
{
    float scalingFactor;
    float imgWidth = image.size.width;
    float imgHeight = image.size.height;
    float viewWidth = self.endrImageView.frame.size.width;
    float viewHeight = self.endrImageView.frame.size.height;
    
    float widthRatio = imgWidth / viewWidth;
    float heightRatio = imgHeight / viewHeight;
    scalingFactor = widthRatio > heightRatio ? widthRatio : heightRatio;
    
    self.endrImageView.bounds = CGRectMake(0, 0, imgWidth / scalingFactor, imgHeight/scalingFactor);
    self.endrImageView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    
    self.endrImageView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.endrImageView.layer.shadowOffset = CGSizeMake(3, 3);
    self.endrImageView.layer.shadowOpacity = 0.6;
    self.endrImageView.layer.shadowRadius = 1.0;
}
@end
