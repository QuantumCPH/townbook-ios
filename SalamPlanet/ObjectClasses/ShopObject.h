//
//  ShopObject.h
//  SalamCenterApp
//
//  Created by Globit on 29/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopObject : NSObject
@property (nonatomic) NSInteger shopID;
@property (nonatomic, strong) NSString * shopName;
@property (nonatomic, strong) NSString * shopLogoName;
@property (nonatomic, strong) NSString * shopImgName;
@property (nonatomic, strong) NSString * shopTitle;
@property (nonatomic, strong) NSString * shopDescription;
@property (nonatomic, strong) NSString * shopCenterName;
@property (nonatomic, strong) NSString * shopCategory;
@property (nonatomic, strong) NSString * shopNameFirstAlpha;
@property (nonatomic, strong) NSString * shopFloor;
@property (nonatomic, strong) NSString * isBookmarked;

-(ShopObject*) initWithID:(NSInteger)ID;
-(NSDictionary *)getDictionaryOfObject;
@end
