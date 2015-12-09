//
//  MallCenter.h
//  SalamCenterApp
//
//  Created by Waseem Asif on 09/12/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Activity, Timing, User;

@interface MallCenter : NSManagedObject

@property (nonatomic, retain) NSString * aboutText;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * briefText;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * corporateColor;
@property (nonatomic, retain) NSString * country;
@property (nonatomic) double currentDistance;
@property (nonatomic, retain) NSString * email;
@property (nonatomic) double latitude;
@property (nonatomic, retain) NSString * logoURL;
@property (nonatomic) double longitude;
@property (nonatomic, retain) NSString * mallPlaceId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * placeName;
@property (nonatomic, retain) NSString * webURL;
@property (nonatomic, retain) NSSet *activities;
@property (nonatomic, retain) NSSet *mallTimings;
@property (nonatomic, retain) User *user;
@end

@interface MallCenter (CoreDataGeneratedAccessors)

- (void)addActivitiesObject:(Activity *)value;
- (void)removeActivitiesObject:(Activity *)value;
- (void)addActivities:(NSSet *)values;
- (void)removeActivities:(NSSet *)values;

- (void)addMallTimingsObject:(Timing *)value;
- (void)removeMallTimingsObject:(Timing *)value;
- (void)addMallTimings:(NSSet *)values;
- (void)removeMallTimings:(NSSet *)values;

@end
