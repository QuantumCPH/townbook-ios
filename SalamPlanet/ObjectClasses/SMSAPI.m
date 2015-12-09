//
//  SMSAPI.m
//  SalamPlanet
//
//  Created by Globit on 16/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "SMSAPI.h"
#import "AFNetworking.h"

#define kBaseURL    @"http://smpp5.routesms.com:8080/bulksms/sendsms?"
#define kGenericUsername    @"zapna1"
#define kGenericPassword    @"lghanymb"
#define kGenericSource      @"Zerocall"
#define kGenericDLR         @"1"
#define kGenericType        @"0"

#define kUsername   @"username"
#define kPassword   @"password"
#define kSource     @"source"
#define kDLR        @"dlr"
#define kType       @"type"
#define kDestination    @"destination"
#define kMessage    @"message"

@implementation SMSAPI
@synthesize delegate;
-(id)init{
    self=[super init];
    if (self) {
    }
    return self;
}
-(void)callDelegateSentMessageSuccessfully{
    [delegate smsSentSuccessfully];
}
-(void)callDelegateSentMessageFailed{
    [delegate smsSentFailed];
}
-(void)sendSMSWebserviceOnNumber:(NSString *)number{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:kGenericUsername forKey:kUsername];
    [params setObject:kGenericPassword forKey:kPassword];
    [params setObject:kGenericSource   forKey:kSource];
    [params setObject:kGenericDLR  forKey:kDLR];
    [params setObject:kGenericType forKey:kType];
    [params setObject:number forKey:kDestination];
    [params setObject:@"Your Salam code is:3730.\nClose this message and enter the code into Salam app to activate your account." forKey:kMessage];
    
    
    [manager POST:kBaseURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self performSelectorOnMainThread:@selector(callDelegateSentMessageSuccessfully) withObject:nil waitUntilDone:NO];
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self performSelectorOnMainThread:@selector(callDelegateSentMessageFailed) withObject:nil waitUntilDone:NO];
        NSLog(@"Error: %@", error);
    }];
}

@end
