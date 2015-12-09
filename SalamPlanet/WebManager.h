//
//  WebManager.h
//  SalamCenterApp
//
//  Created by Waseem Asif on 11/09/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <Foundation/Foundation.h>


@class User;
@class Shop;
@class Restaurant;
@class LoyaltyCard;
@class MallCenter;

@interface WebManager : NSObject

@property (nonatomic,strong) NSString *languageID;

+ (WebManager *)sharedInstance;
- (void)registerUserByPhoneNumber:(NSString*)number
                          success:(void (^)(NSString* verifCode))success
                          failure:(void (^)(NSError* error))failure;

- (void)registerUserByFacebookId:(NSString*)fbID
                         success:(void (^)(id response))success
                         failure:(void (^)(NSError* error))failure;

- (void)verifyCode:(NSString*)verifCode
   withPhoneNumber:(NSString*)number
           success:(void (^)(id response))success
           failure:(void (^)(NSString* error))failure;

- (void)saveUserProfileOnServer:(User*)user
                        success:(void (^)(id response))success
                        failure:(void (^)(NSError* error))failure;

- (void)getCurrentUserProfile:(void (^)(id response))success
                      failure:(void (^)(NSError* error))failure;

- (void)getMallsList:(void (^)(NSArray* resultArray))success
             failure:(void (^)(NSString* errorString))failure;

- (void)loadDetailsOfMall:(NSString*)mallPlaceId
                  success:(void (^)(MallCenter * mall,NSString *message))success
                  failure:(void (^)(NSString* errorString))failure;

- (void)saveSelectedMalls:(NSString*)mallPlaceIds
                  success:(void (^)(id response))success
                  failure:(void (^)(NSError* error))failure;
- (void)getSelectedMalls:(void (^)(NSArray* resultArray))success
                 failure:(void (^)(NSError* error))failure;

- (void)getInterestsList:(void (^)(NSArray* resultArray))success
                 failure:(void (^)(NSError* error))failure;

- (void)saveSelectedInterests:(NSString*)categoriesIDs
                      success:(void (^)(id response))success
                      failure:(void (^)(NSError* error))failure;

- (void)getSelectedInterests:(void (^)(NSArray* resultArray))success
                     failure:(void (^)(NSError* error))failure;

- (void)getOffersListPageNumber:(int)pageNumber forMall:(NSString*)mallPlaceId
                        success:(void (^)(NSArray* resultArray,int totalRecords))success
                        failure:(void (^)(NSError* error))failure;

- (void)markActivity:(NSString*)activityId favouriteDeleted:(BOOL)isDeleted
             success:(void (^)(id response))success
             failure:(void (^)(NSString* errorString))failure;
- (void)loadDetailsOfActivity:(NSString*)activityId
                      success:(void (^)(id response))success
                      failure:(void (^)(NSString* errorString))failure;

- (void)getShopsList:(void (^)(NSArray* resultArray))success
             failure:(void (^)(NSString* errorString))failure;

- (void)markEntity:(NSString*)enityId isShop:(BOOL)isShop
  favouriteDeleted:(BOOL)isDeleted
           success:(void (^)(id response))success
           failure:(void (^)(NSString* errorString))failure;

- (void)loadDetailsOfShop:(NSString*)shopId
                  success:(void (^)(Shop * shop,NSString *message))success
                  failure:(void (^)(NSString* errorString))failure;
- (void)getFeaturedEntitiesForShop:(NSString*)shopId
                           success:(void (^)(NSArray *resultArray,NSString *message))success
                           failure:(void (^)(NSString* errorString))failure;
- (void)getRestaurantList:(void (^)(NSArray* resultArray))success
                  failure:(void (^)(NSString* errorString))failure;

- (void)loadDetailsOfRestaurant:(NSString*)mallRestaurantId
                        success:(void (^)(Restaurant * restaurant,NSString *message))success
                        failure:(void (^)(NSString* errorString))failure;
- (void)getMenuListOfRestaurant:(NSString*)mallRestaurantId
                        success:(void (^)(NSArray *resultArray,NSString *message))success
                        failure:(void (^)(NSString* errorString))failure;

- (void)getServicesList:(void (^)(NSArray *resultArray,NSString *message))success
                failure:(void (^)(NSString* errorString))failure;

- (void)getMallTimingList:(void (^)(NSArray *resultArray,NSString *message))success
                  failure:(void (^)(NSString* errorString))failure;
- (void)sendDeviceTokenForPushNotification;
- (void)changeNotificationPreference:(BOOL)isEnabled
                             success:(void (^)(NSString *message))success
                             failure:(void (^)(NSString* errorString))failure;
- (void)signOutUser:(void (^)(NSString *message))success
            failure:(void (^)(NSString* errorString))failure;

- (void)saveLoyaltyCardOnServer:(LoyaltyCard*)loyaltyCard
                        success:(void (^)(NSString* message))success
                        failure:(void (^)(NSString* errorString))failure;

- (void)logVisitOfEntity:(id)entity;
//                 success:(void (^)(NSString *message))success
//                 failure:(void (^)(NSString* errorString))failure;

@end
