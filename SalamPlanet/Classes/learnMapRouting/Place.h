//
//  Place.h
//  Find Apps
//
//  Created by M.Sharjeel on 10/06/2014.
//
//

#import <Foundation/Foundation.h>

@interface Place : NSObject

@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *locationId;
@property(nonatomic,retain)NSString *address;
@property(nonatomic)double latitude;
@property(nonatomic)double longitude;
@property(nonatomic)double rating;
@property(nonatomic,retain)NSString *reference;
@property(nonatomic,retain)NSString *photoReference;
@property(nonatomic,retain)NSString *place_id;
@property(nonatomic)int priceLevel;
@property(nonatomic,retain)NSString *iconUrl;
@property BOOL isOpen;
@property BOOL notAvailable;
@property(nonatomic) double distance;

-(id) initWithDictionary:(NSDictionary *)dictionary;

@end
