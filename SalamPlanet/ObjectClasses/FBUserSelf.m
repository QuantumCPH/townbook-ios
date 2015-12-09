//
//  FBUserSelf.m
//  SalamPlanet
//
//  Created by Saad Khan on 04/11/2014.
//  Copyright (c) 2014 SalamPlanet. All rights reserved.
//

#import "FBUserSelf.h"

@implementation FBUserSelf
-(FBUserSelf*) initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    if (![dict isKindOfClass:[NSDictionary class]])
    {
        return self;
    }
    if(self)
    {
        if([dict valueForKey:@"id"])
        {
            if(![[NSNull null]isEqual:[dict valueForKey:@"id"]])
            {
                self.fbiD=[dict valueForKey:@"id"];
            }
        }
        if([dict valueForKey:@"birthday"])
        {
            if(![[NSNull null]isEqual:[dict valueForKey:@"birthday"]])
            {
                self.dob =[UtilsFunctions getFormattedDateFromString:[dict valueForKey:@"birthday"]];
            }
        }
        if([dict valueForKey:@"email"])
        {
            if(![[NSNull null]isEqual:[dict valueForKey:@"email"]])
            {
                self.email=[dict valueForKey:@"email"];
            }
        }
        if([dict valueForKey:@"first_name"])
        {
            if(![[NSNull null]isEqual:[dict valueForKey:@"first_name"]])
            {
                self.firstName=[dict valueForKey:@"first_name"];
            }
        }
        if([dict valueForKey:@"gender"])
        {
            if(![[NSNull null]isEqual:[dict valueForKey:@"gender"]])
            {
                self.gender=[dict valueForKey:@"gender"];
            }
        }
        if([dict valueForKey:@"last_name"])
        {
            if(![[NSNull null]isEqual:[dict valueForKey:@"last_name"]])
            {
                self.lastName=[dict valueForKey:@"last_name"];
            }
        }
        if([dict valueForKey:@"name"])
        {
            if(![[NSNull null]isEqual:[dict valueForKey:@"name"]])
            {
                self.displayName=[dict valueForKey:@"name"];
            }
        }
        if([dict valueForKey:@"username"])
        {
            if(![[NSNull null]isEqual:[dict valueForKey:@"username"]])
            {
                self.userName=[dict valueForKey:@"username"];
            }
        }

        if([dict valueForKey:@"link"])
        {
            if(![[NSNull null]isEqual:[dict valueForKey:@"link"]])
            {
                self.link=[dict valueForKey:@"link"];
            }
        }
        if ([dict valueForKey:@"education"]) {
            if(![[NSNull null]isEqual:[dict objectForKey:@"education"]]){
                NSArray * eduArray=[dict valueForKey:@"education"];
                if (eduArray.count>0) {
                    NSDictionary * lastObj=[eduArray lastObject];
                    if ([lastObj valueForKey:@"school"]) {
                        NSDictionary * schoolName=[lastObj valueForKey:@"school"];
                        if ([schoolName valueForKey:@"name"]) {
                            self.education=[schoolName valueForKey:@"name"];
                        }
                    }
                }
            }
        }
        if([dict objectForKey:@"location"])
        {
            if(![[NSNull null]isEqual:[dict objectForKey:@"location"]])
            {
                NSDictionary * locationDict = (NSDictionary *)[dict objectForKey:@"location"];
                if([locationDict valueForKey:@"name"])
                {
                    if(![[NSNull null]isEqual:[locationDict valueForKey:@"name"]])
                    {
                        self.location=[locationDict valueForKey:@"name"];
                    }
                }
            }
        }
        self.profileImageURL=[NSString stringWithFormat:@"%@%@%@",@"https://graph.facebook.com/",self.fbiD,@"/picture?type=large"];
    }
    return  self;
}
@end
