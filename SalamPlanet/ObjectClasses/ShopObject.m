//
//  ShopObject.m
//  SalamCenterApp
//
//  Created by Globit on 29/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "ShopObject.h"
#import "Constants.h"

@implementation ShopObject
@synthesize shopID;
@synthesize shopName;
@synthesize shopDescription;
@synthesize shopImgName;
@synthesize shopLogoName;
@synthesize isBookmarked;
@synthesize shopCenterName;
@synthesize shopCategory;
@synthesize shopFloor;
@synthesize shopNameFirstAlpha;
@synthesize shopTitle;
-(ShopObject*) initWithID:(NSInteger)ID
{
    self = [super init];
    if(self)
    {
        switch (ID) {
            case 0:
                shopID=ID;
                shopDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                shopCenterName=kLyngbyStorcenter;
                shopTitle=@"Our latest Open Store in this center";
                shopName=@"A Class";
                shopLogoName=@"shop-logo7";
                isBookmarked=@"NO";
                shopImgName=@"imgO5";
                shopNameFirstAlpha=@"A";
                shopCategory=kSCGarments;
                shopFloor=@"Floor 1";
                break;
            case 1:
                shopID=ID;
                shopDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                shopCenterName=kLyngbyStorcenter;
                shopTitle=@"Our latest Open Store in this center";
                shopName=@"A+ SCHOOL UNIFORMS";
                shopLogoName=@"shop-logo2";
                isBookmarked=@"NO";
                shopImgName=@"imgO2";
                shopNameFirstAlpha=@"A";
                shopCategory=kSCGarments;
                shopFloor=@"Floor 1";
                break;
            case 2:
                shopID=ID;
                shopDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                shopCenterName=kLyngbyStorcenter;
                shopTitle=@"Our latest Open Store in this center";
                shopName=@"AEEXA PHILLY STEAK";
                shopLogoName=@"shop-logo3";
                isBookmarked=@"NO";
                shopImgName=@"imgO3";
                shopNameFirstAlpha=@"A";
                shopCategory=kSCEating;
                shopFloor=@"Floor 1";
                break;
            case 3:
                shopID=ID;
                shopDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                shopCenterName=kRCentrum;
                shopTitle=@"Our latest Open Store in this center";
                shopName=@"AEROPOSTALE";
                shopLogoName=@"shop-logo4";
                isBookmarked=@"NO";
                shopImgName=@"imgO4";
                shopNameFirstAlpha=@"A";
                shopCategory=kSCGarments;
                shopFloor=@"Floor 2";
                break;
            case 4:
                shopID=ID;
                shopDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                shopCenterName=kRCentrum;
                shopTitle=@"Our latest Open Store in this center";
                shopName=@"ALMAAS JEWELERS";
                shopLogoName=@"shop-logo5";
                isBookmarked=@"NO";
                shopImgName=@"imgO5";
                shopNameFirstAlpha=@"A";
                shopCategory=kSCGrocery;
                shopFloor=@"Floor 2";
                break;
            case 5:
                shopID=ID;
                shopDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                shopCenterName=kWaves;
                shopTitle=@"Our latest Open Store in this center";
                shopName=@"AMC THEATRES";
                shopLogoName=@"shop-logo6";
                isBookmarked=@"NO";
                shopImgName=@"imgO6";
                shopNameFirstAlpha=@"A";
                shopCategory=kSCEating;
                shopFloor=@"Floor 2";
                break;
            case 6:
                shopID=ID;
                shopDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                shopCenterName=kWaves;
                shopTitle=@"Our latest Open Store in this center";
                shopName=@"AMERICAN EAGLE OUTFITTERS";
                shopLogoName=@"shop-logo7";
                isBookmarked=@"NO";
                shopImgName=@"imgO7";
                shopNameFirstAlpha=@"B";
                shopCategory=kSCGarments;
                shopFloor=@"Floor 3";
                break;
            case 7:
                shopID=ID;
                shopDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                shopCenterName=kWaves;
                shopTitle=@"Our latest Open Store in this center";
                shopName=@"BEST BUY MOBILE";
                shopLogoName=@"shop-logo8";
                isBookmarked=@"NO";
                shopImgName=@"imgO8";
                shopNameFirstAlpha=@"S";
                shopCategory=kSCGrocery;
                shopFloor=@"Floor 3";
                break;
            case 8:
                shopID=ID;
                shopDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                shopCenterName=kACentret;
                shopTitle=@"Our latest Open Store in this center";
                shopName=@"BIG TYME AIRBRUSH";
                shopLogoName=@"shop-logo1";
                isBookmarked=@"NO";
                shopImgName=@"imgO1";
                shopNameFirstAlpha=@"B";
                shopCategory=kSCGrocery;
                shopFloor=@"Floor 3";
                break;
            case 9:
                shopID=ID;
                shopDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                shopCenterName=kBCentret;
                shopTitle=@"Our latest Open Store in this center";
                shopName=@"BROW ART 23";
                shopLogoName=@"shop-logo2";
                isBookmarked=@"NO";
                shopImgName=@"imgO2";
                shopNameFirstAlpha=@"B";
                shopCategory=kSCEating;
                shopFloor=@"Floor 2";
                break;
            case 10:
                shopID=ID;
                shopDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                shopCenterName=kBCentret;
                shopTitle=@"Our latest Open Store in this center";
                shopName=@"CANCUN MARKET";
                shopLogoName=@"shop-logo3";
                isBookmarked=@"NO";
                shopImgName=@"imgO3";
                shopNameFirstAlpha=@"C";
                shopCategory=kSCEating;
                shopFloor=@"Floor 4";
                break;
            case 11:
                shopID=ID;
                shopDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                shopCenterName=kLyngbyStorcenter;
                shopTitle=@"Our latest Open Store in this center";
                shopName=@"SALON";
                shopLogoName=@"shop-logo1";
                isBookmarked=@"NO";
                shopImgName=@"imgO3";
                shopNameFirstAlpha=@"S";
                shopCategory=kSCEating;
                shopFloor=@"Floor 1";
                break;
            case 12:
                shopID=ID;
                shopDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                shopCenterName=kLyngbyStorcenter;
                shopTitle=@"Our latest Open Store in this center";
                shopName=@"A SALON";
                shopLogoName=@"shop-logo2";
                isBookmarked=@"NO";
                shopImgName=@"imgO2";
                shopNameFirstAlpha=@"A";
                shopCategory=kSCEating;
                shopFloor=@"Floor 2";
                break;
            case 13:
                shopID=ID;
                shopDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                shopCenterName=kLyngbyStorcenter;
                shopTitle=@"Our latest Open Store in this center";
                shopName=@"B SALON";
                shopLogoName=@"shop-logo3";
                isBookmarked=@"NO";
                shopImgName=@"imgO1";
                shopNameFirstAlpha=@"S";
                shopCategory=kSCEating;
                shopFloor=@"Floor 3";
                break;
            case 14:
                shopID=ID;
                shopDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                shopCenterName=kWaves;
                shopTitle=@"Our latest Open Store in this center";
                shopName=@"C SALON";
                shopLogoName=@"shop-logo4";
                isBookmarked=@"NO";
                shopImgName=@"imgO8";
                shopNameFirstAlpha=@"S";
                shopCategory=kSCGrocery;
                shopFloor=@"Floor 4";
                break;
            case 15:
                shopID=ID;
                shopDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                shopCenterName=kWaves;
                shopTitle=@"Our latest Open Store in this center";
                shopName=@"D SALON";
                shopLogoName=@"shop-logo1";
                isBookmarked=@"NO";
                shopImgName=@"imgO7";
                shopNameFirstAlpha=@"S";
                shopCategory=kSCGrocery;
                shopFloor=@"Floor 1";
                break;
            case 16:
                shopID=ID;
                shopDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                shopCenterName=kWaterfront;
                shopTitle=@"Our latest Open Store in this center";
                shopName=@"E SALON";
                shopLogoName=@"shop-logo5";
                isBookmarked=@"NO";
                shopImgName=@"imgO6";
                shopNameFirstAlpha=@"S";
                shopCategory=kSCGrocery;
                shopFloor=@"Floor 2";
                break;
            case 17:
                shopID=ID;
                shopDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                shopCenterName=kWaterfront;
                shopTitle=@"Our latest Open Store in this center";
                shopName=@"F SALON";
                shopLogoName=@"shop-logo6";
                isBookmarked=@"NO";
                shopImgName=@"imgO5";
                shopNameFirstAlpha=@"S";
                shopCategory=kSCGrocery;
                shopFloor=@"Floor 3";
                break;
            case 18:
                shopID=ID;
                shopDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                shopCenterName=kWaterfront;
                shopTitle=@"Our latest Open Store in this center";
                shopName=@"G SALON";
                shopLogoName=@"shop-logo7";
                isBookmarked=@"NO";
                shopImgName=@"imgO4";
                shopNameFirstAlpha=@"S";
                shopCategory=kSCGarments;
                shopFloor=@"Floor 4";
                break;
            case 19:
                shopID=ID;
                shopDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                shopCenterName=kBCentret;
                shopTitle=@"Our latest Open Store in this center";
                shopName=@"H SALON";
                shopLogoName=@"shop-logo8";
                isBookmarked=@"NO";
                shopImgName=@"imgO3";
                shopNameFirstAlpha=@"S";
                shopCategory=kSCGarments;
                shopFloor=@"Floor 1";
                break;
            case 20:
                shopID=ID;
                shopDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                shopCenterName=kBCentret;
                shopTitle=@"Our latest Open Store in this center";
                shopName=@"I SALON";
                shopLogoName=@"shop-logo1";
                isBookmarked=@"NO";
                shopImgName=@"imgO2";
                shopNameFirstAlpha=@"S";
                shopCategory=kSCGarments;
                shopFloor=@"Floor 2";
                break;
            case 21:
                shopID=ID;
                shopDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                shopCenterName=kBCentret;
                shopTitle=@"Our latest Open Store in this center";
                shopName=@"J SALON";
                shopLogoName=@"shop-logo2";
                isBookmarked=@"NO";
                shopImgName=@"imgO1";
                shopNameFirstAlpha=@"S";
                shopCategory=kSCEating;
                shopFloor=@"Floor 3";
                break;

            default:
                break;
        }
    }
    return self;
}
-(NSDictionary *)getDictionaryOfObject{
    NSMutableDictionary * dict=[[NSMutableDictionary alloc]init];

    [dict setObject:[NSString stringWithFormat:@"%li",(long)shopID] forKey:kTempObjID];
    [dict setObject:shopImgName forKey:kTempObjImgName];
    [dict setObject:shopDescription forKey:kTempObjDetail];
    [dict setObject:shopTitle forKey:kTempObjTitle];
    [dict setObject:shopCenterName forKey:kTempObjPlace];
    [dict setObject:shopName forKey:kTempObjShop];
    [dict setObject:shopLogoName forKey:kTempObjShopLogoImgName];
    [dict setObject:isBookmarked forKey:kTempObjIsBookmarked];

    return dict;
}
@end
