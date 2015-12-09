//
//  TGFoursquareLocationDetail.m
//  TGFoursquareLocationDetail-Demo
//
//  Created by Thibault Guégan on 15/12/2013.
//  Copyright (c) 2013 Thibault Guégan. All rights reserved.
//

#import "TGFoursquareLocationDetail.h"

@implementation TGFoursquareLocationDetail
//@synthesize userView;
@synthesize currentPictureIndex;
- (id)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    _defaultimagePagerHeight        = 180.0f;//135.0f
    _parallaxScrollFactor           = 0.6f;
    _headerFade                     = 130.0f;
    self.autoresizesSubviews        = YES;
    self.autoresizingMask           = UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleHeight;
    self.backgroundViewColor        = [UIColor clearColor];
    self.isContainerViewPresented   =NO;
    mainUsersArray=[[NSMutableArray alloc]init];//Saad
    mainPicturesArray=[[NSMutableArray alloc]init];//Saad
    currentPictureIndex=0;//Saad
    appDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
}
- (void)dealloc
{
	[self.tableView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    if (!self.tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds];
        self.tableView.backgroundColor = [UIColor clearColor];
//        self.tableView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:[appDelegate getBackgroundImageName]]];//Saad
        self.tableView.delegate = self.tableViewDelegate;
        self.tableView.dataSource = self.tableViewDataSource;
        self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleHeight;
        
        // Add scroll view KVO
        void *context = (__bridge void *)self;
        [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:context];
        
        [self addSubview:self.tableView];
        
        if([self.delegate respondsToSelector:@selector(locationDetail:tableViewDidLoad:)]){
            [self.delegate locationDetail:self tableViewDidLoad:self.tableView];
        }
        
    }
    
    if (!self.tableView.tableHeaderView) {
        CGRect tableHeaderViewFrame = CGRectMake(0.0, 0.0, self.tableView.frame.size.width, self.defaultimagePagerHeight);
        UIView *tableHeaderView = [[UIView alloc] initWithFrame:tableHeaderViewFrame];
        tableHeaderView.backgroundColor = [UIColor clearColor];
        self.tableView.tableHeaderView = tableHeaderView;
        
        UISwipeGestureRecognizer *swipeGestureRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(catchHeaderGestureRight:)];
        swipeGestureRight.direction = UISwipeGestureRecognizerDirectionRight ;
        swipeGestureRight.cancelsTouchesInView = YES;
        
        UISwipeGestureRecognizer *swipeGestureLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(catchHeaderGestureLeft:)];
        swipeGestureLeft.direction = UISwipeGestureRecognizerDirectionLeft ;
        swipeGestureLeft.cancelsTouchesInView = YES;
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(catchTapEvent:)];
        
        [self.tableView.tableHeaderView  addGestureRecognizer:swipeGestureRight];
        [self.tableView.tableHeaderView  addGestureRecognizer:swipeGestureLeft];
        [self.tableView.tableHeaderView  addGestureRecognizer:tapRecognizer];
    }
    
    if(!self.imagePager){
        self.defaultimagePagerFrame = CGRectMake(0.0f, -self.defaultimagePagerHeight * self.parallaxScrollFactor *2, self.tableView.frame.size.width, self.defaultimagePagerHeight + (self.defaultimagePagerHeight * self.parallaxScrollFactor * 4));

        _imagePager = [[KIImagePager alloc] initWithFrame:self.defaultimagePagerFrame];
        self.imagePager.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        
        self.imagePager.indicatorDisabled = YES;
        
        [self insertSubview:self.imagePager belowSubview:self.tableView];
        
        if([self.delegate respondsToSelector:@selector(locationDetail:imagePagerDidLoad:)]){
            [self.delegate locationDetail:self imagePagerDidLoad:self.imagePager];
        }
        self.imagePager.dataSource=self;//Saad
        self.imagePager.delegate=self;//Saad

    }
    
    // Add the background tableView
    if (!self.backgroundView) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, self.defaultimagePagerHeight,
                                                                self.tableView.frame.size.width,
                                                                self.tableView.frame.size.height - self.defaultimagePagerHeight)];
        view.backgroundColor = self.backgroundViewColor;
        self.backgroundView = view;
		self.backgroundView.userInteractionEnabled=NO;
        [self.tableView insertSubview:self.backgroundView atIndex:0];
    }
    
    //Make a container view for showing the imagePager
    if(!self.imageContainerView){
        
        self.imageContainerView=[[[NSBundle mainBundle]loadNibNamed:@"ImageContainerView" owner:self options:nil]                 firstObject];
        
        UISwipeGestureRecognizer *swipeGestureUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(catchHeaderGestureUp:)];
        swipeGestureUp.direction = UISwipeGestureRecognizerDirectionUp ;
        swipeGestureUp.cancelsTouchesInView = YES;

        [self.imageContainerView addGestureRecognizer:swipeGestureUp];
        
        if (!IS_IPHONE_5) {
            self.imageContainerView.frame=CGRectMake(self.imageContainerView.frame.origin.x, self.imageContainerView.frame.origin.y,self.imageContainerView.frame.size.width,480.0);
        }
        if (!closeButton) {
            closeButton=[[UIButton alloc]initWithFrame:CGRectMake(250, 20, 70, 44)];
            [closeButton setTitle:@"Cancel" forState:UIControlStateNormal];
            closeButton.titleLabel.textColor=[UIColor whiteColor];
            [closeButton addTarget:self action:@selector(removeImageContainerViewAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.imageContainerView addSubview:closeButton];
        }
//        if (!userView) {
//            userView=[[EndrUserView alloc]init];
//            userView.frame=CGRectMake(0, self.imageContainerView.frame.size.height-54, userView.frame.size.width, userView.frame.size.height);
//            if (mainPicturesArray.count) {
//                NSDictionary * dict=[mainUsersArray objectAtIndex:currentPictureIndex];
//                [userView loadViewWith:[dict valueForKey:kTempUserPic] ANDName:[dict valueForKey:kTempUserName] ANDDate:[dict valueForKey:kTempEndrDate]];
//            }
//            userView.delegate=self;
//        }
//        [self.imageContainerView addSubview:userView];
    }
}

-(void)catchHeaderGestureRight:(UISwipeGestureRecognizer*)sender
{
    NSLog(@"header gesture right");
    
    if(self.currentImage > 0){
        self.currentImage --;
        [self.imagePager setCurrentPage:self.currentImage animated:YES];
        
        [self.imagePager.delegate imagePager:self.imagePager didScrollToIndex:self.currentImage];
        [self.imagePager updateCaptionLabelForImageAtIndex:self.currentImage];
    }
}

-(void)catchHeaderGestureLeft:(UISwipeGestureRecognizer*)sender
{    
    NSLog(@"header gesture Left");
    
    if(self.currentImage < [[self.imagePager.dataSource arrayWithImages] count] -1){
        self.currentImage ++;
        [self.imagePager setCurrentPage:self.currentImage animated:YES];
        
        [self.imagePager.delegate imagePager:self.imagePager didScrollToIndex:self.currentImage];
        [self.imagePager updateCaptionLabelForImageAtIndex:self.currentImage];
    }
}

-(void)catchTapEvent:(UITapGestureRecognizer*)sender
{
    NSLog(@"tap gesture");
    
    [self.imagePager.delegate imagePager:self.imagePager didSelectImageAtIndex:self.currentImage];
}

- (void)setTableViewDataSource:(id<UITableViewDataSource>)tableViewDataSource
{
    _tableViewDataSource = tableViewDataSource;
    self.tableView.dataSource = _tableViewDataSource;
    
    if (_tableViewDelegate) {
        [self.tableView reloadData];
    }
}

- (void)setTableViewDelegate:(id<UITableViewDelegate>)tableViewDelegate
{
    _tableViewDelegate = tableViewDelegate;
    self.tableView.delegate = _tableViewDelegate;
    
    if (_tableViewDataSource) {
        [self.tableView reloadData];
    }
}

- (void)setHeaderView:(UIView *)headerView
{
    _headerView = headerView;
    
    if([self.delegate respondsToSelector:@selector(locationDetail:headerViewDidLoad:)]){
        [self.delegate locationDetail:self headerViewDidLoad:self.headerView];
    }
}

#pragma mark - KVO Methods

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
	// Make sure we are observing this value.
	if (context != (__bridge void *)self) {
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
		return;
	}
    
    if ((object == self.tableView) &&
        ([keyPath isEqualToString:@"contentOffset"] == YES)) {
        [self scrollViewDidScrollWithOffset:self.tableView.contentOffset.y];
        return;
    }
}

- (void)scrollViewDidScrollWithOffset:(CGFloat)scrollOffset
{
    if (_isContainerViewPresented) {
        return;
    }
    CGFloat junkViewFrameYAdjustment = 0.0;
    
    // If the user is pulling down
    if (scrollOffset < 0) {
        junkViewFrameYAdjustment = self.defaultimagePagerFrame.origin.y - (scrollOffset * self.parallaxScrollFactor);

        if(scrollOffset<-85 && !_isContainerViewPresented){//Saad  it was 105
            [self showTheimagePagerOnSeparateView];
            return;
        }
    }
    
    // If the user is scrolling normally,
    else {
        junkViewFrameYAdjustment = self.defaultimagePagerFrame.origin.y - (scrollOffset * self.parallaxScrollFactor);
        
        // Don't move the map way off-screen
        if (junkViewFrameYAdjustment <= -(self.defaultimagePagerFrame.size.height)) {
            junkViewFrameYAdjustment = -(self.defaultimagePagerFrame.size.height);
        }
    }
    
    //NSLog(@"scrollOffset: %f",scrollOffset);
    
    if(scrollOffset > _headerFade && _headerView.alpha == 0.0){ //make the header appear
        _headerView.alpha = 0;
        _headerView.hidden = NO;
        [self.delegate topViewHasBeenAppearDisappear:YES];
        [UIView animateWithDuration:0.3 animations:^{
            _headerView.alpha = 1;
        }];
    }
    else if(scrollOffset < _headerFade && _headerView.alpha == 1.0){ //make the header disappear
        [UIView animateWithDuration:0.3 animations:^{
            _headerView.alpha = 0;
        } completion: ^(BOOL finished) {
            _headerView.hidden = YES;
        }];
        [self.delegate topViewHasBeenAppearDisappear:NO];
    }
    
    if (junkViewFrameYAdjustment) {
        CGRect newJunkViewFrame = self.imagePager.frame;
        newJunkViewFrame.origin.y = junkViewFrameYAdjustment;
        self.imagePager.frame = newJunkViewFrame;
    }
}
#pragma mark - KIImagePager DataSource
- (NSArray *) arrayWithImages
{
    return mainPicturesArray;
}

- (UIViewContentMode) contentModeForImage:(NSUInteger)image
{
    return UIViewContentModeScaleAspectFit;//UIViewContentModeScaleAspectFit
}

- (NSString *) captionForImageAtIndex:(NSUInteger)index
{
    return nil;
}

#pragma mark - KIImagePager Delegate
- (void) imagePager:(KIImagePager *)imagePager didScrollToIndex:(NSUInteger)index
{
    NSLog(@"%s %lu", __PRETTY_FUNCTION__, (unsigned long)index);
    currentPictureIndex=index;
//    NSDictionary * dict=[mainUsersArray objectAtIndex:currentPictureIndex];
//    [userView loadViewWith:[dict valueForKey:kTempUserPic] ANDName:[dict valueForKey:kTempUserName] ANDDate:[dict valueForKey:kTempEndrDate]];
}

- (void) imagePager:(KIImagePager *)imagePager didSelectImageAtIndex:(NSUInteger)index
{
    NSLog(@"%s %lu", __PRETTY_FUNCTION__, (unsigned long)index);
}
#pragma mark:EndrUserViewDelegate
-(void)goToUserProfileViewPressed{
    [self.delegate gotoUserProfileViewForUser];
}
-(void)removeThePictureView{
    [self removeImageContainerViewAction:nil];
}
#pragma mark:Methods By Saad
-(void)loadDataWithUserArray:(NSArray *)userArray ANDPicturesArray:(NSArray *)picArray{
    [mainUsersArray removeAllObjects];
    [mainPicturesArray removeAllObjects];
    for (id obj in userArray) {
        [mainUsersArray addObject:obj];
    }
    for (id obj in picArray) {
        [mainPicturesArray addObject:obj];
    }
}
-(void)removeImageContainerViewAction:(id)sender{
    self.imagePager.avoidRefresh=YES;
    [self.imagePager removeFromSuperview];
    [self.imageContainerView removeFromSuperview];
    
    [self.imagePager changeTheContentModeOfImagesInScrollViewWithOption:UIViewContentModeScaleAspectFit];//Content Mode Setting
    self.imagePager.frame=self.defaultimagePagerFrame;
    [self insertSubview:self.imagePager belowSubview:self.tableView];
    [self.headerView setHidden:NO];
    _isContainerViewPresented=NO;
    [self.delegate hideShowTheTitleView:YES];
}
-(void)showTheimagePagerOnSeparateView{
    self.imagePager.avoidRefresh=YES;
    [self.imagePager removeFromSuperview];

    [self.imagePager changeTheContentModeOfImagesInScrollViewWithOption:UIViewContentModeScaleAspectFit];//Content Mode Setting
    self.imagePager.frame=CGRectMake(0, 0, self.imageContainerView.frame.size.width, self.imageContainerView.frame.size.height);
    
    [self.imageContainerView addSubview:self.imagePager];
    [self addSubview:self.imageContainerView];
    
    [self.imageContainerView bringSubviewToFront:closeButton];
    
    [self.headerView setHidden:YES];
    _isContainerViewPresented=YES;
    [self.delegate hideShowTheTitleView:NO];
}
-(void)catchHeaderGestureUp:(UISwipeGestureRecognizer*)sender
{
    NSLog(@"header gesture Up");
    
    if (_isContainerViewPresented) {
        [self removeImageContainerViewAction:nil];
    }
}
@end
