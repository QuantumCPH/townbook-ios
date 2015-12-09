//
//  AddEndrPicView.m
//  SalamPlanet
//
//  Created by Globit on 29/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "AddEndrPicView.h"

@implementation AddEndrPicView
@synthesize delegate;
- (id)init{
    self = [self loadFromNib];
    if (self)
    {
        mainArray=[[NSMutableArray alloc]init];
        self.swipeView.alignment = SwipeViewAlignmentCenter;
        self.swipeView.pagingEnabled = YES;
        self.swipeView.itemsPerPage = 3;
        self.swipeView.truncateFinalPage = YES;

    }
    return self;
    
}

- (id)loadFromNib
{
    NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"AddEndrPicView" owner:nil options:nil];
    return [array objectAtIndex:0];
}
-(void)reloadMainArrayWithImagesArray:(NSArray *)array{
    [mainArray removeAllObjects];
    for (id obj in array) {
        [mainArray addObject:obj];
    }
    [self.swipeView reloadData];
    [self.swipeView scrollToPage:[mainArray count]/3 duration:0.0001];
}
#pragma mark:SlideView Deleagte and Datasource

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    //generate 100 item views
    //normally we'd use a backing array
    //as shown in the basic iOS example
    //but for this example we haven't bothered
    return [mainArray count];
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (!view)
    {
        //load new item view instance from nib
        //control events are bound to view controller in nib file
        //note that it is only safe to use the reusingView if we return the same nib for each
        //item view, if different items have different contents, ignore the reusingView value
        view = [[NSBundle mainBundle] loadNibNamed:@"EndrPicView" owner:self options:nil][0];
    }
    //Add an Imageview
    UIImage * img=[mainArray objectAtIndex:index];
    UIImageView * imgView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 100, 100)];
    [imgView setImage:img];
    [view addSubview:imgView];
    imgView.contentMode=UIViewContentModeScaleAspectFit;
    imgView.backgroundColor=[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1.0];
    
    //Add an Button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(removAction:)
     forControlEvents:UIControlEventTouchUpInside];
//    [button setTitle:@"Remove" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"remove"] forState:UIControlStateNormal];
    button.frame = CGRectMake(81,-7,32,32);
    [button setTintColor:[UIColor redColor]];//[UIColor colorWithRed:73.0/255.0 green:189.0/255.0 blue:143.0/255.0 alpha:1]];
    [view addSubview:button];
    
    return view;
}

- (IBAction)removAction:(id)sender {
    NSLog(@"%ld",(long)[self.swipeView indexOfItemViewOrSubview:sender]);
    int index=[self.swipeView indexOfItemViewOrSubview:sender];
    [delegate removTheImageAtindex:index];
    if(index<[mainArray count]){
        [mainArray removeObjectAtIndex:index];
    }
    [self.swipeView reloadData];
}
@end
