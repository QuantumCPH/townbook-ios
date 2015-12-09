//
//  ServiceObject.h
//  SalamCenterApp
//
//  Created by Globit on 30/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceObject : NSObject
@property (nonatomic) NSInteger serviceID;
@property (nonatomic, strong) NSString * serviceName;
@property (nonatomic, strong) NSString * serviceFloor;
@property (nonatomic, strong) NSString * serviceImgName;
@property (nonatomic, strong) NSString * serviceDescription;
@property (nonatomic, strong) NSString * serviceTelNumber;
@property (nonatomic, strong) NSString * serviceAddress;
@property (nonatomic, strong) NSString * serviceCenterName;

-(ServiceObject*) initWithID:(NSInteger)ID;
@end
