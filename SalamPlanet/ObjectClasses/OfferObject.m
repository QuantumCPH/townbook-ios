//
//  OfferObject.m
//  SalamCenterApp
//
//  Created by Globit on 26/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "OfferObject.h"

@implementation OfferObject
@synthesize offerID;
@synthesize offerImgName;
@synthesize offerOffPercent;
@synthesize offerTitle;

-(OfferObject*) initWithID:(NSInteger)ID
{
    self = [super init];
    if(self)
    {
        switch (ID) {
            case 0:
                offerID=ID;
                offerTitle=@"Burger & Burger";
                offerImgName=@"offer-logo4.jpg";
                offerOffPercent=10;
                break;
            case 1:
                offerID=ID;
                offerTitle=@"Rough n Tough";
                offerImgName=@"offer-logo1.jpeg";
                offerOffPercent=10;
                break;
            case 2:
                offerID=ID;
                offerTitle=@"Soldier Boots";
                offerImgName=@"offer-logo3.jpg";
                offerOffPercent=80;
                break;
            case 3:
                offerID=ID;
                offerTitle=@"Amazing Offer";
                offerImgName=@"offer-logo5.jpg";
                offerOffPercent=40;
                break;
            case 4:
                offerID=ID;
                offerTitle=@"Jeans & Jeans";
                offerImgName=@"offer-logo2.jpg";
                offerOffPercent=10;
                break;
            default:
                break;
        }
    }
    return self;
}
@end
