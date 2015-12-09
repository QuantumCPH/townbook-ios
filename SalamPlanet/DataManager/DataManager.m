//
//  DataManager.m
//  SalamCenterApp
//
//  Created by Waseem Asif on 14/09/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import "DataManager.h"
#import "User.h"
#import "MallCenter.h"
#import "MACategory.h"
#import "Activity.h"
#import "Offer.h"
#import "Entity.h"
#import "Shop.h"
#import "Restaurant.h"
#import "MenuCategory.h"
#import "MenuItem.h"
#import "MAService.h"
#import "EntityTiming.h"
#import "Timing.h"
#import "BannerImage.h"
#import "LoyaltyCard.h"

@interface DataManager()

- (NSURL *)applicationDocumentsDirectory;
@end

@implementation DataManager
+ (DataManager*)sharedInstance
{
    static DataManager *_sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[DataManager alloc] init];
    });
    return _sharedInstance;
}
- (instancetype)init
{
    if (self = [super init])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signOutCurrentUser) name:kUserSignOutNotification object:nil];
    }
    return self;
}
- (void)signOutCurrentUser
{
    [self deleteUserRelationalData];
    [self deleteObject:_currentUser];
    [self setCurrentUser:nil];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)deleteUserRelationalData
{
    [self deleteObjectsFromContext:self.currentUser.favouriteActivities.allObjects];
    [self deleteObjectsFromContext:self.currentUser.favouriteOffers.allObjects];
    [self deleteObjectsFromContext:self.currentUser.favouriteShops.allObjects];
    [self deleteObjectsFromContext:self.currentUser.favouriteRestaurants.allObjects];
    [self deleteObjectsFromContext:self.currentUser.selectedMalls.allObjects];
    [self deleteObjectsFromContext:self.currentUser.mainInterests.allObjects];
}
-(void)deleteObjectsFromContext :(NSArray*)objects
{
    NSManagedObjectContext *context = self.managedObjectContext;
    [objects enumerateObjectsUsingBlock:^(NSManagedObject *obj, NSUInteger idx, BOOL *stop) {
        [context deleteObject:obj];
    }];
    [self saveContext];
}

- (NSURL *)applicationDocumentsDirectory
{
    //NSLog(@"document directory :%@",[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
#pragma mark CoreData Stack
- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Mall.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";

    //NSPersistentStoreFileProtectionKey
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:@{NSMigratePersistentStoresAutomaticallyOption:@YES,NSInferMappingModelAutomaticallyOption:@YES} error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
#if DEBUG
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"ERROR" message:@"Local database error. Everything has been reset.\nIf the problem persists, please uninstall and reinstall the application." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alertView show];
#endif // DEBUG
        NSError *fileError = nil;
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:&fileError];
        _persistentStoreCoordinator = nil;
        return [self persistentStoreCoordinator];
        //abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}


- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
    }
}
-(void)deleteObject:(NSManagedObject*)object
{
    if (object)
    {
        [self.managedObjectContext deleteObject:object];
        [self saveContext];
    }
}
-(User*)currentUser
{
    User *user = nil;
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:kUserID];
    if (userID) {
        user = [self userWithId:userID];
    }
    return user;
}

- (User*)userWithId:(NSString*)userId
{
    User *user = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    request.predicate = [NSPredicate predicateWithFormat:@"userId = %@", userId];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!error)
    {
        if (results.count>0) {
            user = results.firstObject;
        }
        else
        {
            user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.managedObjectContext];
            user.userId = userId;
        }
    }
    else
    {
        NSLog(@"error:%@",[error localizedDescription]);
    }
    return user;
}
- (MallCenter*)mallCenterWithMallPlaceId:(NSString*)mallPlaceId
{
    MallCenter *mallCenter = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"MallCenter"];
    request.predicate = [NSPredicate predicateWithFormat:@"mallPlaceId = %@", mallPlaceId];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!error)
    {
        if (results.count>0) {
            mallCenter = results.firstObject;
        }
        else
        {
            mallCenter = [NSEntityDescription insertNewObjectForEntityForName:@"MallCenter" inManagedObjectContext:self.managedObjectContext];
            mallCenter.mallPlaceId = mallPlaceId;
        }
    }
    else
    {
        NSLog(@"error:%@",[error localizedDescription]);
    }
    return mallCenter;
}
- (MACategory*)categoryWithID:(NSString *)categoryId
{
    MACategory * maCategory = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"MACategory"];
    request.predicate = [NSPredicate predicateWithFormat:@"categoryId = %@", categoryId];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!error)
    {
        if (results.count>0) {
            maCategory = results.firstObject;
        }
        else
        {
            maCategory = [NSEntityDescription insertNewObjectForEntityForName:@"MACategory" inManagedObjectContext:self.managedObjectContext];
            maCategory.categoryId = categoryId;
        }
    }
    else
    {
        NSLog(@"error:%@",[error localizedDescription]);
    }
    return maCategory;
}
- (Activity*)activityWithId:(NSString*)activityId
{
    Activity *activity = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Activity"];
    request.predicate = [NSPredicate predicateWithFormat:@"activityId = %@", activityId];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!error)
    {
        if (results.count>0) {
            activity = results.firstObject;
        }
        else
        {
            activity = [NSEntityDescription insertNewObjectForEntityForName:@"Activity" inManagedObjectContext:self.managedObjectContext];
            activity.activityId = activityId;
        }
    }
    else
    {
        NSLog(@"error:%@",[error localizedDescription]);
    }
    return activity;

}
- (Offer*)offerWithId:(NSString*)activityId
{
    Offer *offer = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Offer"];
    request.predicate = [NSPredicate predicateWithFormat:@"activityId = %@", activityId];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!error)
    {
        if (results.count>0) {
            offer = results.firstObject;
        }
        else
        {
            offer = [NSEntityDescription insertNewObjectForEntityForName:@"Offer" inManagedObjectContext:self.managedObjectContext];
            offer.activityId = activityId;
        }
    }
    else
    {
        NSLog(@"error:%@",[error localizedDescription]);
    }
    return offer;
}
- (Entity*)entityWithId:(NSString*)entityId
{
    Entity *entity = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Entity"];
    request.predicate = [NSPredicate predicateWithFormat:@"entityId = %@", entityId];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!error)
    {
        if (results.count>0) {
            entity = results.firstObject;
        }
        else
        {
            entity = [NSEntityDescription insertNewObjectForEntityForName:@"Entity" inManagedObjectContext:self.managedObjectContext];
            entity.entityId = entityId;
        }
    }
    else
    {
        NSLog(@"error:%@",[error localizedDescription]);
    }
    return entity;

}
- (Shop*)shopWithId:(NSString*)shopId
{
    Shop *shop = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Shop"];
    request.predicate = [NSPredicate predicateWithFormat:@"entityId = %@",shopId];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!error)
    {
        if (results.count>0) {
            shop = results.firstObject;
        }
        else
        {
            shop = [NSEntityDescription insertNewObjectForEntityForName:@"Shop" inManagedObjectContext:self.managedObjectContext];
            shop.entityId = shopId;
            shop.entityType = @"Shop";
        }
    }
    else
    {
        NSLog(@"error:%@",[error localizedDescription]);
    }
    return shop;
}
- (Restaurant*)restaurantWithId:(NSString*)restaurantId
{
    Restaurant *restaurant = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Restaurant"];
    request.predicate = [NSPredicate predicateWithFormat:@"entityId = %@",restaurantId];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!error)
    {
        if (results.count>0) {
            restaurant = results.firstObject;
        }
        else
        {
            restaurant = [NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:self.managedObjectContext];
            restaurant.entityId = restaurantId;
            restaurant.entityType = @"Restaurant";
        }
    }
    else
    {
        NSLog(@"error:%@",[error localizedDescription]);
    }
    return restaurant;
}
- (MenuCategory*)menuCategoryWithId:(NSString*)menuCategoryId
{
    MenuCategory *menuCategory = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"MenuCategory"];
    request.predicate = [NSPredicate predicateWithFormat:@"menuCategoryId = %@",menuCategoryId];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!error)
    {
        if (results.count>0) {
            menuCategory = results.firstObject;
        }
        else
        {
            menuCategory = [NSEntityDescription insertNewObjectForEntityForName:@"MenuCategory" inManagedObjectContext:self.managedObjectContext];
            menuCategory.menuCategoryId = menuCategoryId;
        }
    }
    else
    {
        NSLog(@"error:%@",[error localizedDescription]);
    }
    return menuCategory;

}
- (MenuItem *)menuItemWithId:(NSString*)menuItemId
{
    MenuItem *menuItem = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"MenuItem"];
    request.predicate = [NSPredicate predicateWithFormat:@"menuItemId = %@",menuItemId];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!error)
    {
        if (results.count>0) {
            menuItem = results.firstObject;
        }
        else
        {
            menuItem = [NSEntityDescription insertNewObjectForEntityForName:@"MenuItem" inManagedObjectContext:self.managedObjectContext];
            menuItem.menuItemId = menuItemId;
        }
    }
    else
    {
        NSLog(@"error:%@",[error localizedDescription]);
    }
    return menuItem;

}
- (MAService *)serviceWithId:(NSString*)serviceId
{
    MAService *service = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"MAService"];
    request.predicate = [NSPredicate predicateWithFormat:@"serviceId = %@",serviceId];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!error)
    {
        if (results.count>0) {
            service = results.firstObject;
        }
        else
        {
            service = [NSEntityDescription insertNewObjectForEntityForName:@"MAService" inManagedObjectContext:self.managedObjectContext];
            service.serviceId = serviceId;
        }
    }
    else
    {
        NSLog(@"error:%@",[error localizedDescription]);
    }
    return service;
}
- (EntityTiming *)entityTimingWithId:(NSString*)entityId
{
    EntityTiming *entityTiming = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"EntityTiming"];
    request.predicate = [NSPredicate predicateWithFormat:@"entityId = %@",entityId];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!error)
    {
        if (results.count>0) {
            entityTiming = results.firstObject;
        }
        else
        {
            entityTiming = [NSEntityDescription insertNewObjectForEntityForName:@"EntityTiming" inManagedObjectContext:self.managedObjectContext];
            entityTiming.entityId = entityId;
        }
    }
    else
    {
        NSLog(@"error:%@",[error localizedDescription]);
    }
    return entityTiming;
}
- (Timing *)timingWithId:(NSString*)timingId
{
    Timing *timing = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Timing"];
    request.predicate = [NSPredicate predicateWithFormat:@"timingId = %@",timingId];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!error)
    {
        if (results.count>0) {
            timing = results.firstObject;
        }
        else
        {
            timing = [NSEntityDescription insertNewObjectForEntityForName:@"Timing" inManagedObjectContext:self.managedObjectContext];
            timing.timingId = timingId;
        }
    }
    else
    {
        NSLog(@"error:%@",[error localizedDescription]);
    }
    return timing;
}
- (BannerImage *)bannerImageWithId:(NSString*)bannerId
{
    BannerImage *bannerImg = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"BannerImage"];
    request.predicate = [NSPredicate predicateWithFormat:@"bannerId = %@",bannerId];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!error)
    {
        if (results.count>0) {
            bannerImg = results.firstObject;
        }
        else
        {
            bannerImg = [NSEntityDescription insertNewObjectForEntityForName:@"BannerImage" inManagedObjectContext:self.managedObjectContext];
            bannerImg.bannerId = bannerId;
        }
    }
    else
    {
        NSLog(@"error:%@",[error localizedDescription]);
    }
    return bannerImg;
}
- (LoyaltyCard *)loyaltyCardWithId:(NSString*)cardId
{
    LoyaltyCard * loyaltyCard = nil;
    if (cardId)
    {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"LoyaltyCard"];
        request.predicate = [NSPredicate predicateWithFormat:@"cardId = %@",cardId];
        
        NSError *error = nil;
        NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
        if (!error)
        {
            if (results.count>0) {
                loyaltyCard = results.firstObject;
            }
            else
            {
                loyaltyCard = [NSEntityDescription insertNewObjectForEntityForName:@"LoyaltyCard" inManagedObjectContext:self.managedObjectContext];
                loyaltyCard.cardId = cardId;
            }
        }
        else
        {
            NSLog(@"error:%@",[error localizedDescription]);
        }
    }
    else
    {
        loyaltyCard = [NSEntityDescription insertNewObjectForEntityForName:@"LoyaltyCard" inManagedObjectContext:self.managedObjectContext];
    }
    return loyaltyCard;
}
@end
