//
//  RewardsTransactionObject.m
//  SalamCenterApp
//
//  Created by Globit on 17/02/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import "RewardsTransactionObject.h"

@implementation RewardsTransactionObject
@synthesize transID;
@synthesize transTitle;
@synthesize transImageName;
@synthesize transDate;
@synthesize transShop;
@synthesize transPoints;
@synthesize isPositive;
-(RewardsTransactionObject*) initWithID:(NSInteger)ID
{
    self = [super init];
    if(self)
    {
        switch (ID) {
            case 0:
                transID=ID;
                transTitle=@"Royal Shoes";
                transImageName=@"offer-logo4.jpg";
                transDate=@"Feb 2, 2015";
                transShop=@"D&G";
                transPoints=450;
                isPositive=YES;
                break;
            case 1:
                transID=ID;
                transTitle=@"Red Jecket";
                transImageName=@"offer-logo1.jpeg";
                transDate=@"Feb 12, 2015";
                transShop=@"Stone Age";
                transPoints=100;
                isPositive=NO;
                break;
            case 2:
                transID=ID;
                transTitle=@"Gloves";
                transImageName=@"offer-logo2.jpg";
                transDate=@"Feb 2, 2015";
                transShop=@"Peace Chees";
                transPoints=300;
                isPositive=YES;
                break;
            case 3:
                transID=ID;
                transTitle=@"Pizza";
                transImageName=@"offer-logo3.jpg";
                transDate=@"Feb 8, 2015";
                transShop=@"Pizza Hut";
                transPoints=50;
                isPositive=NO;
                break;
        default:
                break;
        }
    }
    return self;
}
@end