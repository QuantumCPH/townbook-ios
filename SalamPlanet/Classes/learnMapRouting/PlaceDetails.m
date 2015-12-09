//
//  PlaceDetails.m
//  Find Apps
//
//  Created by M.Sharjeel on 13/06/2014.
//
//

#import "PlaceDetails.h"

@implementation PlaceDetails
@synthesize isOpen,phoneNumber,internationalPhoneNumber,website,reviews,timings;
-(id) initWithDictionary:(NSDictionary *)dictionary
{
	if((self=[super init]))
	{
        self.isOpen = @"No";
        if([[dictionary objectForKey:@"opening_hours"] count] > 0)
        {
            if([[dictionary objectForKey:@"opening_hours"] objectForKey:@"open_now"])
            {
                self.isOpen = @"Yes";
            }
            if([[[dictionary objectForKey:@"opening_hours"] objectForKey:@"periods"] length] > 0)
            {
//                for(int i =0;i<jsonTimings.length();i++) {
//                    PlaceTiming timing = new PlaceTiming(jsonTimings.getJSONObject(i));
//                    mTimings.add(timing);
//                }
            }
        }
        self.website = [dictionary objectForKey:@"website"];
        self.phoneNumber = [dictionary objectForKey:@"formatted_phone_number"];
        self.internationalPhoneNumber = [dictionary objectForKey:@"international_phone_number"];
    }
	return self;
}

@end
