//
//  Place.m
//  Find Apps
//
//  Created by M.Sharjeel on 10/06/2014.
//
//

#import "Place.h"

@implementation Place
@synthesize name,locationId,address,latitude,longitude,rating,reference,photoReference,iconUrl,priceLevel,isOpen,notAvailable, place_id, distance;

-(id) initWithDictionary:(NSDictionary *)dictionary
{
	if((self=[super init]))
	{
        self.name = [dictionary objectForKey:@"name"];
		self.place_id = [dictionary objectForKey:@"place_id"];
        self.locationId = [dictionary objectForKey:@"id"];
        self.latitude = [[[[dictionary objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lat"] doubleValue];
        self.longitude = [[[[dictionary objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lng"] doubleValue];
        if([[dictionary objectForKey:@"vicinity"] length] > 0)
            self.address = [dictionary objectForKey:@"vicinity"];
        else
            self.address = [dictionary objectForKey:@"formatted_address"];
        self.rating = [[dictionary objectForKey:@"rating"] doubleValue];
        self.reference = [dictionary objectForKey:@"reference"];
        
        if ([[dictionary objectForKey:@"photos"] count] > 0)
        {
            self.photoReference = [[[dictionary objectForKey:@"photos"] objectAtIndex:0] objectForKey:@"photo_reference"];
        }
        
        self.iconUrl = [dictionary objectForKey:@"icon"];
        self.priceLevel = [[dictionary objectForKey:@"price_level"] integerValue];
        
        self.isOpen = NO;
        self.notAvailable = YES;
        
        if([[dictionary objectForKey:@"opening_hours"] count] > 0)
            self.isOpen = [[[dictionary objectForKey:@"opening_hours"] objectForKey:@"open_now"] boolValue];
        else
            self.notAvailable = NO;
		
		self.distance = 0.0;
    }
	return self;
}


@end
