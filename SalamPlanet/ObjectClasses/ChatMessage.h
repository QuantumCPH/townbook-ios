//
//  ChatMessage.h
//  SalamPlanet
//
//  Created by Globit on 13/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatMessage : NSObject

@property (nonatomic, strong) NSString * msgText;
@property (nonatomic, strong) UIImage * msgImg;
@property (nonatomic, strong) NSString * timeStamp;
@property (nonatomic)MessageType messageType;
@property (nonatomic)DeliveryStatus deliveryStatus;
@property (nonatomic,strong) NSDictionary * uOfferShopDict;

-(ChatMessage*) initWithImage:(UIImage *)img;
-(ChatMessage*) initWithText:(NSString *)txt;
-(ChatMessage*) initWithEndore;
-(ChatMessage *) initWithOffer:(NSDictionary *)dict;
-(ChatMessage *) initWithUShop:(NSDictionary *)dict;
@end
