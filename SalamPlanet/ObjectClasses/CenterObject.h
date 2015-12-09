//
//  CenterObject.h
//  SalamCenterApp
//
//  Created by Globit on 02/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CenterObject : NSObject
@property (nonatomic) NSInteger centerID;
@property (nonatomic, strong) NSString * centerTitle;
@property (nonatomic, strong) NSString * centerImgName;
@property (nonatomic, strong) NSString * centerLogoImgName;
@property (nonatomic, strong) NSString * centerCityName;
@property (nonatomic, strong) NSString * centerLocation;
@property (nonatomic, strong) NSString * isSelected;

-(NSDictionary *)getDictionaryOfObject;
-(CenterObject*) initWithDictionary:(NSDictionary*)dict;
-(CenterObject*) initWithID:(NSInteger)ID;
@end
