//
//  BannerImage.h
//  SalamCenterApp
//
//  Created by Waseem Asif on 25/11/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Activity, Entity;

@interface BannerImage : NSManagedObject

@property (nonatomic, retain) NSString * bannerId;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) Entity *bannerEntity;
@property (nonatomic, retain) Activity *unusedActivity;

@end
