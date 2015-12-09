//
//  PlaceDetails.h
//  Find Apps
//
//  Created by M.Sharjeel on 13/06/2014.
//
//

#import <Foundation/Foundation.h>

@interface PlaceDetails : NSObject

@property(nonatomic,retain)NSString *isOpen;
@property(nonatomic,retain)NSString *phoneNumber;
@property(nonatomic,retain)NSString *internationalPhoneNumber;
@property(nonatomic,retain)NSString *website;
@property(nonatomic,retain)NSMutableArray *reviews;
@property(nonatomic,retain)NSMutableArray *timings;

-(id) initWithDictionary:(NSDictionary *)dictionary;

@end
