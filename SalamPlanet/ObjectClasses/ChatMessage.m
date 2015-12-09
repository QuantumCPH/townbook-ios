//
//  ChatMessage.m
//  SalamPlanet
//
//  Created by Globit on 13/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "ChatMessage.h"

@implementation ChatMessage
@synthesize messageType;
@synthesize deliveryStatus;
-(ChatMessage*) initWithText:(NSString *)txt
{
    self = [super init];
    if(self)
    {
        self.msgText=txt;
        messageType=Text;
        deliveryStatus=Sent;
    }
    return  self;
}
-(ChatMessage*) initWithImage:(UIImage *)img
{
    self = [super init];
    if(self)
    {
        self.msgImg=img;
        messageType=Image;
        deliveryStatus=Sent;
    }
    return  self;
}
-(ChatMessage*) initWithEndore
{
    self = [super init];
    if(self)
    {
        messageType=Endore;
        deliveryStatus=Sent;
    }
    return  self;
}
-(ChatMessage *) initWithOffer:(NSDictionary *)dict{
    self = [super init];
    if(self)
    {
        messageType=UOffer;
        self.uOfferShopDict=[[NSDictionary alloc]initWithDictionary:dict];
        deliveryStatus=Sent;
    }
    return  self;
}
-(ChatMessage *) initWithUShop:(NSDictionary *)dict{
    self = [super init];
    if(self)
    {
        messageType=UShop;
        self.uOfferShopDict=[[NSDictionary alloc]initWithDictionary:dict];
        deliveryStatus=Sent;
    }
    return  self;
}
@end
