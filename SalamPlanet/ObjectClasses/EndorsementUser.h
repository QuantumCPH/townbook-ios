//
//  EndorsementUser.h
//  SalamPlanet
//
//  Created by Saad Khan on 19/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EndorsementUser : NSObject

@property (nonatomic, strong) NSString * userID;
@property (nonatomic, strong) NSString * userName;
@property (nonatomic, strong) NSString * userPicURL;

-(EndorsementUser*) initWithDictionary:(NSDictionary*)dict;
-(EndorsementUser*) initWithDummy;
@end
