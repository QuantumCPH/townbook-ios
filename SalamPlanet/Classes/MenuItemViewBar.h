//
//  MenuItemViewBar.h
//  SalamPlanet
//
//  Created by Globit on 21/10/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMCircularScrollView.h"

@protocol MenuItemBarDelegate
-(void)menuItemChangedTo:(NSString *)itemSelected;
@end

@interface MenuItemViewBar : UIView<DMCircularScrollViewDelegate>
{
    NSMutableArray * menuFavItemsArray;
    DMCircularScrollView* pageScrollView;
}
@property (weak, nonatomic) id<MenuItemBarDelegate> delegate;
- (id)initWIthArray:(NSArray *)array;
@end
