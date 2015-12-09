//
//  SMSAPI.h
//  SalamPlanet
//
//  Created by Globit on 16/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol SMSAPIDelegate
-(void)smsSentSuccessfully;
-(void)smsSentFailed;
@end
@interface SMSAPI : NSObject
@property (weak, nonatomic) id<SMSAPIDelegate> delegate;

-(void)sendSMSWebserviceOnNumber:(NSString *)number;
@end
