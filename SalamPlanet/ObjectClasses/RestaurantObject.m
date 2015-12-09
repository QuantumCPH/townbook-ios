//
//  RestaurantObject.m
//  SalamCenterApp
//
//  Created by Globit on 01/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import "RestaurantObject.h"
#import "Constants.h"

@implementation RestaurantObject

@synthesize restID;
@synthesize restName;
@synthesize restDescription;
@synthesize restImgName;
@synthesize restLogoName;
@synthesize isBookmarked;
@synthesize restCenterName;
@synthesize restCategory;
@synthesize restFloor;
@synthesize restNameFirstAlpha;

-(RestaurantObject*) initWithID:(NSInteger)ID
{
    self = [super init];
    if(self)
    {
        switch (ID) {
            case 0:
                restID=ID;
                restDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                restCenterName=kLyngbyStorcenter;
                restName=@"A Restaurant";
                restLogoName=@"rest-logo7";
                isBookmarked=@"NO";
                restImgName=@"imgO5";
                restNameFirstAlpha=@"A";
                restCategory=kRCChinese;
                restFloor=@"Floor 1";
                break;
            case 1:
                restID=ID;
                restDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                restCenterName=kLyngbyStorcenter;
                restName=@"B Restaurant";
                restLogoName=@"rest-logo2";
                isBookmarked=@"NO";
                restImgName=@"imgO2";
                restNameFirstAlpha=@"A";
                restCategory=kRCChinese;
                restFloor=@"Floor 1";
                break;
            case 2:
                restID=ID;
                restDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                restCenterName=kLyngbyStorcenter;
                restName=@"AEEXA PHILLY STEAK";
                restLogoName=@"rest-logo3";
                isBookmarked=@"NO";
                restImgName=@"imgO3";
                restNameFirstAlpha=@"A";
                restCategory=kRCChinese;
                restFloor=@"Floor 1";
                break;
            case 3:
                restID=ID;
                restDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                restCenterName=kRCentrum;
                restName=@"AEROPOSTALE";
                restLogoName=@"rest-logo4";
                isBookmarked=@"NO";
                restImgName=@"imgO4";
                restNameFirstAlpha=@"A";
                restCategory=kRCChinese;
                restFloor=@"Floor 2";
                break;
            case 4:
                restID=ID;
                restDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                restCenterName=kRCentrum;
                restName=@"B Restaurant";
                restLogoName=@"rest-logo5";
                isBookmarked=@"NO";
                restImgName=@"imgO5";
                restNameFirstAlpha=@"A";
                restCategory=kRCContinental;
                restFloor=@"Floor 2";
                break;
            case 5:
                restID=ID;
                restDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                restCenterName=kWaves;
                restName=@"B Restaurant";
                restLogoName=@"rest-logo6";
                isBookmarked=@"NO";
                restImgName=@"imgO6";
                restNameFirstAlpha=@"A";
                restCategory=kRCContinental;
                restFloor=@"Floor 2";
                break;
            case 6:
                restID=ID;
                restDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                restCenterName=kWaves;
                restName=@"C Restaurant";
                restLogoName=@"rest-logo7";
                isBookmarked=@"NO";
                restImgName=@"imgO7";
                restNameFirstAlpha=@"B";
                restCategory=kRCContinental;
                restFloor=@"Floor 3";
                break;
            case 7:
                restID=ID;
                restDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                restCenterName=kWaves;
                restName=@"D Restaurant";
                restLogoName=@"rest-logo8";
                isBookmarked=@"NO";
                restImgName=@"imgO8";
                restNameFirstAlpha=@"S";
                restCategory=kRCContinental;
                restFloor=@"Floor 3";
                break;
            case 8:
                restID=ID;
                restDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                restCenterName=kACentret;
                restName=@"E Restaurant";
                restLogoName=@"rest-logo1";
                isBookmarked=@"NO";
                restImgName=@"imgO1";
                restNameFirstAlpha=@"B";
                restCategory=kRCSeaFood;
                restFloor=@"Floor 3";
                break;
            case 9:
                restID=ID;
                restDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                restCenterName=kBCentret;
                restName=@"F Restaurant";
                restLogoName=@"rest-logo2";
                isBookmarked=@"NO";
                restImgName=@"imgO2";
                restNameFirstAlpha=@"B";
                restCategory=kRCSeaFood;
                restFloor=@"Floor 2";
                break;
            case 10:
                restID=ID;
                restDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                restCenterName=kBCentret;
                restName=@"G Restaurant";
                restLogoName=@"rest-logo3";
                isBookmarked=@"NO";
                restImgName=@"imgO3";
                restNameFirstAlpha=@"C";
                restCategory=kRCSeaFood;
                restFloor=@"Floor 4";
                break;
            case 11:
                restID=ID;
                restDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                restCenterName=kLyngbyStorcenter;
                restName=@"H Restaurant";
                restLogoName=@"rest-logo1";
                isBookmarked=@"NO";
                restImgName=@"imgO3";
                restNameFirstAlpha=@"S";
                restCategory=kRCSeaFood;
                restFloor=@"Floor 1";
                break;
            case 12:
                restID=ID;
                restDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                restCenterName=kLyngbyStorcenter;
                restName=@"I Restaurant";
                restLogoName=@"rest-logo2";
                isBookmarked=@"NO";
                restImgName=@"imgO2";
                restNameFirstAlpha=@"A";
                restCategory=kRCFastFood;
                restFloor=@"Floor 2";
                break;
            case 13:
                restID=ID;
                restDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                restCenterName=kLyngbyStorcenter;
                restName=@"J Restaurant";
                restLogoName=@"rest-logo3";
                isBookmarked=@"NO";
                restImgName=@"imgO1";
                restNameFirstAlpha=@"S";
                restCategory=kRCFastFood;
                restFloor=@"Floor 3";
                break;
            case 14:
                restID=ID;
                restDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                restCenterName=kWaves;
                restName=@"K Restaurant";
                restLogoName=@"rest-logo4";
                isBookmarked=@"NO";
                restImgName=@"imgO8";
                restNameFirstAlpha=@"S";
                restCategory=kRCFastFood;
                restFloor=@"Floor 4";
                break;
            case 15:
                restID=ID;
                restDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                restCenterName=kWaves;
                restName=@"L Restaurant";
                restLogoName=@"rest-logo1";
                isBookmarked=@"NO";
                restImgName=@"imgO7";
                restNameFirstAlpha=@"S";
                restCategory=kRCFastFood;
                restFloor=@"Floor 1";
                break;
            case 16:
                restID=ID;
                restDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                restCenterName=kWaterfront;
                restName=@"M Restaurant";
                restLogoName=@"rest-logo5";
                isBookmarked=@"NO";
                restImgName=@"imgO6";
                restNameFirstAlpha=@"S";
                restCategory=kRCIndian;
                restFloor=@"Floor 2";
                break;
            case 17:
                restID=ID;
                restDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                restCenterName=kWaterfront;
                restName=@"N Restaurant";
                restLogoName=@"rest-logo6";
                isBookmarked=@"NO";
                restImgName=@"imgO5";
                restNameFirstAlpha=@"S";
                restCategory=kRCIndian;
                restFloor=@"Floor 3";
                break;
            case 18:
                restID=ID;
                restDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                restCenterName=kWaterfront;
                restName=@"O Restaurant";
                restLogoName=@"rest-logo7";
                isBookmarked=@"NO";
                restImgName=@"imgO4";
                restNameFirstAlpha=@"S";
                restCategory=kRCIndian;
                restFloor=@"Floor 4";
                break;
            case 19:
                restID=ID;
                restDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                restCenterName=kBCentret;
                restName=@"P Restaurant";
                restLogoName=@"rest-logo8";
                isBookmarked=@"NO";
                restImgName=@"imgO3";
                restNameFirstAlpha=@"S";
                restCategory=kRCIndian;
                restFloor=@"Floor 1";
                break;
            case 20:
                restID=ID;
                restDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                restCenterName=kBCentret;
                restName=@"Q Restaurant";
                restLogoName=@"rest-logo1";
                isBookmarked=@"NO";
                restImgName=@"imgO2";
                restNameFirstAlpha=@"S";
                restCategory=kRCItalian;
                restFloor=@"Floor 2";
                break;
            case 21:
                restID=ID;
                restDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                restCenterName=kBCentret;
                restName=@"R Restaurant";
                restLogoName=@"rest-logo2";
                isBookmarked=@"NO";
                restImgName=@"imgO1";
                restNameFirstAlpha=@"S";
                restCategory=kRCItalian;
                restFloor=@"Floor 3";
                break;
                
            default:
                break;
        }
    }
    return self;
}
-(NSDictionary *)getDictionaryOfObject{
    NSMutableDictionary * dict=[[NSMutableDictionary alloc]init];
    
    [dict setObject:[NSString stringWithFormat:@"%li",(long)restID] forKey:kTempObjID];
    [dict setObject:restImgName forKey:kTempObjImgName];
    [dict setObject:restDescription forKey:kTempObjDetail];
    [dict setObject:restCenterName forKey:kTempObjPlace];
    [dict setObject:restName forKey:kTempObjShop];
    [dict setObject:restLogoName forKey:kTempObjShopLogoImgName];
    [dict setObject:isBookmarked forKey:kTempObjIsBookmarked];
    
    return dict;
}


@end
