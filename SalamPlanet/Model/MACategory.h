//
//  MACategory.h
//  SalamCenterApp
//
//  Created by Waseem Asif on 23/11/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Activity, Entity, User;

@interface MACategory : NSManagedObject

@property (nonatomic, retain) NSString * categoryDesciption;
@property (nonatomic, retain) NSString * categoryId;
@property (nonatomic, retain) NSString * categoryText;
@property (nonatomic, retain) NSSet *unusedActivities;
@property (nonatomic, retain) NSSet *unusedEntities;
@property (nonatomic, retain) User *user;
@end

@interface MACategory (CoreDataGeneratedAccessors)

- (void)addUnusedActivitiesObject:(Activity *)value;
- (void)removeUnusedActivitiesObject:(Activity *)value;
- (void)addUnusedActivities:(NSSet *)values;
- (void)removeUnusedActivities:(NSSet *)values;

- (void)addUnusedEntitiesObject:(Entity *)value;
- (void)removeUnusedEntitiesObject:(Entity *)value;
- (void)addUnusedEntities:(NSSet *)values;
- (void)removeUnusedEntities:(NSSet *)values;

@end
