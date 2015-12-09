//
//  ServiceObject.m
//  SalamCenterApp
//
//  Created by Globit on 30/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "ServiceObject.h"
#import "Constants.h"

@implementation ServiceObject

@synthesize serviceID;
@synthesize serviceName;
@synthesize serviceAddress;
@synthesize serviceDescription;
@synthesize serviceFloor;
@synthesize serviceImgName;
@synthesize serviceTelNumber;
@synthesize serviceCenterName;

-(ServiceObject*) initWithID:(NSInteger)ID
{
    self = [super init];
    if(self)
    {
        switch (ID) {
            case 0:
                serviceID=ID;
                serviceDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only.";
                serviceCenterName=kLyngbyStorcenter;
                serviceName=@"A Service";
                serviceImgName=@"imgO2";
                serviceFloor=@"Floor 1";
                serviceTelNumber=@"11 22 33 44 55";
                serviceAddress=@"Services Lounge\nButik 222/Plan 1\nArne Jacobsens Alle 12\n2300 Copenhagen";
                break;
            case 1:
                serviceID=ID;
                serviceDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only.";
                serviceCenterName=kRCentrum;
                serviceName=@"B Service";
                serviceImgName=@"imgO3";
                serviceFloor=@"Floor 1";
                serviceTelNumber=@"11 22 33 44 55";
                serviceAddress=@"Services Lounge\nButik 222/Plan 1\nArne Jacobsens Alle 12\n2300 Copenhagen";
                break;
            case 2:
                serviceID=ID;
                serviceDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only.";
                serviceCenterName=kWaves;
                serviceName=@"C Service";
                serviceImgName=@"imgO4";
                serviceFloor=@"Floor 1";
                serviceTelNumber=@"11 22 33 44 55";
                serviceAddress=@"Services Lounge\nButik 222/Plan 1\nArne Jacobsens Alle 12\n2300 Copenhagen";
                break;
            case 3:
                serviceID=ID;
                serviceDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only.";
                serviceCenterName=kACentret;
                serviceName=@"D Service";
                serviceImgName=@"imgO5";
                serviceFloor=@"Floor 2";
                serviceTelNumber=@"11 22 33 44 55";
                serviceAddress=@"Services Lounge\nButik 222/Plan 1\nArne Jacobsens Alle 12\n2300 Copenhagen";
                break;
            case 4:
                serviceID=ID;
                serviceDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only.";
                serviceCenterName=kBCentret;
                serviceName=@"E Service";
                serviceImgName=@"imgO6";
                serviceFloor=@"Floor 2";
                serviceTelNumber=@"11 22 33 44 55";
                serviceAddress=@"Services Lounge\nButik 222/Plan 1\nArne Jacobsens Alle 12\n2300 Copenhagen";
                break;
            case 5:
                serviceID=ID;
                serviceDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only.";
                serviceCenterName=kGalleriK;
                serviceName=@"F Service";
                serviceImgName=@"imgO7";
                serviceFloor=@"Floor 2";
                serviceTelNumber=@"11 22 33 44 55";
                serviceAddress=@"Services Lounge\nButik 222/Plan 1\nArne Jacobsens Alle 12\n2300 Copenhagen";
                break;
            case 6:
                serviceID=ID;
                serviceDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only.";
                serviceCenterName=kWaterfront;
                serviceName=@"G Service";
                serviceImgName=@"imgO8";
                serviceFloor=@"Floor 3";
                serviceTelNumber=@"11 22 33 44 55";
                serviceAddress=@"Services Lounge\nButik 222/Plan 1\nArne Jacobsens Alle 12\n2300 Copenhagen";
                break;
            case 7:
                serviceID=ID;
                serviceDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only.";
                serviceCenterName=kWaterfront;
                serviceName=@"H Service";
                serviceImgName=@"imgO1";
                serviceFloor=@"Floor 3";
                serviceTelNumber=@"11 22 33 44 55";
                serviceAddress=@"Services Lounge\nButik 222/Plan 1\nArne Jacobsens Alle 12\n2300 Copenhagen";
                break;
            case 8:
                serviceID=ID;
                serviceDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only.";
                serviceCenterName=kLyngbyStorcenter;
                serviceName=@"I Service";
                serviceImgName=@"imgO2";
                serviceFloor=@"Floor 3";
                serviceTelNumber=@"11 22 33 44 55";
                serviceAddress=@"Services Lounge\nButik 222/Plan 1\nArne Jacobsens Alle 12\n2300 Copenhagen";
                break;
            case 9:
                serviceID=ID;
                serviceDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only.";
                serviceCenterName=kLyngbyStorcenter;
                serviceName=@"J Service";
                serviceImgName=@"imgO3";
                serviceFloor=@"Floor 4";
                serviceTelNumber=@"11 22 33 44 55";
                serviceAddress=@"Services Lounge\nButik 222/Plan 1\nArne Jacobsens Alle 12\n2300 Copenhagen";
                break;
            case 10:
                serviceID=ID;
                serviceDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only.";
                serviceCenterName=kGalleriK;
                serviceName=@"K Service";
                serviceImgName=@"imgO4";
                serviceFloor=@"Floor 4";
                serviceTelNumber=@"11 22 33 44 55";
                serviceAddress=@"Services Lounge\nButik 222/Plan 1\nArne Jacobsens Alle 12\n2300 Copenhagen";
                break;
            case 11:
                serviceID=ID;
                serviceDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only.";
                serviceCenterName=kGalleriK;
                serviceName=@"K Service";
                serviceImgName=@"imgO5";
                serviceFloor=@"Floor 3";
                serviceTelNumber=@"11 22 33 44 55";
                serviceAddress=@"Services Lounge\nButik 222/Plan 1\nArne Jacobsens Alle 12\n2300 Copenhagen";
                break;
            case 12:
                serviceID=ID;
                serviceDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only.";
                serviceCenterName=kGalleriK;
                serviceName=@"L Service";
                serviceImgName=@"imgO6";
                serviceFloor=@"Floor 2";
                serviceTelNumber=@"11 22 33 44 55";
                serviceAddress=@"Services Lounge\nButik 222/Plan 1\nArne Jacobsens Alle 12\n2300 Copenhagen";
                break;
            case 13:
                serviceID=ID;
                serviceDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only.";
                serviceCenterName=kBCentret;
                serviceName=@"M Service";
                serviceImgName=@"imgO7";
                serviceFloor=@"Floor 1";
                serviceTelNumber=@"11 22 33 44 55";
                serviceAddress=@"Services Lounge\nButik 222/Plan 1\nArne Jacobsens Alle 12\n2300 Copenhagen";
                break;
            case 14:
                serviceID=ID;
                serviceDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only.";
                serviceCenterName=kBCentret;
                serviceName=@"N Service";
                serviceImgName=@"imgO8";
                serviceFloor=@"Floor 4";
                serviceTelNumber=@"11 22 33 44 55";
                serviceAddress=@"Services Lounge\nButik 222/Plan 1\nArne Jacobsens Alle 12\n2300 Copenhagen";
                break;
            case 15:
                serviceID=ID;
                serviceDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only.";
                serviceCenterName=kBCentret;
                serviceName=@"O Service";
                serviceImgName=@"imgO1";
                serviceFloor=@"Floor 3";
                serviceTelNumber=@"11 22 33 44 55";
                serviceAddress=@"Services Lounge\nButik 222/Plan 1\nArne Jacobsens Alle 12\n2300 Copenhagen";
                break;
            case 16:
                serviceID=ID;
                serviceDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only.";
                serviceCenterName=kBCentret;
                serviceName=@"P Service";
                serviceImgName=@"imgO2";
                serviceFloor=@"Floor 2";
                serviceTelNumber=@"11 22 33 44 55";
                serviceAddress=@"Services Lounge\nButik 222/Plan 1\nArne Jacobsens Alle 12\n2300 Copenhagen";
                break;
            case 17:
                serviceID=ID;
                serviceDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only.";
                serviceCenterName=kACentret;
                serviceName=@"Q Service";
                serviceImgName=@"imgO3";
                serviceFloor=@"Floor 1";
                serviceTelNumber=@"11 22 33 44 55";
                serviceAddress=@"Services Lounge\nButik 222/Plan 1\nArne Jacobsens Alle 12\n2300 Copenhagen";
                break;
            case 18:
                serviceID=ID;
                serviceDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only.";
                serviceCenterName=kACentret;
                serviceName=@"R Service";
                serviceImgName=@"imgO4";
                serviceFloor=@"Floor 4";
                serviceTelNumber=@"11 22 33 44 55";
                serviceAddress=@"Services Lounge\nButik 222/Plan 1\nArne Jacobsens Alle 12\n2300 Copenhagen";
                break;
            case 19:
                serviceID=ID;
                serviceDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only.";
                serviceCenterName=kACentret;
                serviceName=@"S Service";
                serviceImgName=@"imgO5";
                serviceFloor=@"Floor 3";
                serviceTelNumber=@"11 22 33 44 55";
                serviceAddress=@"Services Lounge\nButik 222/Plan 1\nArne Jacobsens Alle 12\n2300 Copenhagen";
                break;
            case 20:
                serviceID=ID;
                serviceDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only.";
                serviceCenterName=kWaves;
                serviceName=@"T Service";
                serviceImgName=@"imgO6";
                serviceFloor=@"Floor 2";
                serviceTelNumber=@"11 22 33 44 55";
                serviceAddress=@"Services Lounge\nButik 222/Plan 1\nArne Jacobsens Alle 12\n2300 Copenhagen";
                break;
            case 21:
                serviceID=ID;
                serviceDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only.";
                serviceCenterName=kWaves;
                serviceName=@"U Service";
                serviceImgName=@"imgO7";
                serviceFloor=@"Floor 1";
                serviceTelNumber=@"11 22 33 44 55";
                serviceAddress=@"Services Lounge\nButik 222/Plan 1\nArne Jacobsens Alle 12\n2300 Copenhagen";
                break;
            case 22:
                serviceID=ID;
                serviceDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only.";
                serviceCenterName=kWaves;
                serviceName=@"V Service";
                serviceImgName=@"imgO8";
                serviceFloor=@"Floor 4";
                serviceTelNumber=@"11 22 33 44 55";
                serviceAddress=@"Services Lounge\nButik 222/Plan 1\nArne Jacobsens Alle 12\n2300 Copenhagen";
                break;
            case 23:
                serviceID=ID;
                serviceDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only.";
                serviceCenterName=kWaterfront;
                serviceName=@"W Service";
                serviceImgName=@"imgO1";
                serviceFloor=@"Floor 3";
                serviceTelNumber=@"11 22 33 44 55";
                serviceAddress=@"Services Lounge\nButik 222/Plan 1\nArne Jacobsens Alle 12\n2300 Copenhagen";
                break;
            case 24:
                serviceID=ID;
                serviceDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only.";
                serviceCenterName=kWaterfront;
                serviceName=@"X Service";
                serviceImgName=@"imgO2";
                serviceFloor=@"Floor 2";
                serviceTelNumber=@"11 22 33 44 55";
                serviceAddress=@"Services Lounge\nButik 222/Plan 1\nArne Jacobsens Alle 12\n2300 Copenhagen";
                break;
            case 25:
                serviceID=ID;
                serviceDescription=@"Receive a $25 gift card with purchase of the Margaritaville Bahamas Frozen Concoction Maker. Offer available online only.";
                serviceCenterName=kWaterfront;
                serviceName=@"Y Service";
                serviceImgName=@"imgO3";
                serviceFloor=@"Floor 1";
                serviceTelNumber=@"11 22 33 44 55";
                serviceAddress=@"Services Lounge\nButik 222/Plan 1\nArne Jacobsens Alle 12\n2300 Copenhagen";
                break;
            default:
                break;
        }
    }
    return self;
}

@end
