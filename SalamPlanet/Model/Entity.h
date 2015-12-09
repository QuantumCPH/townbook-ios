//
//  Entity.h
//  SalamCenterApp
//
//  Created by Waseem Asif on 11/11/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Activity, BannerImage, MACategory, Timing;

@interface Entity : NSManagedObject

@property (nonatomic, retain) NSString * aboutText;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * briefText;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * webURL;
@property (nonatomic, retain) NSString * entityId;
@property (nonatomic, retain) NSString * entityType;
@property (nonatomic) BOOL isEntityDetailLoaded;
@property (nonatomic) BOOL mapActive;
@property (nonatomic) double latitude;
@property (nonatomic, retain) NSString * logoURL;
@property (nonatomic) double longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString *siteMapURL;
@property (nonatomic, retain) NSSet *bannerImages;
@property (nonatomic, retain) NSSet *entityActivities;
@property (nonatomic, retain) NSSet *timings;
@property (nonatomic, retain) NSSet *categories;
@end

@interface Entity (CoreDataGeneratedAccessors)

- (void)addBannerImagesObject:(BannerImage *)value;
- (void)removeBannerImagesObject:(BannerImage *)value;
- (void)addBannerImages:(NSSet *)values;
- (void)removeBannerImages:(NSSet *)values;

- (void)addEntityActivitiesObject:(Activity *)value;
- (void)removeEntityActivitiesObject:(Activity *)value;
- (void)addEntityActivities:(NSSet *)values;
- (void)removeEntityActivities:(NSSet *)values;

- (void)addTimingsObject:(Timing *)value;
- (void)removeTimingsObject:(Timing *)value;
- (void)addTimings:(NSSet *)values;
- (void)removeTimings:(NSSet *)values;

- (void)addCategoriesObject:(MACategory *)value;
- (void)removeCategoriesObject:(MACategory *)value;
- (void)addCategories:(NSSet *)values;
- (void)removeCategories:(NSSet *)values;

@end
