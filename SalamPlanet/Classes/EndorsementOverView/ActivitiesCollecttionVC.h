//
//  ECollecttionVCViewController.h
//  SalamPlanet
//
//  Created by Globit on 21/10/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityCell.h"
#import "ActionSheetStringPicker.h"

@class MallCenter;

@protocol ActivitiesCollectionVCDelegate
-(void)addTheCategorySubCategorInFavList:(BOOL)isCat ANDName:(NSString *)name;
-(void)endorementIsSelectedForChat:(NSDictionary*)endoreD;
@end

@interface ActivitiesCollecttionVC : UIViewController<ActivityCellDelegate>

@property (weak, nonatomic) id<ActivitiesCollectionVCDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *bgImgV;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellPlaceholder;
@property (strong, nonatomic) IBOutlet UILabel *lblNoNewUpdates;
@property (strong, nonatomic) NSMutableArray *mainArray;
@property (nonatomic)AudianceType audianceSegment;
@property (nonatomic)BOOL isFromChat;
@property (strong ,nonatomic) MallCenter *pageMall;
@property (assign,nonatomic) int pageNumber;
@property (assign,nonatomic) BOOL isLoading;
@property (assign,nonatomic) int totalRecords;
-(void)doActionOnAudienceSegmentChange:(AudianceType)newAudience;

-(id)initWithMall:(MallCenter *)mall ANDAudianceType:(AudianceType)aType;
@end
