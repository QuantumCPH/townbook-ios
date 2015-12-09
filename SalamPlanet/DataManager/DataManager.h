//
//  DataManager.h
//  SalamCenterApp
//
//  Created by Waseem Asif on 14/09/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreData;

@class User;
@class MallCenter;
@class MACategory;
@class Activity;
@class Offer;
@class Entity;
@class Shop;
@class Restaurant;
@class MenuCategory;
@class MenuItem;
@class MAService;
@class EntityTiming;
@class Timing;
@class BannerImage;
@class LoyaltyCard;

@interface DataManager : NSObject


@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong,nonatomic) User *currentUser;
@property (strong,nonatomic) MallCenter *currentMall;
+(DataManager*)sharedInstance;


- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;
- (void)deleteObject:(NSManagedObject*)object;

- (User*)userWithId:(NSString*)userId;
- (MallCenter*)mallCenterWithMallPlaceId:(NSString*)mallPlaceId;
- (MACategory*)categoryWithID:(NSString *)categoryId;
- (Activity*)activityWithId:(NSString*)activityId;
- (Offer*)offerWithId:(NSString*)activityId;
- (Entity*)entityWithId:(NSString*)entityId;
- (Shop*)shopWithId:(NSString*)shopId;
- (Restaurant*)restaurantWithId:(NSString*)restaurantId;
- (MenuCategory*)menuCategoryWithId:(NSString*)menuCategoryId;
- (MenuItem *)menuItemWithId:(NSString*)menuItemId;
- (MAService *)serviceWithId:(NSString*)serviceId;
- (EntityTiming*)entityTimingWithId:(NSString*)entityId;
- (Timing *)timingWithId:(NSString*)timingId;
- (BannerImage *)bannerImageWithId:(NSString*)bannerId;
- (LoyaltyCard *)loyaltyCardWithId:(NSString*)cardId;

@end
