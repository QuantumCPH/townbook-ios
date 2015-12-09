//
//  DemoViewController.m
//  MFSideMenuDemo
//
//  Created by Michael Frederick on 3/19/12.
//

#import "DemoViewController.h"
#import "MFSideMenu.h"

@implementation DemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _defaultimagePagerHeight        = 180.0f;
        _parallaxScrollFactor           = 0.6f;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if(!self.title) self.title = @"Demo!";
    
    // Add scroll view KVO
    void *context = (__bridge void *)self;
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:context];
    
    imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0.0f, -self.defaultimagePagerHeight * self.parallaxScrollFactor *2, self.tableView.frame.size.width, self.defaultimagePagerHeight + (self.defaultimagePagerHeight * self.parallaxScrollFactor * 4))];
    imgView.image=[UIImage imageNamed:@"background"];
    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view insertSubview:imgView belowSubview:self.tableView];
    
    self.defaultimagePagerFrame = CGRectMake(0.0f, -self.defaultimagePagerHeight * self.parallaxScrollFactor *2, self.tableView.frame.size.width, self.defaultimagePagerHeight + (self.defaultimagePagerHeight * self.parallaxScrollFactor * 4));
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;   
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
        [self scrollViewDidScrollWithOffset:self.tableView.frame.origin.y];
        return;
    }
}

- (void)scrollViewDidScrollWithOffset:(CGFloat)scrollOffset
{

    CGFloat junkViewFrameYAdjustment = 0.0;
    
    // If the user is pulling down
    if (scrollOffset < 0) {
        junkViewFrameYAdjustment = self.defaultimagePagerFrame.origin.y - (scrollOffset * self.parallaxScrollFactor);
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
    
    
    if (junkViewFrameYAdjustment) {
        CGRect newJunkViewFrame = imgView.frame;
        newJunkViewFrame.origin.y = junkViewFrameYAdjustment;
        imgView.frame = newJunkViewFrame;
    }
}


@end
