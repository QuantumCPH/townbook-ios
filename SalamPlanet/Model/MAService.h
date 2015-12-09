//
//  MAService.h
//  SalamCenterApp
//
//  Created by Waseem Asif on 28/10/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MAService : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * briefText;
@property (nonatomic, retain) NSString * floor;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * serviceId;
@property (nonatomic, retain) NSString * siteMapURL;

@end
