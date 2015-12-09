//
//  MenuItemViewBar.m
//  SalamPlanet
//
//  Created by Globit on 21/10/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "MenuItemViewBar.h"
#import "MenuItemView.h"

@interface MenuItemViewBar()
@property (strong) NSArray * pageScroller_Views;
@end

@implementation MenuItemViewBar
@synthesize pageScroller_Views;

- (id)init{
    self = [self loadFromNib];
    if (self)
    {
    }
    return self;
}
- (id)initWIthArray:(NSArray *)array{
    self = [self loadFromNib];
    if (self)
    {
        menuFavItemsArray=[[NSMutableArray alloc]initWithArray:array];
        [self makeCustomView];
    }
    return self;
}
- (id)loadFromNib
{
    NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"MenuItemViewBar" owner:nil options:nil];
    return [array objectAtIndex:0];
}
-(void)makeCustomView{
    pageScrollView = [[DMCircularScrollView alloc] initWithFrame:CGRectMake(0,0,320,44)];
    pageScrollView.pageWidth = 80;
    pageScrollView.delegate=self;
    pageScrollView.backgroundColor=[UIColor clearColor];
    pageScroller_Views = [self generateSampleUIViews:menuFavItemsArray.count width:80];
    __weak MenuItemViewBar* weakSelf = self;
    [pageScrollView setPageCount:[pageScroller_Views count]
                       withDataSource:^UIView *(NSUInteger pageIndex) {
                           return [weakSelf.pageScroller_Views objectAtIndex:pageIndex];
                       }];
    [self addSubview:pageScrollView];
}
- (NSMutableArray *) generateSampleUIViews:(NSUInteger) number width:(CGFloat) wd {
    NSMutableArray *views_list = [[NSMutableArray alloc] init];
    
    for (NSUInteger k = 0; k < number; k++) {
        MenuItemView * itemView=[[MenuItemView alloc]initWithItem:[menuFavItemsArray objectAtIndex:k]];
        itemView.tag=k;
        [views_list addObject: itemView];
    }
    return views_list;
}
#pragma maek:DMCircularScrollViewDelegate
-(void)pageHasBeenChange{
    NSLog(@"Current Page %lu",(unsigned long)pageScrollView.currentPageIndex);
    if ([menuFavItemsArray count]>=pageScrollView.currentPageIndex){
        [self.delegate menuItemChangedTo:[menuFavItemsArray objectAtIndex:pageScrollView.currentPageIndex]];
    }
}

@end
