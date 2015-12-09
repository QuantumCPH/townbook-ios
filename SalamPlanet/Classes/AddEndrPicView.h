//
//  AddEndrPicView.h
//  SalamPlanet
//
//  Created by Globit on 29/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeView.h"

@protocol AddEndPicViewDelegate
-(void)removTheImageAtindex:(int)index;
@end


@interface AddEndrPicView : UIView<SwipeViewDataSource,SwipeViewDelegate>
{
    NSMutableArray * mainArray;
}
@property (weak, nonatomic) id<AddEndPicViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet SwipeView *swipeView;
-(void)reloadMainArrayWithImagesArray:(NSArray *)array;

- (IBAction)removAction:(id)sender;
@end
