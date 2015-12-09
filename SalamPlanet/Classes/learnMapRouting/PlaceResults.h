//
//  PlaceResults.h
//  Find Apps
//
//  Created by M.Sharjeel on 10/06/2014.
//
//

#import <Foundation/Foundation.h>
#import "Place.h"

@interface PlaceResults : NSObject

@property(nonatomic,strong)NSMutableArray *placesArray;

-(id) initWithDictionary:(NSDictionary *)dictionary;
@end
