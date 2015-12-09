//
//  MainObject.h
//  SalamCenterApp
//
//  Created by Globit on 24/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainObject : NSObject
@property (nonatomic) NSInteger objID;
@property (nonatomic, strong) NSString * objTitle;
@property (nonatomic, strong) NSString * objImgName;
@property (nonatomic, strong) NSString * objHeadline;
@property (nonatomic, strong) NSString * objDetail;
@property (nonatomic, strong) NSString * objPlace;
@property (nonatomic, strong) NSString * objShop;
@property (nonatomic)AudianceType objType;
@property (nonatomic, strong) NSString * isFavourite;
@property (nonatomic, strong) NSString * isBookmarked;
@property (nonatomic, strong) NSString * objCategory;
@property (nonatomic, strong) NSString * objShopLogoImgName;

-(NSDictionary *)getDictionaryOfObject;
-(MainObject*) initWithDictionary:(NSDictionary*)dict;
-(MainObject*) initWithID:(NSInteger)ID;
@end
