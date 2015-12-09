//
//  EntityTiming.h
//  SalamCenterApp
//
//  Created by Waseem Asif on 11/11/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Timing;

@interface EntityTiming : NSManagedObject

@property (nonatomic, retain) NSString * entityId;
@property (nonatomic, retain) NSString * entityType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *timings;
@end

@interface EntityTiming (CoreDataGeneratedAccessors)

- (void)addTimingsObject:(Timing *)value;
- (void)removeTimingsObject:(Timing *)value;
- (void)addTimings:(NSSet *)values;
- (void)removeTimings:(NSSet *)values;

@end
