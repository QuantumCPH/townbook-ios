//
//  RestaurantObject.h
//  SalamCenterApp
//
//  Created by Globit on 01/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestaurantObject : NSObject

@property (nonatomic) NSInteger restID;
@property (nonatomic, strong) NSString * restName;
@property (nonatomic, strong) NSString * restLogoName;
@property (nonatomic, strong) NSString * restImgName;
@property (nonatomic, strong) NSString * restDescription;
@property (nonatomic, strong) NSString * restCenterName;
@property (nonatomic, strong) NSString * restCategory;
@property (nonatomic, strong) NSString * restNameFirstAlpha;
@property (nonatomic, strong) NSString * restFloor;
@property (nonatomic, strong) NSString * isBookmarked;

-(RestaurantObject*) initWithID:(NSInteger)ID;
-(NSDictionary *)getDictionaryOfObject;
@end
