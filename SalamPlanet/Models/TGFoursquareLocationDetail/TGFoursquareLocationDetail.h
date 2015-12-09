//
//  TGFoursquareLocationDetail.h
//  TGFoursquareLocationDetail-Demo
//
//  Created by Thibault Guégan on 15/12/2013.
//  Copyright (c) 2013 Thibault Guégan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KIImagePager.h"
#import "EndrUserView.h"
#import "AppDelegate.h"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@protocol TGFoursquareLocationDetailDelegate;

@interface TGFoursquareLocationDetail : UIView <UIScrollViewDelegate,KIImagePagerDelegate, KIImagePagerDataSource,EndrUserViewDelegate>
{
    NSMutableArray * mainUsersArray;//Saad
    NSMutableArray * mainPicturesArray;//Saad
    AppDelegate * appDelegate;//Saad
    UIButton * closeButton;
}
@property (nonatomic) CGFloat defaultimagePagerHeight;
/**
 How fast is the table view scrolling with the image picker
*/
@property (nonatomic) CGFloat parallaxScrollFactor;

@property (nonatomic) CGFloat headerFade;

@property (nonatomic, strong) KIImagePager *imagePager;

@property (nonatomic, strong) UIView *imageContainerView;//Saad
//@property (nonatomic, strong) EndrUserView * userView;//Saad
@property (nonatomic)NSInteger currentPictureIndex;

@property (nonatomic) BOOL isContainerViewPresented;

@property (nonatomic) int nbImages;

@property (nonatomic) int currentImage;

@property (nonatomic) CGRect defaultimagePagerFrame;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) UIColor *backgroundViewColor;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, weak) id<UITableViewDataSource> tableViewDataSource;

@property (nonatomic, weak) id<UITableViewDelegate> tableViewDelegate;

@property (nonatomic, weak) id<TGFoursquareLocationDetailDelegate> delegate;

-(void)loadDataWithUserArray:(NSArray *)userArray ANDPicturesArray:(NSArray *)picArray;//Saad

@end

@protocol TGFoursquareLocationDetailDelegate <NSObject>

@optional

- (void)locationDetail:(TGFoursquareLocationDetail *)locationDetail
       imagePagerDidLoad:(KIImagePager *)imagePager;

- (void)locationDetail:(TGFoursquareLocationDetail *)locationDetail
      tableViewDidLoad:(UITableView *)tableView;

- (void)locationDetail:(TGFoursquareLocationDetail *)locationDetail
      headerViewDidLoad:(UIView *)headerView;

- (void)hideShowTheTitleView:(BOOL)show;//By Saad

- (void)topViewHasBeenAppearDisappear:(BOOL)appear;

- (void)gotoUserProfileViewForUser;
@end
