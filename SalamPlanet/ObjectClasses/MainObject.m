//
//  MainObject.m
//  SalamCenterApp
//
//  Created by Globit on 24/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "MainObject.h"

@implementation MainObject
@synthesize objID;
@synthesize objDetail;
@synthesize objImgName;
@synthesize objTitle;
@synthesize objType;
@synthesize objPlace;
@synthesize isFavourite;
@synthesize objCategory;
@synthesize isBookmarked;
@synthesize objShop;
@synthesize objHeadline;
@synthesize objShopLogoImgName;
-(MainObject*) initWithID:(NSInteger)ID
{
    self = [super init];
    if(self)
    {
        switch (ID) {
            case 0:
                objID=ID;
                objImgName=[NSString stringWithFormat:@"imgO1"];
                objTitle=@"Cool gear til ham";
                objHeadline=@"This is very good offer so you can save your money etc...";
                objDetail=@"This is very good offer so you can save your money etc...";
                objDetail=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                objType=News;
                objPlace=kLyngbyStorcenter;
                objShop=@"504 SALON";
                objShopLogoImgName=@"shop-logo1";
                isFavourite=@"NO";
                isBookmarked=@"NO";
                objCategory=kIntAccessories;
                break;
            case 1:
                objID=ID;
                objImgName=[NSString stringWithFormat:@"imgO2"];
                objTitle=@"En rigtig slipseknude";
                objHeadline=@"This is very good offer so you can save your money etc...";
                objDetail=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                objType=News;
                objPlace=kLyngbyStorcenter;
                objShop=@"A+ SCHOOL";
                objShopLogoImgName=@"shop-logo2";
                isFavourite=@"NO";
                isBookmarked=@"NO";
                objCategory=kIntAccessories;
                break;
            case 2:
                objID=ID;
                objImgName=[NSString stringWithFormat:@"imgO3"];
                objTitle=@"Vedhæng til julen";
                objHeadline=@"This is very good offer so you can save your money etc...";
                objDetail=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                objType=News;
                objPlace=kLyngbyStorcenter;
                objShop=@"AEEXA PHILLY";
                objShopLogoImgName=@"shop-logo3";
                isFavourite=@"NO";
                isBookmarked=@"NO";
                objCategory=kIntArtGallery;
                break;
            case 3:
                objID=ID;
                objImgName=[NSString stringWithFormat:@"imgO4"];
                objTitle=@"Bedstes gaver";
                objHeadline=@"This is very good offer so you can save your money etc...";
                objDetail=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                objType=News;
                objPlace=kRCentrum;
                objShop=@"AEROPOSTALE";
                objShopLogoImgName=@"shop-logo3";
                isFavourite=@"NO";
                isBookmarked=@"NO";
                objCategory=kIntArtGallery;
                break;
            case 4:
                objID=ID;
                objImgName=[NSString stringWithFormat:@"imgO5"];
                objTitle=@"Svedige julegaver";
                objHeadline=@"This is very good offer so you can save your money etc...";
                objDetail=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                objType=News;
                objPlace=kRCentrum;
                objShop=@"Almaas Jwellers";
                objShopLogoImgName=@"shop-logo4";
                isFavourite=@"NO";
                isBookmarked=@"NO";
                objCategory=kIntDepartmentStores;
                break;
            case 5:
                objID=ID;
                objImgName=[NSString stringWithFormat:@"imgO6"];
                objTitle=@"Det er helt sort";
                objHeadline=@"This is very good offer so you can save your money etc...";
                objDetail=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                objType=News;
                objPlace=kWaves;
                objShop=@"AMC THEATRES";
                objShopLogoImgName=@"shop-logo5";
                isFavourite=@"NO";
                isBookmarked=@"NO";
                objCategory=kIntDepartmentStores;
                break;
            case 6:
                objID=ID;
                objImgName=[NSString stringWithFormat:@"imgO7"];
                objTitle=@"Den lille sorte";
                objHeadline=@"This is very good offer so you can save your money etc...";
                objDetail=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                objType=News;
                objPlace=kWaves;
                objShop=@"AMERICAN EAGLE";
                objShopLogoImgName=@"shop-logo6";
                isFavourite=@"NO";
                isBookmarked=@"NO";
                objCategory=kIntHealthBeauty;
                break;
            case 7:
                objID=ID;
                objImgName=[NSString stringWithFormat:@"imgO8"];
                objTitle=@"Blik for briller?";
                objHeadline=@"This is very good offer so you can save your money etc...";
                objDetail=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                objType=News;
                objPlace=kWaves;
                objShop=@"BEST MOBILE";
                objShopLogoImgName=@"shop-logo7";
                isFavourite=@"NO";
                isBookmarked=@"NO";
                objCategory=kIntHealthBeauty;
                break;
            case 8:
                objID=ID;
                objImgName=[NSString stringWithFormat:@"imgO3"];
                objTitle=@"Ren forkælelse";
                objHeadline=@"This is very good offer so you can save your money etc...";
                objDetail=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                objType=News;
                objPlace=kACentret;
                objShop=@"BIG TYME";
                objShopLogoImgName=@"shop-logo8";
                isFavourite=@"NO";
                isBookmarked=@"NO";
                objCategory=kIntFastFood;
                break;
            case 9:
                objID=ID;
                objImgName=[NSString stringWithFormat:@"imgO4"];
                objTitle=@"Hip Hip Hurra..";
                objHeadline=@"This is very good offer so you can save your money etc...";
                objDetail=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                objType=News;
                objPlace=kACentret;
                objShop=@"Shop XYZ";
                objShopLogoImgName=@"shop-logo1";
                isFavourite=@"NO";
                isBookmarked=@"NO";
                objCategory=kIntFastFood;
                break;
            case 10:
                objID=ID;
                objImgName=[NSString stringWithFormat:@"imgO5"];
                objTitle=@"Hip Hip Hurra..";
                objHeadline=@"This is very good offer so you can save your money etc...";
                objDetail=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                objType=News;
                objPlace=kBCentret;
                objShop=@"BROW ART 23";
                objShopLogoImgName=@"shop-logo2";
                isFavourite=@"NO";
                isBookmarked=@"NO";
                objCategory=kIntShoes;
                break;
            case 11:
                objID=ID;
                objImgName=[NSString stringWithFormat:@"imgO6"];
                objTitle=@"Hip Hip Hurra..";
                objHeadline=@"This is very good offer so you can save your money etc...";
                objDetail=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                objType=Offers;
                objPlace=kBCentret;
                objShop=@"CANCUN MARKET";
                objShopLogoImgName=@"shop-logo3";
                isFavourite=@"NO";
                isBookmarked=@"NO";
                objCategory=kIntShoes;
                break;
            case 12:
                objID=ID;
                objImgName=[NSString stringWithFormat:@"imgO8"];
                objTitle=@"Trendy og maskulin";
                objHeadline=@"This is very good offer so you can save your money etc...";
                objDetail=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                objType=Offers;
                objPlace=kGalleriK;
                objShop=@"Shop XYZ";
                objShopLogoImgName=@"shop-logo4";
                isFavourite=@"NO";
                isBookmarked=@"NO";
                objCategory=kIntToys;
                break;
            case 13:
                objID=ID;
                objImgName=[NSString stringWithFormat:@"imgO1"];
                objTitle=@"Trendy og maskulin";
                objHeadline=@"This is very good offer so you can save your money etc...";
                objDetail=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                objType=Offers;
                objPlace=kGalleriK;
                objShop=@"CANDY LAND";
                objShopLogoImgName=@"shop-logo5";
                isFavourite=@"NO";
                isBookmarked=@"NO";
                objCategory=kIntToys;
                break;
            case 14:
                objID=ID;
                objImgName=[NSString stringWithFormat:@"imgO2"];
                objTitle=@"Trendy og maskulin";
                objHeadline=@"This is very good offer so you can save your money etc...";
                objDetail=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                objType=Offers;
                objPlace=kGalleriK;
                objShop=@"Champs Sports";
                objShopLogoImgName=@"shop-logo6";
                isFavourite=@"NO";
                isBookmarked=@"NO";
                objCategory=kIntWomensApparel;
                break;
            case 15:
                objID=ID;
                objImgName=[NSString stringWithFormat:@"imgO3"];
                objTitle=@"Efterårsløb for mænd";
                objHeadline=@"This is very good offer so you can save your money etc...";
                objDetail=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                objType=Offers;
                objPlace=kWaterfront;
                objShop=@"CHILDREN'S PLACE";
                objShopLogoImgName=@"shop-logo7";
                isFavourite=@"NO";
                isBookmarked=@"NO";
                objCategory=kIntWomensApparel;
                break;
            case 16:
                objID=ID;
                objImgName=[NSString stringWithFormat:@"imgO4"];
                objTitle=@"Efterårsløb for mænd";
                objHeadline=@"This is very good offer so you can save your money etc...";
                objDetail=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only. Quantities limited. Not valid on previous orders. If you choose the ship to home delivery option for your gift card, it will be sent to the address associated with your order and will ship separately. If you choose to pick up your item at the store, your gift card will be delivered after you have picked up the qualifying item.";
                objType=Offers;
                objPlace=kWaterfront;
                objShop=@"DILLARD'S";
                objShopLogoImgName=@"shop-logo8";
                isFavourite=@"NO";
                isBookmarked=@"NO";
                objCategory=kIntBooksStationery;
                break;
                
            default:
                break;
        }
    }
    return  self;
}
-(NSDictionary *)getDictionaryOfObject{
    NSMutableDictionary * dict=[[NSMutableDictionary alloc]init];
    [dict setObject:[NSString stringWithFormat:@"%li",(long)objID] forKey:kTempObjID];
    [dict setObject:objImgName forKey:kTempObjImgName];
    [dict setObject:objTitle forKey:kTempObjTitle];
    [dict setObject:objDetail forKey:kTempObjDetail];
    [dict setObject:objHeadline forKey:kTempObjHeadline];
    [dict setObject:[NSString stringWithFormat:@"%lu",objType] forKey:kTempObjType];
    [dict setObject:objPlace forKey:kTempObjPlace];
    [dict setObject:objShop forKey:kTempObjShop];
    [dict setObject:objShopLogoImgName forKey:kTempObjShopLogoImgName];
    [dict setObject:isFavourite forKey:kTempObjIsFav];
    [dict setObject:isBookmarked forKey:kTempObjIsBookmarked];
    [dict setObject:objCategory forKey:kTempObjCategory];
    return dict;
}
-(MainObject*) initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    if(self)
    {
        objID=[[dict valueForKey:kTempObjID]integerValue];
        objImgName=[dict valueForKey:kTempObjImgName];
        objTitle=[dict valueForKey:kTempObjTitle];
        objDetail=[dict valueForKey:kTempObjDetail];
        objHeadline=[dict valueForKey:kTempObjHeadline];
        objType=[[dict valueForKey:kTempObjType]integerValue];
        objPlace=[dict valueForKey:kTempObjPlace];
        objShop=[dict valueForKey:kTempObjShop];
        objShopLogoImgName=[dict valueForKey:kTempObjShopLogoImgName];
        isFavourite=[dict valueForKey:kTempObjIsFav];
        isBookmarked=[dict valueForKey:kTempObjIsBookmarked];
        objCategory=[dict valueForKey:kTempObjCategory];
    }
    return self;
}
@end
