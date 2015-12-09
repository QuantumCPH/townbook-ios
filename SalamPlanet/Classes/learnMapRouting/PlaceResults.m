//
//  PlaceResults.m
//  Find Apps
//
//  Created by M.Sharjeel on 10/06/2014.
//
//

#import "PlaceResults.h"


@implementation PlaceResults
@synthesize placesArray;

-(id) init
{
	if((self=[super init]))
	{
        self.placesArray = [[NSMutableArray alloc] init];
    }
	return self;
}

-(id) initWithDictionary:(NSDictionary *)dictionary
{
	if((self=[super init]))
	{
        if([[dictionary objectForKey:@"results"] count] > 0)
        {
            self.placesArray = [NSMutableArray array];
            NSArray *results = [dictionary objectForKey:@"results"];
            for(int i = 0; i < results.count; i ++)
            {
                Place *eachPlace = [[Place alloc] initWithDictionary:[results objectAtIndex:i]];
                [self.placesArray addObject:eachPlace];
            }
        }
    }
	return self;
}
@end
