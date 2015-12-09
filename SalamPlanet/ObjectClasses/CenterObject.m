//
//  CenterObject.m
//  SalamCenterApp
//
//  Created by Globit on 02/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "CenterObject.h"

@implementation CenterObject
@synthesize centerCityName;
@synthesize centerID;
@synthesize centerImgName;
@synthesize centerLocation;
@synthesize centerTitle;
@synthesize isSelected;
@synthesize centerLogoImgName;
-(CenterObject*) initWithID:(NSInteger)ID
{
    self = [super init];
    if(self)
    {
        switch (ID) {
            case 0:
                centerID=ID;
                centerImgName=[NSString stringWithFormat:@"imgO%li",(long)ID+1];
                centerTitle=kLyngbyStorcenter;
                centerLocation=@"";
                centerLogoImgName=@"cLogo3";
                centerCityName=@"Copenhagen";
                isSelected=@"No";
                break;
            case 1:
                centerID=ID;
                centerImgName=[NSString stringWithFormat:@"imgO%li",(long)ID+1];
                centerTitle=kRCentrum;
                centerLocation=@"";
                centerLogoImgName=@"cLogo2";
                centerCityName=@"Copenhagen";
                isSelected=@"No";
                break;
            case 2:
                centerID=ID;
                centerImgName=[NSString stringWithFormat:@"imgO%li",(long)ID+1];
                centerTitle=kWaves;
                centerLocation=@"";
                centerLogoImgName=@"cLogo3";
                centerCityName=@"Copenhagen";
                isSelected=@"No";
                break;
            case 3:
                centerID=ID;
                centerImgName=[NSString stringWithFormat:@"imgO%li",(long)ID+1];
                centerTitle=kACentret;
                centerLocation=@"";
                centerLogoImgName=@"cLogo2";
                centerCityName=@"Copenhagen";
                isSelected=@"No";
                break;
            case 4:
                centerID=ID;
                centerImgName=[NSString stringWithFormat:@"imgO%li",(long)ID+1];
                centerTitle=kBCentret;
                centerLocation=@"";
                centerLogoImgName=@"cLogo2";
                centerCityName=@"Copenhagen";
                isSelected=@"No";
                break;
            case 5:
                centerID=ID;
                centerImgName=[NSString stringWithFormat:@"imgO%li",(long)ID+1];
                centerTitle=kGalleriK;
                centerLocation=@"";
                centerLogoImgName=@"cLogo3";
                centerCityName=@"Copenhagen";
                isSelected=@"No";
                break;
            case 6:
                centerID=ID;
                centerImgName=[NSString stringWithFormat:@"imgO%li",(long)ID+1];
                centerTitle=kWaterfront;
                centerLocation=@"";
                centerLogoImgName=@"cLogo2";
                centerCityName=@"Copenhagen";
                isSelected=@"No";
                break;
            default:
                break;
        }
    }
    return  self;
}
-(NSDictionary *)getDictionaryOfObject{
    NSMutableDictionary * dict=[[NSMutableDictionary alloc]init];
    [dict setObject:[NSString stringWithFormat:@"%li",(long)centerID] forKey:kTempCenterID];
    [dict setObject:centerImgName forKey:kTempCenterImgName];
    [dict setObject:centerTitle forKey:kTempCenterTitle];
    [dict setObject:centerCityName forKey:kTempCenterCity];
    [dict setObject:centerLocation forKey:kTempCenterLocation];
    [dict setObject:isSelected forKey:kTempCenterSelected];
    return dict;
}
-(CenterObject*) initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    if(self)
    {
        centerID=[[dict valueForKey:kTempCenterID]integerValue];
        centerImgName=[dict valueForKey:kTempCenterImgName];
        centerTitle=[dict valueForKey:kTempCenterTitle];
        centerCityName=[dict valueForKey:kTempCenterCity];
        centerLocation=[dict valueForKey:kTempCenterLocation];
        isSelected=[dict valueForKey:kTempCenterSelected];
    }
    return self;
}

@end
