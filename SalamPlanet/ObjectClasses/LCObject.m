//
//  LCObject.m
//  SalamCenterApp
//
//  Created by Globit on 26/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "LCObject.h"

@implementation LCObject
@synthesize lcID;
@synthesize lcFrontImgName;
@synthesize lcBackImgName;
@synthesize lcBarcodeNumber;
@synthesize lcCardNumber;
@synthesize lcShopName;
@synthesize lcTitle;
@synthesize lcDescription;
@synthesize lcBarcodeImgName;
@synthesize lcBackImage;
@synthesize lcFrontImage;
@synthesize lcBarcodeName;
-(LCObject*) initWithID:(NSInteger)ID
{
    self = [super init];
    if(self)
    {
        switch (ID) {
            case 0:
                lcID=ID;
                lcBackImgName=@"LC_CardImg2";
                lcFrontImgName=@"lc1";
                lcShopName=@"Adler Luxembourg";
                lcCardNumber=@"12 23 22 112 334";
                lcBarcodeNumber=@"2334859596866945";
                lcTitle=@"Adler Kundenkarte";
                lcDescription=@"Using this card you can avail very good discount on the products";
                lcBarcodeImgName=@"BTCode128";
                lcBarcodeName=@"Code128";
                break;
            case 1:
                lcID=ID;
                lcBackImgName=@"LC_CardImg2";
                lcFrontImgName=@"lc2";
                lcShopName=@"NAV - Nemzeti Adoes Vamhivatal";
                lcCardNumber=@"12 23 22 112 334";
                lcBarcodeNumber=@"2334859596866945";
                lcTitle=@"Adoigazoulvany";
                lcDescription=@"Using this card you can avail very good discount on the products";
                lcBarcodeImgName=@"BTCode39";
                lcBarcodeName=@"Code39";
                break;
            case 2:
                lcID=ID;
                lcBackImgName=@"LC_CardImg2";
                lcFrontImgName=@"lc3";
                lcShopName=@"Adria Airways Slovenija";
                lcCardNumber=@"12 23 22 112 334";
                lcBarcodeNumber=@"2334859596866945";
                lcTitle=@"Adria Airways Privilege";
                lcDescription=@"Using this card you can avail very good discount on the products";
                lcBarcodeImgName=@"BTEan13";
                lcBarcodeName=@"Ean13";
                break;
            case 3:
                lcID=ID;
                lcBackImgName=@"LC_CardImg2";
                lcFrontImgName=@"lc4";
                lcShopName=@"American Eagle USA";
                lcCardNumber=@"12 23 22 112 334";
                lcBarcodeNumber=@"2334859596866945";
                lcTitle=@"AEREWARDS";
                lcDescription=@"Using this card you can avail very good discount on the products";
                lcBarcodeImgName=@"BTEAN8";
                lcBarcodeName=@"BTEAN8";
                break;
            case 4:
                lcID=ID;
                lcBackImgName=@"LC_CardImg2";
                lcFrontImgName=@"lc5";
                lcShopName=@"Aeroflot";
                lcCardNumber=@"12 23 22 112 334";
                lcBarcodeNumber=@"2334859596866945";
                lcTitle=@"Aeroflot Bonus Gold";
                lcDescription=@"Using this card you can avail very good discount on the products";
                lcBarcodeImgName=@"BTInterleaved2of5";
                lcBarcodeName=@"Interleaved 2 of 5";
                break;
            default:
                break;
        }
    }
    return self;
}
@end
