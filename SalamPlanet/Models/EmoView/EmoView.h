//
//  EmoView.h
//  EmoViewControllerExample
//
//  Created by tian li on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol  EmoViewDelegate;


@interface EmoView : UIView

@property(retain, nonatomic) UIScrollView *scrollView;
@property(retain, nonatomic) UIPageControl *pageControl;

@property(retain, nonatomic) id <EmoViewDelegate> delegate;

@end 


@protocol EmoViewDelegate

- (void) buttonPressEmo: (NSString *) button;

@end
