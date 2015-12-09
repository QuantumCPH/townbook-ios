//
//  Activity.h
//  SalamCenterApp
//
//  Created by Waseem Asif on 25/11/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BannerImage, Entity, MACategory, MallCenter, User;

@interface Activity : NSManagedObject

@property (nonatomic, retain) NSString * activityId;
@property (nonatomic, retain) NSString * activityType;
@property (nonatomic, retain) NSString * briefText;
@property (nonatomic, retain) NSString * categoryName;
@property (nonatomic, retain) NSString * detailText;
@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSString * endTime;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSString * startTime;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *banners;
@property (nonatomic, retain) NSSet *categories;
@property (nonatomic, retain) Entity *entityObject;
@property (nonatomic, retain) MallCenter *mall;
@property (nonatomic, retain) User *user;
@end

@interface Activity (CoreDataGeneratedAccessors)

- (void)addBannersObject:(BannerImage *)value;
- (void)removeBannersObject:(BannerImage *)value;
- (void)addBanners:(NSSet *)values;
- (void)removeBanners:(NSSet *)values;

- (void)addCategoriesObject:(MACategory *)value;
- (void)removeCategoriesObject:(MACategory *)value;
- (void)addCategories:(NSSet *)values;
- (void)removeCategories:(NSSet *)values;

@end
