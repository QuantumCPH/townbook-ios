//
//  User.h
//  SalamCenterApp
//
//  Created by Waseem Asif on 03/12/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Activity, LoyaltyCard, MACategory, MallCenter, Offer, Restaurant, Shop;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * authToken;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSDate * dateOfBirth;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * imageDataString;
@property (nonatomic, retain) NSString * imageLocalPath;
@property (nonatomic) BOOL isMale;
@property (nonatomic) BOOL isNotificationAllowed;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic, retain) NSString * mobileNumber;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * street;
@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSSet *favouriteActivities;
@property (nonatomic, retain) NSSet *favouriteOffers;
@property (nonatomic, retain) NSSet *favouriteRestaurants;
@property (nonatomic, retain) NSSet *favouriteShops;
@property (nonatomic, retain) NSSet *loyaltyCards;
@property (nonatomic, retain) NSSet *mainInterests;
@property (nonatomic, retain) NSSet *selectedMalls;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addFavouriteActivitiesObject:(Activity *)value;
- (void)removeFavouriteActivitiesObject:(Activity *)value;
- (void)addFavouriteActivities:(NSSet *)values;
- (void)removeFavouriteActivities:(NSSet *)values;

- (void)addFavouriteOffersObject:(Offer *)value;
- (void)removeFavouriteOffersObject:(Offer *)value;
- (void)addFavouriteOffers:(NSSet *)values;
- (void)removeFavouriteOffers:(NSSet *)values;

- (void)addFavouriteRestaurantsObject:(Restaurant *)value;
- (void)removeFavouriteRestaurantsObject:(Restaurant *)value;
- (void)addFavouriteRestaurants:(NSSet *)values;
- (void)removeFavouriteRestaurants:(NSSet *)values;

- (void)addFavouriteShopsObject:(Shop *)value;
- (void)removeFavouriteShopsObject:(Shop *)value;
- (void)addFavouriteShops:(NSSet *)values;
- (void)removeFavouriteShops:(NSSet *)values;

- (void)addLoyaltyCardsObject:(LoyaltyCard *)value;
- (void)removeLoyaltyCardsObject:(LoyaltyCard *)value;
- (void)addLoyaltyCards:(NSSet *)values;
- (void)removeLoyaltyCards:(NSSet *)values;

- (void)addMainInterestsObject:(MACategory *)value;
- (void)removeMainInterestsObject:(MACategory *)value;
- (void)addMainInterests:(NSSet *)values;
- (void)removeMainInterests:(NSSet *)values;

- (void)addSelectedMallsObject:(MallCenter *)value;
- (void)removeSelectedMallsObject:(MallCenter *)value;
- (void)addSelectedMalls:(NSSet *)values;
- (void)removeSelectedMalls:(NSSet *)values;

@end
