//
//  EndorsementUser.m
//  SalamPlanet
//
//  Created by Saad Khan on 19/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "EndorsementUser.h"

@implementation EndorsementUser

-(EndorsementUser*) initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    if(self)
    {
        
    }
    return  self;
}
-(EndorsementUser*) initWithDummy
{
    self = [super init];
    if(self)
    {
        self.userID=@"01";
        self.userName=@"Imran Khan";
        self.userPicURL=@"parallax_avatar.png";
    }
    return  self;
}
@end
