//
//  Timing.h
//  SalamCenterApp
//
//  Created by Waseem Asif on 09/12/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Entity, EntityTiming, MallCenter;

@interface Timing : NSManagedObject

@property (nonatomic, retain) NSDate * closingTime;
@property (nonatomic, retain) NSString * fromDay;
@property (nonatomic) int16_t index;
@property (nonatomic, retain) NSDate * openingTime;
@property (nonatomic, retain) NSString * timingId;
@property (nonatomic, retain) NSString * toDay;
@property (nonatomic, retain) EntityTiming *timingEntity;
@property (nonatomic, retain) Entity *unusedEntity;
@property (nonatomic, retain) MallCenter *unusedMall;

@end
