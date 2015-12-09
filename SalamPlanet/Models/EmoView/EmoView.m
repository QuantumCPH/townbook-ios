//
//  EmoView.m
//  EmoViewControllerExample
//
//  Created by tian li on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EmoView.h"
#import "Emojis.h"


@interface EmoView() <UIScrollViewDelegate> {}

@end



@implementation EmoView

@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;
@synthesize delegate = _delegate;

- (void) initialize{
     //init your ivars here
    NSArray* emojis = [[[Emojis alloc]init]allEmojis];
    
    UIColor *backgroundColor = [UIColor grayColor];
    UIFont *emojiFont = [UIFont fontWithName:@"Apple Color Emoji" size:27];
    int button_size = 45;
    int page_control_height = 20;
    int button_num_Hor = (int)self.frame.size.width/button_size;
    int button_num_Ver = (int)(self.frame.size.height-page_control_height)/button_size;
    float space_Hor = (self.frame.size.width-button_num_Hor*button_size)/(button_num_Hor+1);
    float space_Ver = (self.frame.size.height-page_control_height-button_num_Ver*button_size)/(button_num_Ver+1);
    int page_sum = ceilf((float)emojis.count/(button_num_Ver*button_num_Hor));
    
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _scrollView.backgroundColor = backgroundColor;
    _scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    _scrollView.clipsToBounds = YES;
    _scrollView.scrollEnabled = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.delaysContentTouches = YES;
    _scrollView.canCancelContentTouches = YES;
    _scrollView.delegate = self;
    [_scrollView setContentSize:CGSizeMake(self.frame.size.width * page_sum,  self.frame.size.height-page_control_height)];
    [self addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height-page_control_height, self.frame.size.width, page_control_height)];
    _pageControl.numberOfPages = page_sum;
    _pageControl.backgroundColor = backgroundColor;
    [self addSubview:_pageControl];
    
    
    int page = 0;
    int col = 0;
    int row = 0;
    for(int i = 0; i<[emojis count]; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTintColor:[UIColor grayColor]];
        [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:[emojis objectAtIndex:i] forState:UIControlStateNormal];
        button.titleLabel.font = emojiFont;
        button.backgroundColor = backgroundColor;
        button.frame = CGRectMake(page*self.frame.size.width+col*(button_size+space_Hor)+space_Hor, row*(button_size+space_Ver)+space_Ver, button_size, button_size);
        [_scrollView addSubview:button];
        col ++;
        if (col == button_num_Hor){
            row ++;
            col = 0;
            if (row == button_num_Ver){
                page ++;
                row = 0;
            }
        }
    }
}

-(void)buttonPress:(id)sender {
    UIButton* button = sender;
    //TODO call delegate outside of this class
    //delegate clickedEmoji:emoji
    [self.delegate buttonPressEmo:button.titleLabel.text];
}

- (id) initWithCoder:(NSCoder *)aCoder{
    if(self = [super initWithCoder:aCoder]){
        [self initialize];
    }
    return self;
}

- (id) initWithFrame:(CGRect)rect{
    if(self = [super initWithFrame:rect]){
        [self initialize];
    }
    return self;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)sv
{
    if ([sv isKindOfClass:[UITableView class]]) {  
        return;
    }
    
    int index = fabs(sv.contentOffset.x) / sv.frame.size.width;
    _pageControl.currentPage = index;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
