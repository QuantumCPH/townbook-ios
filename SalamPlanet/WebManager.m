//
//  WebManager.m
//  SalamCenterApp
//
//  Created by Waseem Asif on 11/09/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import "WebManager.h"
#import "Constants.h"
#import "AFNetworking.h"
#import "DataManager.h"
#import "UtilsFunctions.h"
#import "User.h"
#import "MallCenter.h"
#import "MACategory.h"
#import "Offer.h"
#import "Activity.h"
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


#define kSendAuthTokenKey     @"Auth-Token"

@interface WebManager()

@end

@implementation WebManager

+ (WebManager *)sharedInstance
{
    static WebManager *_sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[WebManager alloc] init];
    });
    return _sharedInstance;
}
- (instancetype)init
{
    if (self = [super init])
    {
        _languageID = @"1";
    }
    return self;
}
- (AFHTTPRequestOperationManager *)getReguestManager
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    User *user = [[DataManager sharedInstance] currentUser];
    [manager.requestSerializer setValue:user.authToken forHTTPHeaderField:kSendAuthTokenKey];
    return manager;
}
- (void)registerUserByPhoneNumber:(NSString*)number
                          success:(void (^)(NSString* verifCode))success
                          failure:(void (^)(NSError* error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlString = [NSString stringWithFormat:@"%@Account/Register/%@",APIBaseURL,number];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id response) {
        NSDictionary *responseDic = (NSDictionary*)response;
        NSString *verificationCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"code"]];
        success(verificationCode);
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    
}
- (void)registerUserByFacebookId:(NSString*)fbID
                         success:(void (^)(id response))success
                         failure:(void (^)(NSError* error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlString = [NSString stringWithFormat:@"%@Account/RegisterUser/%@",APIBaseURL,fbID];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id response) {
        NSDictionary *responseDic = (NSDictionary*)response;
        [self parseUserResponse:responseDic];
        success(responseDic);
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         failure(error);
    }];

}
- (void)verifyCode:(NSString*)verifCode
   withPhoneNumber:(NSString*)number
           success:(void (^)(id response))success
           failure:(void (^)(NSString* error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    NSDictionary *params = @{@"code":verifCode,@"mobileNo":number};
    NSString *urlString = [NSString stringWithFormat:@"%@Account/verifyCode",APIBaseURL];
    [manager POST:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDic = (NSDictionary*)responseObject;
        [self parseUserResponse:responseDic];
        success(responseDic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorString = [error localizedDescription];
        if (operation.responseObject)
        {
            id message = operation.responseObject[kMessage];
            if (message != [NSNull null])
                errorString = message;
        }
        failure(errorString);
    }];
}

- (void)saveUserProfileOnServer:(User*)user
                        success:(void (^)(id response))success
                        failure:(void (^)(NSError* error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:user.authToken forHTTPHeaderField:kSendAuthTokenKey];

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:user.userId forKey:kUserID];
//    [params setValue:user.firstName forKey:@"FirstName"];
//    [params setValue:user.lastName forKey:@"LastName"];
    [params setValue:user.name forKey:@"FullName"];
    [params setValue:user.email forKey:@"Email"];
    [params setValue:[UtilsFunctions getUTCFormatDate:user.dateOfBirth] forKey:@"DOB"];
    [params setValue:user.imageDataString forKey:@"ImageBase64String"];
    //[params setValue:user.city forKey:@"CityName"];
    [params setValue:[user.country uppercaseString] forKey:@"CountryCode"];
    [params setValue:[@(user.latitude) stringValue] forKey:@"Latitude"];
    [params setValue:[@(user.longitude) stringValue] forKey:@"Longitude"];
    [params setValue:user.isMale ? @"Male":@"Female" forKey:@"Gender"];
    [params setValue:@"1" forKey:@"DeviceType"];//1 corresponds to iOS devices on server
    [params setValue:user.city forKey:kCityName];
 
    NSString *urlString = [NSString stringWithFormat:@"%@Account/UpdateProfile",APIBaseURL];
    
    [manager POST:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDic = (NSDictionary*)responseObject;
        NSLog(@"%@",responseDic);
      
        success(responseDic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        failure(error);
    }];

}
- (void)getCurrentUserProfile:(void (^)(id response))success
                      failure:(void (^)(NSError* error))failure
{
    AFHTTPRequestOperationManager *manager = [self getReguestManager];
    NSString *urlString = [NSString stringWithFormat:@"%@Account/GetProfile/",APIBaseURL];
    [manager POST:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *reponse = (NSDictionary*)responseObject;
         BOOL successFlag = [[reponse valueForKey:@"Success"] boolValue];
         if (successFlag) {
             NSDictionary *profileDic = [reponse objectForKey:@"Profile"];
             [self parseUserProfileResponse:profileDic];
             success(responseObject);
         }
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Existing user getProfile:%@",error);
         failure(error);
     }];
    
}

#pragma mark -Malls
- (void)getMallsList:(void (^)(NSArray* resultArray))success
             failure:(void (^)(NSString* errorString))failure{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    User *user = [[DataManager sharedInstance] currentUser];
    [manager.requestSerializer setValue:user.authToken forHTTPHeaderField:kSendAuthTokenKey];
    NSString *urlString = [NSString stringWithFormat:@"%@MallService/GetMalls?countryCode=%@&languageId=%@",APIBaseURL,user.country,_languageID];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"%@",responseObject);
        [self saveAllInterests];
        NSArray *malls = [self parseMallListResponse:responseObject];
        success(malls);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorString = [error localizedDescription];
        NSLog(@"%@",error);
        if (operation.responseObject)
        {
            id message = operation.responseObject[kMessage];
            if (message != [NSNull null])
                errorString = message;
        }
        failure(errorString);
    }];
    
}
- (void)loadDetailsOfMall:(NSString*)mallPlaceId
                  success:(void (^)(MallCenter * mall,NSString *message))success
                  failure:(void (^)(NSString* errorString))failure
{
    AFHTTPRequestOperationManager *manager = [self getReguestManager];
    NSString *urlString = [NSString stringWithFormat:@"%@MallService/GetMallDetail?MallPlaceId=%@&languageId=%@",APIBaseURL,mallPlaceId,_languageID];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(operation.response.statusCode == 200)
        {
            MallCenter *mallCenter = [self parseMallDictionary:responseObject withDetails:YES];
            success(mallCenter,nil);
        }
        else
            success(nil,NSLocalizedString(@"No details available for this Mall",nil));
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorString = [error localizedDescription];
        NSLog(@"%@",error);
        if (operation.responseObject)
        {
            id message = operation.responseObject[kMessage];
            if (message != [NSNull null])
                errorString = message;
        }
        failure(errorString);
    }];

}
- (void)saveSelectedMalls:(NSString*)mallPlaceIds
                  success:(void (^)(id response))success
                  failure:(void (^)(NSError* error))failure
{
    AFHTTPRequestOperationManager *manager = [self getReguestManager];
    NSString *urlString = [NSString stringWithFormat:@"%@MallService/SaveSubscribedMalls",APIBaseURL];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:[[[DataManager sharedInstance] currentUser] userId] forKey:kUserID];
    [params setValue:mallPlaceIds forKey:@"MallPlaceId"];
    
    [manager POST:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *reponse = (NSDictionary*)responseObject;
         BOOL successFlag = [[reponse valueForKey:@"Success"] boolValue];
         if (successFlag)
             success(responseObject);
         else
             success(nil);
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         failure(error);
     }];
}
- (void)getSelectedMalls:(void (^)(NSArray* resultArray))success
                 failure:(void (^)(NSError* error))failure
{
    AFHTTPRequestOperationManager *manager = [self getReguestManager];
    NSString *urlString = [NSString stringWithFormat:@"%@MallService/GetSubscribedMalls/%@",APIBaseURL,[[[DataManager sharedInstance] currentUser] userId]];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *malls = [NSMutableArray new];
        for (NSDictionary *mallDic in responseObject) {
            MallCenter *mallCenter = [self parseMallDictionary:mallDic withDetails:NO];
            [malls addObject:mallCenter];
        }
        success(malls);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"%@",error);
        failure(error);
    }];
}
- (void)getInterestsList:(void (^)(NSArray* resultArray))success
                 failure:(void (^)(NSError* error))failure
{
    AFHTTPRequestOperationManager *manager = [self getReguestManager];
    NSString *urlString = [NSString stringWithFormat:@"%@UserInterestService/GetUserInterest?languageId=%@",APIBaseURL,_languageID];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"%@",responseObject);
        NSArray *interests = [self parseInterestListResponse:responseObject];
        success(interests);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"%@",error);
        failure(error);
    }];

}
- (void)saveSelectedInterests:(NSString*)categoriesIDs
                      success:(void (^)(id response))success
                      failure:(void (^)(NSError* error))failure
{
    AFHTTPRequestOperationManager *manager = [self getReguestManager];
    NSString *urlString = [NSString stringWithFormat:@"%@UserInterestService/SaveUserInterests",APIBaseURL];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:[[[DataManager sharedInstance] currentUser] userId] forKey:kUserID];
    [params setValue:categoriesIDs forKey:@"CategoryId"];
    
    [manager POST:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
         NSDictionary *reponse = (NSDictionary*)responseObject;
         BOOL successFlag = [[reponse valueForKey:@"Success"] boolValue];
         if (successFlag)
             success(responseObject);
         else
             success(nil);
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         failure(error);
     }];
}
- (void)saveAllInterests
{
    AFHTTPRequestOperationManager *manager = [self getReguestManager];
    NSString *urlString = [NSString stringWithFormat:@"%@UserInterestService/SaveAllInterests",APIBaseURL];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:[[[DataManager sharedInstance] currentUser] userId] forKey:kUserID];
    
    [manager POST:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Save All Interests:%@",responseObject);
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Save All Interests:%@",[error localizedDescription]);
     }];
}

- (void)getSelectedInterests:(void (^)(NSArray* resultArray))success
                     failure:(void (^)(NSError* error))failure
{
    AFHTTPRequestOperationManager *manager = [self getReguestManager];
    NSString *urlString = [NSString stringWithFormat:@"%@UserInterestService/GetSelectedInterest?UserId=%@&LanguageId=%@",APIBaseURL,[[[DataManager sharedInstance] currentUser] userId],_languageID];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *interests = [self parseInterestListResponse:responseObject];
        success(interests);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}
- (void)getOffersListPageNumber:(int)pageNumber forMall:(NSString*)mallPlaceId
                        success:(void (^)(NSArray* resultArray,int totalRecords))success
                        failure:(void (^)(NSError* error))failure
{
    AFHTTPRequestOperationManager *manager = [self getReguestManager];
    int pageSize = 20;
    NSString *urlString = [NSString stringWithFormat:@"%@ActivityService/GetMallActivities?UserId=%@&languageId=%@&PageIndex=%i&PageSize=%i",APIBaseURL,[[[DataManager sharedInstance] currentUser] userId],_languageID,pageNumber,pageSize];
    if (mallPlaceId)
        urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"&MallPlaceId=%@",mallPlaceId]];
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"%@",responseObject);
       id mallActivities = responseObject[@"MallActivities"];
       NSNumber * totalRecords = responseObject[@"TotalRecords"];
        
        if (mallActivities != [NSNull null]) {
            NSArray *offers = [self parseActivitiesListResponse:mallActivities];
            success(offers,[totalRecords intValue]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        failure(error);
    }];
}
- (void)markActivity:(NSString*)activityId favouriteDeleted:(BOOL)isDeleted
             success:(void (^)(id response))success
             failure:(void (^)(NSString* errorString))failure
{
    AFHTTPRequestOperationManager *manager = [self getReguestManager];
    NSString *urlString = [NSString stringWithFormat:@"%@UserFavoritesService/SaveFavoriteOffers?UserId=%@&ActivityId=%@&IsDeleted=%d",APIBaseURL,[[[DataManager sharedInstance] currentUser] userId],activityId,isDeleted];
    [manager POST:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *reponse = (NSDictionary*)responseObject;
         BOOL successFlag = [[reponse valueForKey:kSuccess] boolValue];
         if (successFlag)
             success(responseObject);
         else
             success(nil);
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSString *errorString = [error localizedDescription];
         if (operation.responseObject)
         {
             id message = operation.responseObject[kMessage];
             if (message != [NSNull null])
                 errorString = message;
         }
         failure(errorString);
     }];

}
- (void)loadDetailsOfActivity:(NSString*)activityId
                      success:(void (^)(id activity))success
                      failure:(void (^)(NSString* errorString))failure
{
    AFHTTPRequestOperationManager *manager = [self getReguestManager];
    NSString *urlString = [NSString stringWithFormat:@"%@ActivityService/GetActivity?ActivityId=%@&LanguageId=%@",APIBaseURL,activityId,_languageID];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        id activityType = responseObject[kActivityName];
        if (activityType != [NSNull null] && ![activityType isEqualToString:@""]) {
            if ([(NSString*)activityType isEqualToString:@"Offer"])
            {
                Offer *offer = [self parseOfferResponse:responseObject isFromEnity:NO];
                success(offer);
            }
            else
            {
                Activity* activity = [self parseActivityResponse:responseObject isFromEnity:NO];
                success(activity);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorString = [error localizedDescription];
        if (operation.responseObject)
        {
            id message = operation.responseObject[kMessage];
            if (message != [NSNull null])
                errorString = message;
        }
        failure(errorString);
    }];
}
#pragma mark -Shops API
- (void)getShopsList:(void (^)(NSArray* resultArray))success
             failure:(void (^)(NSString* errorString))failure;
{
    AFHTTPRequestOperationManager *manager = [self getReguestManager];
    NSString *urlString = [NSString stringWithFormat:@"%@ShopService/GetShops/%@",APIBaseURL,[[[DataManager sharedInstance] currentMall] mallPlaceId]];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(operation.response.statusCode == 200){
            NSArray *shops = [self parseShopsListResponse:responseObject];
            success(shops);
        }
        else
            success(nil);
     
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorString = [error localizedDescription];
        if (operation.responseObject)
        {
            id message = operation.responseObject[kMessage];
            if (message != [NSNull null])
                errorString = message;
        }
        failure(errorString);
    }];
}
- (void)markEntity:(NSString*)enityId isShop:(BOOL)isShop
  favouriteDeleted:(BOOL)isDeleted
           success:(void (^)(id response))success
           failure:(void (^)(NSString* errorString))failure
{
    
    AFHTTPRequestOperationManager *manager = [self getReguestManager];
    NSString *urlString = [NSString stringWithFormat:@"%@UserFavoritesService/SaveFavoriteShops?UserId=%@&EntityId=%@&IsShop=%@&IsDeleted=%@",APIBaseURL,[[[DataManager sharedInstance] currentUser] userId],enityId,isShop? @"true":@"false",isDeleted? @"true":@"false"];
    
    [manager POST:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *reponse = (NSDictionary*)responseObject;
         BOOL successFlag = [[reponse valueForKey:kSuccess] boolValue];
         if (successFlag)
             success(responseObject);
         else
             success(nil);
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSString *errorString = [error localizedDescription];
         if (operation.responseObject)
         {
             id message = operation.responseObject[kMessage];
             if (message != [NSNull null])
                 errorString = message;
         }
         failure(errorString);
     }];
}
- (void)loadDetailsOfShop:(NSString*)shopId
                  success:(void (^)(Shop * shop,NSString *message))success
                  failure:(void (^)(NSString* errorString))failure
{
    AFHTTPRequestOperationManager *manager = [self getReguestManager];
    NSString *urlString = [NSString stringWithFormat:@"%@ShopService/GetShopDetail?MallStoreId=%@&languageId=%@",APIBaseURL,shopId,_languageID];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(operation.response.statusCode == 200)
        {
            Shop *shop = [self parseShopResponse:responseObject withDetails:YES];
            success(shop,nil);
        }
        else
        {
            success(nil,NSLocalizedString(@"No details available for this shop",nil));
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorString = [error localizedDescription];
        if (operation.responseObject)
        {
            id message = operation.responseObject[kMessage];
            if (message != [NSNull null])
                errorString = message;
        }
        failure(errorString);
    }];

}
- (void)getFeaturedEntitiesForShop:(NSString*)shopId
                       success:(void (^)(NSArray *resultArray,NSString *message))success
                       failure:(void (^)(NSString* errorString))failure
{
    AFHTTPRequestOperationManager *manager = [self getReguestManager];
    NSString *urlString = [NSString stringWithFormat:@"%@ShopService/GetFeaturedShop/%@",APIBaseURL,shopId];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(operation.response.statusCode == 200)
        {
            NSArray *shops = [self parseEntityListResponse:responseObject];
            success(shops,nil);
        }
        else
        {
            success(nil,NSLocalizedString(@"No featured shops for this shop",nil));
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorString = [error localizedDescription];
        if (operation.responseObject)
        {
            id message = operation.responseObject[kMessage];
            if (message != [NSNull null])
                errorString = message;
        }
        failure(errorString);
    }];

}
#pragma mark -Restaurant APIs
- (void)getRestaurantList:(void (^)(NSArray* resultArray))success
                  failure:(void (^)(NSString* errorString))failure
{
    AFHTTPRequestOperationManager *manager = [self getReguestManager];
    NSString *urlString = [NSString stringWithFormat:@"%@RestaurantService/GetRestaurants/%@",APIBaseURL,[[[DataManager sharedInstance] currentMall] mallPlaceId]];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(operation.response.statusCode == 200){
            NSArray *restaurants = [self parseRestaurantListResponse:responseObject];
            success(restaurants);
        }
        else
            success(nil);
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorString = [error localizedDescription];
        if (operation.responseObject)
        {
            id message = operation.responseObject[kMessage];
            if (message != [NSNull null])
                errorString = message;
        }
        failure(errorString);
    }];
}

- (void)loadDetailsOfRestaurant:(NSString*)mallRestaurantId
                        success:(void (^)(Restaurant * restaurant,NSString *message))success
                        failure:(void (^)(NSString* errorString))failure
{
    AFHTTPRequestOperationManager *manager = [self getReguestManager];
    NSString *urlString = [NSString stringWithFormat:@"%@RestaurantService/GetRestaurantDetail?MallResturantId=%@&languageId=%@",APIBaseURL,mallRestaurantId,_languageID];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(operation.response.statusCode == 200)
        {
            Restaurant *restaurant = [self parseRestaurantResponse:responseObject withDetails:YES];
            success(restaurant,nil);
        }
        else
        {
            success(nil,NSLocalizedString(@"No details available for this Restaurant",nil));
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorString = [error localizedDescription];
        if (operation.responseObject)
        {
            id message = operation.responseObject[kMessage];
            if (message != [NSNull null])
                errorString = message;
        }
        failure(errorString);
    }];
}
- (void)getMenuListOfRestaurant:(NSString*)mallRestaurantId
                        success:(void (^)(NSArray *resultArray,NSString *message))success
                        failure:(void (^)(NSString* errorString))failure
{
    AFHTTPRequestOperationManager *manager = [self getReguestManager];
    NSString *urlString = [NSString stringWithFormat:@"%@RestaurantService/GetRestaurantMenu/%@",APIBaseURL,mallRestaurantId];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(operation.response.statusCode == 200)
        {
            NSMutableArray *menuItems = [[NSMutableArray alloc] init];
            for (NSDictionary *menuDic in responseObject)
            {
                MenuItem *menuItem = [self parseMenuItemResponse:menuDic];
                [menuItems addObject:menuItem];
            }
            success(menuItems,nil);
        }
        else
        {
            success(nil,NSLocalizedString(@"No menu items available for this Restaurant",nil));
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorString = [error localizedDescription];
        if (operation.responseObject)
        {
            id message = operation.responseObject[kMessage];
            if (message != [NSNull null])
                errorString = message;
        }
        failure(errorString);
    }];
}
#pragma mark -Services API
- (void)getServicesList:(void (^)(NSArray *resultArray,NSString *message))success
                failure:(void (^)(NSString* errorString))failure
{
    AFHTTPRequestOperationManager *manager = [self getReguestManager];
    NSString *urlString = [NSString stringWithFormat:@"%@MallService/GetMallServices?MallPlaceId=%@&LanguageId=%@",APIBaseURL,[[[DataManager sharedInstance] currentMall] mallPlaceId],_languageID];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(operation.response.statusCode == 200)
        {
            NSMutableArray *services = [[NSMutableArray alloc] init];
            for (NSDictionary *serviceDic in responseObject)
            {
                MAService *service = [self parseServiceResponse:serviceDic];
                [services addObject:service];
            }
            success(services,nil);
        }
        else
        {
            success(nil,NSLocalizedString(@"No services available for this Mall",nil));
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorString = [error localizedDescription];
        if (operation.responseObject)
        {
            id message = operation.responseObject[kMessage];
            if (message != [NSNull null])
                errorString = message;
        }
        failure(errorString);
    }];
}
#pragma mark -Timmings
- (void)getMallTimingList:(void (^)(NSArray *resultArray,NSString *message))success
                  failure:(void (^)(NSString* errorString))failure
{
    AFHTTPRequestOperationManager *manager = [self getReguestManager];
    NSString *urlString = [NSString stringWithFormat:@"%@MallService/GetMallTimings/%@",APIBaseURL,[[[DataManager sharedInstance] currentMall] mallPlaceId]];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(operation.response.statusCode == 200)
        {
            NSArray *entityTimings = [self parseTimingListResponse:responseObject];
            success(entityTimings,nil);
        }
        else
        {
            success(nil,NSLocalizedString(@"No timings available for this Mall",nil));
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorString = [error localizedDescription];
        if (operation.responseObject)
        {
            id message = operation.responseObject[kMessage];
            if (message != [NSNull null])
                errorString = message;
        }
        failure(errorString);
    }];
}

#pragma mark -PushNotification
- (void)sendDeviceTokenForPushNotification
{
    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceToken];
    if (deviceToken)
    {
        AFHTTPRequestOperationManager *manager = [self getReguestManager];
        User *user = [[DataManager sharedInstance] currentUser];
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setValue:user.userId forKey:kUserID];
        [params setValue:deviceToken forKey:@"DeviceId"];
        [params setValue:@"1" forKey:@"DeviceType"];
        NSString *urlString = [NSString stringWithFormat:@"%@Account/SaveDeviceIdentity",APIBaseURL];
        [manager POST:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
            NSLog(@"Device token response %@",responseObject);
         }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"%@",[error localizedDescription]);
             NSString *errorString = [error localizedDescription];
             if (operation.responseObject)
             {
                 id message = operation.responseObject[kMessage];
                 if (message != [NSNull null])
                     errorString = message;
                 NSLog(@"Device token failure %@",errorString);
             }
         }];
    }
}
- (void)changeNotificationPreference:(BOOL)isEnabled
                             success:(void (^)(NSString *message))success
                             failure:(void (^)(NSString* errorString))failure
{
    AFHTTPRequestOperationManager *manager = [self getReguestManager];
    NSString *urlString = [NSString stringWithFormat:@"%@Account/NotificationSetting",APIBaseURL];
    User *user = [[DataManager sharedInstance] currentUser];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:user.userId forKey:kUserID];
    [params setValue:@(isEnabled) forKey:@"IsEnabled"];
    
    [manager POST:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
        if(operation.response.statusCode == 200)
         {
             id message = responseObject[kMessage];
             if (message != [NSNull null]) {
                 success(message);
             }
         }
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSString *errorString = [error localizedDescription];
         if (operation.responseObject)
         {
             id message = operation.responseObject[kMessage];
             if (message != [NSNull null])
                 errorString = message;
         }
         failure(errorString);
     }];
}
#pragma mark -SignOut
- (void)signOutUser:(void (^)(NSString *message))success
            failure:(void (^)(NSString* errorString))failure
{
    AFHTTPRequestOperationManager *manager = [self getReguestManager];
    NSString *urlString = [NSString stringWithFormat:@"%@Account/SignOut/%@",APIBaseURL,[[[DataManager sharedInstance] currentUser] userId]];

    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
         id message = responseObject[kMessage];
         if (message != [NSNull null])
             success(message);
         else
             success(nil);
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSString *errorString = [error localizedDescription];
         if (operation.responseObject)
         {
             id message = operation.responseObject[kMessage];
             if (message != [NSNull null])
                 errorString = message;
         }
         failure(errorString);
     }];

}
- (void)saveLoyaltyCardOnServer:(LoyaltyCard*)loyaltyCard
                        success:(void (^)(NSString* message))success
                        failure:(void (^)(NSString* errorString))failure
{
    AFHTTPRequestOperationManager *manager = [self getReguestManager];
    NSString *urlString = [NSString stringWithFormat:@"%@Account/SaveLoyaltyCard",APIBaseURL];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:[[[DataManager sharedInstance] currentUser] userId] forKey:kUserID];
    [params setValue:loyaltyCard.title forKey:kCardTitle];
    [params setValue:loyaltyCard.barcode forKey:kBarcode];
    //[params setValue:@"780672318863" forKey:kBarcode];
    [params setValue:@"UPC-A" forKey:kBarcodeType];
    [params setValue:loyaltyCard.notes forKey:kCardNotes];
    [params setValue:loyaltyCard.cardNumber forKey:kCardNumber];
    [params setValue:loyaltyCard.providerName forKey:kProviderName];
    [params setValue:loyaltyCard.frontImageString forKey:@"FrontBase64ImageString"];
    [params setValue:loyaltyCard.backImageString forKey:@"BacksideBase64ImageString"];
     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    [params setValue:[dateFormatter stringFromDate:loyaltyCard.issueDate] forKey:@"IssueDate"];
    [params setValue:[dateFormatter stringFromDate:loyaltyCard.expiryDate] forKey:@"ExpiryDate"];
//    [params setValue:@"12/12/2010" forKey:@"IssueDate"];
//    [params setValue:@"12/12/2011" forKey:@"ExpiryDate"];
    
    [manager POST:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *response = (NSDictionary*)responseObject;
         BOOL successFlag = [[response valueForKey:kSuccess] boolValue];
         if (successFlag)
         {
             id message = response[kMessage];
             if (message != [NSNull null])
                 success(message);
             else
                 success(nil);
         }
         else
             success(nil);
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSString *errorString = [error localizedDescription];
         if (operation.responseObject)
         {
             id message = operation.responseObject[kMessage];
             if (message != [NSNull null])
                 errorString = message;
         }
         failure(errorString);
     }];
}
- (void)logVisitOfEntity:(id)entity
//                 success:(void (^)(NSString *message))success
//                 failure:(void (^)(NSString* errorString))failure
{
    AFHTTPRequestOperationManager *manager = [self getReguestManager];
    NSString *urlString = [NSString stringWithFormat:@"%@LoggerService/SaveLog",APIBaseURL];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if ([entity isMemberOfClass:[MallCenter class]])
    {
        [params setValue:[(MallCenter*)entity mallPlaceId] forKey:kEntityId];
        [params setValue:@"Mall" forKey:kEntityType];
    }
    else if ([entity isMemberOfClass:[Shop class]])
    {
        [params setValue:[(Shop *)entity entityId] forKey:kEntityId];
        [params setValue:@"Shop" forKey:kEntityType];
    }
    else
    {
        [params setValue:[(Restaurant *)entity entityId] forKey:kEntityId];
        [params setValue:@"Restaurant" forKey:kEntityType];
    }
    [params setValue:@"1" forKey:@"ActionLogType"];
    
    [manager POST:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"%@ Visit -> Success:%d",[entity class],[[responseObject valueForKey:@"Success"] boolValue]);
//         if(operation.response.statusCode == 200)
//         {
//             id message = responseObject[kMessage];
//             if (message != [NSNull null]) {
//                 success(message);
//             }
//         }
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSString *errorString = [error localizedDescription];
         NSLog(@"%@ Visit error -> %@",[entity class],errorString);
//         if (operation.responseObject)
//         {
//             id message = operation.responseObject[kMessage];
//             if (message != [NSNull null])
//                 errorString = message;
//         }
//         failure(errorString);
     }];
}
#pragma mark - parsers
- (User*)parseUserResponse:(NSDictionary*)responseDic
{
    NSString *userID= [responseDic objectForKey:@"User_Id"];
    [[NSUserDefaults standardUserDefaults] setObject:userID forKey:kUserID];
    [[NSUserDefaults standardUserDefaults] synchronize];
    User *user = [[DataManager sharedInstance] userWithId:userID];
    user.authToken = [responseDic objectForKey:@"Auth_Token"];
    [[DataManager sharedInstance] setCurrentUser:user];
    [[DataManager sharedInstance] saveContext];
    return user;
}
- (void)parseUserProfileResponse:(NSDictionary*)profileDic
{
   User *user = [[DataManager sharedInstance] currentUser];
   id Name = profileDic[@"FullName"];
    if (Name && Name != [NSNull null] && ![Name isEqualToString:@""]) {
        user.name = Name;
    }
    
        id email = profileDic[kUserEmail];
        if (email && email != [NSNull null] && ![email isEqualToString:@""])
            user.email = email;
        
        id imageURL = profileDic[kImageUrl];
        if (imageURL && imageURL != [NSNull null] && ![imageURL isEqualToString:@""])
            user.image = imageURL;
        
        id gender = profileDic[kGender];
        if (gender && gender != [NSNull null] && ![gender isEqualToString:@""])
        {
            if ([(NSString*)gender isEqualToString:@"Male"])
                user.isMale = YES;
            else
                user.isMale = NO;
        }
        id city = profileDic[kCityName];
        if (city && city != [NSNull null] && ![city isEqualToString:@""]) {
            user.city = city;
        }
        
        id country = profileDic[@"CountryCode"];
        if (country && country != [NSNull null] && ![country isEqualToString:@""]) {
            user.country = country;
        }
        NSNumber * notificationAllowed = profileDic[@"IsNotificationAllowed"];
        if (notificationAllowed)
            user.isNotificationAllowed = [notificationAllowed boolValue];
    
        id dateOfBirth = profileDic[kDateOfBirth];
        if (dateOfBirth && dateOfBirth != [NSNull null] && ![dateOfBirth isEqualToString:@""])
        {
            NSDateFormatter *dateFormatter = [UtilsFunctions getServerDateFormatter];
            [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
            NSString *dateString = dateOfBirth;
            NSDate *date = [dateFormatter dateFromString:dateString];
            user.dateOfBirth = date;
            
        }
        //[[DataManager sharedInstance] setCurrentUser:user];
        [[DataManager sharedInstance] saveContext];
}
- (NSArray*)parseMallListResponse:(NSArray*)mallList
{
    NSMutableArray *malls = [NSMutableArray new];
    for (NSDictionary *mallDic in mallList) {
        MallCenter *mallCenter = [self parseMallDictionary:mallDic withDetails:NO];
        [malls addObject:mallCenter];
    }
    [[DataManager sharedInstance] saveContext];
    return malls;
}
- (MallCenter*)parseMallDictionary:(NSDictionary*)mallDic withDetails:(BOOL)isDetail
{
    NSString *mallPlaceID = [mallDic objectForKey:kMallPlaceID];
    MallCenter *mallCenter = [[DataManager sharedInstance] mallCenterWithMallPlaceId:mallPlaceID];
    mallCenter.name = [mallDic objectForKey:@"Name"];
    
    id placeName = mallDic[kMallPlaceName];
    
    if (placeName != [NSNull null] && ![placeName isEqualToString:@""])
        mallCenter.placeName = placeName;
    
    id logoURL = mallDic[@"LogoUrl"];
    
    if (logoURL != [NSNull null] && ![logoURL isEqualToString:@""])
        mallCenter.logoURL = logoURL;
    
    id briefText = mallDic[kBriefText];
    
    if (briefText != [NSNull null] && ![briefText isEqualToString:@""])
        mallCenter.briefText = briefText;
    
    id aboutText = mallDic[@"AboutText"];
    
    if (aboutText != [NSNull null] && ![aboutText isEqualToString:@""])
        mallCenter.aboutText = aboutText;
    
    id address = mallDic[@"Address"];
    if (address != [NSNull null] && ![address isEqualToString:@""])
        mallCenter.address = address;
    
    id city = mallDic[@"CityName"];
    if (city != [NSNull null] && ![city isEqualToString:@""])
        mallCenter.city = city;
    
    id countryName  = mallDic[@"CountryName"];
    if (countryName != [NSNull null] && ![countryName isEqualToString:@""])
        mallCenter.country = countryName;
    id latitude = mallDic[kLatitude];
    if (latitude != [NSNull null])
        mallCenter.latitude = [latitude doubleValue];
    
    id longitude = mallDic[kLongitude];
    if (longitude != [NSNull null])
        mallCenter.longitude = [longitude doubleValue];
    
    id colour = mallDic[@"CorporateColor"];
    if (colour != [NSNull null])
        mallCenter.corporateColor = colour;
    
    if (isDetail)
    {
        id phone = mallDic[kServerPhone];
        if (phone != [NSNull null])
            mallCenter.phone = phone;
        
        id email = mallDic[kUserEmail];
        if (email != [NSNull null])
            mallCenter.email = email;
        
        id webURL = mallDic[kWebURL];
        if (webURL != [NSNull null])
            mallCenter.webURL = webURL;
        
        id  mallTiming = mallDic[@"MallTimings"];
        if (mallTiming != [NSNull null])
        {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"HH:mm"];
            for (int i = 0; i< [mallTiming count]; i++)
            {
                NSDictionary * timingDic = mallTiming[i];
                Timing *timing = [self parseTimingResponse:timingDic];
                timing.index = i;
                [mallCenter addMallTimingsObject:timing];
            }
        }
    }
    return mallCenter;
}
- (NSArray*)parseInterestListResponse:(NSArray*)interestList
{
    NSMutableArray *userInterests = [NSMutableArray new];
    for (NSDictionary *interestDic in interestList) {
        MACategory *interest = [self parseInterestResponse:interestDic];
        [userInterests addObject:interest];
    }
    [[DataManager sharedInstance] saveContext];
    return userInterests;
}
- (MACategory *)parseInterestResponse:(NSDictionary*)interestDic
{
    NSString *categoryID= [interestDic objectForKey:@"CategoryId"];
    MACategory * category = [[DataManager sharedInstance] categoryWithID:categoryID];
    
    id categoryText = interestDic[@"CategoryText"];
    if (categoryText != [NSNull null] && ![categoryText isEqualToString:@""])
        category.categoryText = categoryText;
    
    id description = interestDic[@"Description"];
    if (description != [NSNull null] && ![description isEqualToString:@""])
        category.categoryDesciption = description;
    
    return category;
}
#pragma mark -Activites/Offers
- (NSArray*)parseActivitiesListResponse:(NSArray*)activityArray
{
    NSMutableArray * activities = [[NSMutableArray alloc] init];
    for (NSDictionary *activityDic in activityArray)
    {
        id activityType = activityDic[kActivityName];
        if (activityType != [NSNull null] && ![activityType isEqualToString:@""]) {
            if ([(NSString*)activityType isEqualToString:@"Offer"])
            {
                Offer *offer = [self parseOfferResponse:activityDic isFromEnity:NO];
                [activities addObject:offer];
            }
            else
            {
                Activity* activity = [self parseActivityResponse:activityDic isFromEnity:NO];
                [activities addObject:activity];
            }
        }
    }
    [[DataManager sharedInstance] saveContext];
    return activities;
}
- (Activity*)parseActivityResponse:(NSDictionary*)activityDic isFromEnity:(BOOL)isFromEnity
{
    NSString *activityId = [activityDic objectForKey:kActivityId];
    id activityType = activityDic[kActivityName];
    
    Activity *activity = [[DataManager sharedInstance] activityWithId:activityId];
    activity.activityType = activityType;
    
    id title = activityDic[kActivityTextTitle];
    if (title != [NSNull null])
        activity.title = title;
    
    id briefText = activityDic[kBriefText];
    if (briefText != [NSNull null])
        activity.briefText = briefText;
    
    id detailText = activityDic[kDetailText];
    if (detailText != [NSNull null])
        activity.detailText = detailText;
         
    id imageURL = activityDic[kImageUrl];
     if (imageURL!= [NSNull null])
         activity.imageURL = imageURL;
         
    id mallPlaceId = activityDic[kMallPlaceID];
    if (mallPlaceId != [NSNull null])
    {
        MallCenter *mallCenter = [[DataManager sharedInstance] mallCenterWithMallPlaceId:mallPlaceId];
        if (activityDic[kMallPlaceName] != [NSNull null])
            mallCenter.placeName = activityDic[kMallPlaceName];
        activity.mall = mallCenter;
    }

    id startDate = activityDic[@"StartDate"];
    if (startDate && startDate != [NSNull null])
    {
        NSDateFormatter *dateFormatter = [UtilsFunctions getServerDateFormatter];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        NSDate *date = [dateFormatter dateFromString:startDate];
        activity.startDate = date;
    }
    id endDate = activityDic[@"EndDate"];
    if (endDate && endDate != [NSNull null])
    {
        NSDateFormatter *dateFormatter = [UtilsFunctions getServerDateFormatter];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        NSDate *date = [dateFormatter dateFromString:endDate];
        activity.endDate = date;
    }

    id entityID = activityDic[kEntityId];
    if (entityID != [NSNull null] && !isFromEnity && !activity.entityObject) {
        Entity *entity = [[DataManager sharedInstance] entityWithId:entityID];
        
        id entityName = activityDic[kEntityName];
        if (entityName != [NSNull null])
            entity.name = entityName;
        id entityType = activityDic[kEntityType];
        if (entityType != [NSNull null])
            entity.entityType = entityType;
        
        id entityLogo = activityDic[@"EntityLogo"];
        if (entityLogo != [NSNull null])
            entity.logoURL = entityLogo;
        
        activity.entityObject = entity;
    }
    id catogories = activityDic[@"ActivityCategories"];
    if (catogories != [NSNull null])
    {
        NSArray *categoriesArray = [self parseEntityCategories:catogories];
        [activity addCategories:[NSSet setWithArray:categoriesArray]];
    }
    id activityBanners = activityDic[kBannerImages];
    if (activityBanners != [NSNull null])
    {
        NSArray *banner = [self parseBannerListResponse:activityBanners];
        [activity addBanners:[NSSet setWithArray:banner]];
    }

    [[DataManager sharedInstance] saveContext];
    return activity;
}
- (Offer*)parseOfferResponse:(NSDictionary*)offerDic isFromEnity:(BOOL)isFromEnity
{
    NSString *activityId = [offerDic objectForKey:kActivityId];
    Offer *offer = [[DataManager sharedInstance] offerWithId:activityId];
    
    id title = offerDic[kActivityTextTitle];
    if (title != [NSNull null])
        offer.title = title;
    
    id briefText = offerDic[kBriefText];
    if (briefText != [NSNull null])
        offer.briefText = briefText;
    
    id detailText = offerDic[kDetailText];
    if (detailText != [NSNull null])
        offer.detailText = detailText;
    
    id imageURL = offerDic[kImageUrl];
    if (imageURL!= [NSNull null])
        offer.imageURL = imageURL;
    
    
    id mallPlaceId = offerDic[kMallPlaceID];
    if (mallPlaceId != [NSNull null])
    {
        MallCenter *mallCenter = [[DataManager sharedInstance] mallCenterWithMallPlaceId:mallPlaceId];
        if (offerDic[kMallPlaceName] != [NSNull null])
            mallCenter.placeName = offerDic[kMallPlaceName];
        offer.mall = mallCenter;
    }
    
    id startDate = offerDic[@"StartDate"];
    if (startDate && startDate != [NSNull null])
    {
        NSDateFormatter *dateFormatter = [UtilsFunctions getServerDateFormatter];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        NSDate *date = [dateFormatter dateFromString:startDate];
        offer.startDate = date;
    }
    id endDate = offerDic[@"EndDate"];
    if (endDate && endDate != [NSNull null])
    {
        NSDateFormatter *dateFormatter = [UtilsFunctions getServerDateFormatter];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        NSDate *date = [dateFormatter dateFromString:endDate];
        offer.endDate = date;
    }
    
    
    id entityID = offerDic[kEntityId];
    if (entityID != [NSNull null] && !isFromEnity && !offer.entityObject) {
        Entity *entity = [[DataManager sharedInstance] entityWithId:entityID];
        
        id entityName = offerDic[kEntityName];
        if (entityName != [NSNull null])
            entity.name = entityName;
        id entityType = offerDic[kEntityType];
        if (entityType != [NSNull null])
            entity.entityType = entityType;
        
        id entityLogo = offerDic[@"EntityLogo"];
        if (entityLogo != [NSNull null])
            entity.logoURL = entityLogo;
            
        offer.entityObject = entity;
    }
    id catogories = offerDic[@"ActivityCategories"];
    if (catogories != [NSNull null])
    {
        NSArray *categoriesArray = [self parseEntityCategories:catogories];
        [offer addCategories:[NSSet setWithArray:categoriesArray]];
    }
    id activityBanners = offerDic[kBannerImages];
    if (activityBanners != [NSNull null])
    {
        NSArray *banner = [self parseBannerListResponse:activityBanners];
        [offer addBanners:[NSSet setWithArray:banner]];
    }
    [[DataManager sharedInstance] saveContext];
    return offer;
}
#pragma mark -Shops
- (NSArray*)parseEntityActivitiesListResponse:(NSArray*)activityArray
{
    NSMutableArray * activities = [[NSMutableArray alloc] init];
    for (NSDictionary *activityDic in activityArray)
    {
        id activityType = activityDic[kActivityName];
        if (activityType != [NSNull null] && ![activityType isEqualToString:@""]) {
            if ([(NSString*)activityType isEqualToString:@"Offer"])
            {
                Offer *offer = [self parseOfferResponse:activityDic isFromEnity:YES];
                [activities addObject:offer];
            }
            else
            {
                Activity* activity = [self parseActivityResponse:activityDic isFromEnity:YES];
                [activities addObject:activity];
            }
        }
    }
    [[DataManager sharedInstance] saveContext];
    return activities;

}
- (NSArray*)parseShopsListResponse:(NSArray*)shoplist
{
    NSMutableArray * shops = [[NSMutableArray alloc] init];
    for (NSDictionary *shopDic in shoplist)
    {
        Shop *shop = [self parseShopResponse:shopDic withDetails:NO];
        [shops addObject:shop];
    }
    [[DataManager sharedInstance] saveContext];
    return shops;
}
- (Shop *)parseShopResponse:(NSDictionary*)shopDic withDetails:(BOOL)isDetail
{
    Shop *shop;
   
    NSString *shopId = [shopDic objectForKey:kMallStoreId];
    shop = [[DataManager sharedInstance] shopWithId:shopId];
    id name = shopDic[@"StoreName"];
    if (name != [NSNull null])
        shop.name = name;
    
    if (isDetail)
    {
        NSString *shopId = [shopDic objectForKey:@"StoreId"];
        shop = [[DataManager sharedInstance] shopWithId:shopId];
    }
    else
    {
        id catogories = shopDic[@"ShopCategories"];
        if (catogories != [NSNull null])
        {
            NSArray *categoriesArray = [self parseEntityCategories:catogories];
            [shop addCategories:[NSSet setWithArray:categoriesArray]];
            if (categoriesArray.count>0) {
                MACategory *category = categoriesArray.firstObject;
                shop.categoryName = category.categoryText;
            }
        }
    }
    
    
    id logoURL = shopDic[kLogoURL];
    if (logoURL != [NSNull null])
        shop.logoURL = logoURL;
    
    id floor = shopDic[kFloor];
    if (floor != [NSNull null])
        shop.floor = floor;
    
    id briefText = shopDic[kBriefText];
    if (briefText != [NSNull null])
        shop.briefText = briefText;
    
        
    if (isDetail)
    {
        id shopName = shopDic[kName];
        if (shopName != [NSNull null])
            shop.name = shopName;
        
        id aboutText = shopDic[kAboutText];
        if (aboutText != [NSNull null])
            shop.aboutText = aboutText;
       
        id address = shopDic[kAddress];
        if (address != [NSNull null])
            shop.address = address;
        
        id  storeTiming = shopDic[@"StoreTimings"];
        if (storeTiming != [NSNull null])
        {
            NSArray *storeTimings = storeTiming;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"HH:mm"];
            for (int i = 0; i< storeTimings.count; i++)
            {
                NSDictionary * timingDic = storeTiming[i];
                NSString * timingId = [timingDic valueForKey:@"Id"];
                Timing * timing = [[DataManager sharedInstance] timingWithId:timingId];
                
                id fromDay = timingDic[kFromDay];
                if (fromDay != [NSNull null])
                {
                    timing.fromDay = fromDay;
                }
                
                id toDay = timingDic[kToDay];
                if (toDay != [NSNull null])
                {
                    timing.toDay = toDay;
                }
                
                id openingTime = timingDic[kOpeningTiming];
                if (openingTime != [NSNull null])
                {
                    NSString *dateString = openingTime;
                    NSDate *date = [dateFormatter dateFromString:dateString];
                    timing.openingTime = date;
                }
                
                id closingTime = timingDic[kClosingTiming];
                if (closingTime != [NSNull null])
                {
                    NSString *dateString = closingTime;
                    NSDate *closingDate = [dateFormatter dateFromString:dateString];
                    timing.closingTime = closingDate;
                }
                timing.index = i;
                [shop addTimingsObject:timing];
            }
        }
        
        id latitude = shopDic[kLatitude];
        if (latitude != [NSNull null])
            shop.latitude = [latitude doubleValue];
        
        id longitude = shopDic[kLongitude];
        if (longitude != [NSNull null])
            shop.longitude = [longitude doubleValue];
        
        id phone = shopDic[kServerPhone];
        if (phone != [NSNull null])
            shop.phone = phone;
        
        id email = shopDic[kUserEmail];
        if (email != [NSNull null])
            shop.email = email;
        
        id webURL = shopDic[kWebURL];
        if (webURL != [NSNull null])
            shop.webURL = webURL;
        
        NSNumber * siteMapActive = shopDic[kSiteMapActive];
        if (siteMapActive)
            shop.mapActive = [siteMapActive boolValue];
        
        id siteMapURL = shopDic[kSiteMapURL];
        if (siteMapURL != [NSNull null])
            shop.siteMapURL = siteMapURL;
        
        id shopOffers = shopDic[@"StoreOffers"];
        if (shopOffers != [NSNull null])
        {
           NSArray *activities =  [self parseEntityActivitiesListResponse:shopOffers];
           [shop addEntityActivities:[NSSet setWithArray:activities]];
        }
        id shopBanners = shopDic[@"BannerImages"];
        if (shopBanners != [NSNull null])
        {
            NSArray *banner = [self parseBannerListResponse:shopBanners];
            [shop addBannerImages:[NSSet setWithArray:banner]];
        }
        shop.isEntityDetailLoaded = YES;
        
    }
    [[DataManager sharedInstance] saveContext];
    return shop;
}
- (NSArray*)parseBannerListResponse:(NSArray*)bannerArray
{
    NSMutableArray * banners = [[NSMutableArray alloc] init];
    for (NSDictionary *bannerDic in bannerArray)
    {
        NSString *bannerId = bannerDic[@"BannerImageId"];
        BannerImage *bannerImage = [[DataManager sharedInstance] bannerImageWithId:bannerId];
        id imageUrl = bannerDic[@"BannerImageURL"];
        if (imageUrl != [NSNull null]) {
            bannerImage.imageURL = imageUrl;
        }
        [banners addObject:bannerImage];
    }
    return banners;
}
- (NSArray*)parseEntityListResponse:(NSArray*)entityArray
{
    NSMutableArray * entities = [[NSMutableArray alloc] init];
    for (NSDictionary *shopDic in entityArray)
    {
        id entityType = shopDic[kEntityType];
        if (entityType != [NSNull null])
        {
            if ([entityType isEqualToString:@"Shop"])
            {
                id entityID = shopDic[kEntityId];
                Shop * shop = [[DataManager sharedInstance] shopWithId:entityID];
                id entityName = shopDic[kEntityName];
                if (entityName != [NSNull null])
                    shop.name = entityName;

                id logoURL = shopDic[kLogoURL];
                if (logoURL != [NSNull null])
                    shop.logoURL = logoURL;
                
                id floor = shopDic[kFloor];
                if (floor != [NSNull null])
                    shop.floor = floor;
                
                id briefText = shopDic[kBriefText];
                if (briefText != [NSNull null])
                    shop.briefText = briefText;
                id catogories = shopDic[@"EntityCategories"];
                if (catogories != [NSNull null])
                {
                    NSArray *categoriesArray = [self parseEntityCategories:catogories];
                    [shop addCategories:[NSSet setWithArray:categoriesArray]];
                }
                
                [entities addObject:shop];
            }
        }
    }
    [[DataManager sharedInstance] saveContext];
    return entities;
}
- (NSArray*)parseEntityCategories:(NSArray*)categoryArray
{
    NSMutableArray * catArray = [[NSMutableArray alloc] init];
    for (NSDictionary *catDic in categoryArray)
    {
        NSString *categoryID= [catDic objectForKey:@"CategoryId"];
        MACategory * category = [[DataManager sharedInstance] categoryWithID:categoryID];
        
        id categoryText = catDic[@"CategoryName"];
        if (categoryText != [NSNull null])
            category.categoryText = categoryText;
        
        [catArray addObject:category];
    }
    return catArray;
}
#pragma mark -Restaurant Parsers
- (NSArray*)parseRestaurantListResponse:(NSArray*)restaurantList
{
    NSMutableArray * restaurants = [[NSMutableArray alloc] init];
    for (NSDictionary *restDic in restaurantList)
    {
        Restaurant *restaurant = [self parseRestaurantResponse:restDic withDetails:NO];
        [restaurants addObject:restaurant];
    }
    [[DataManager sharedInstance] saveContext];
    return restaurants;
}
- (Restaurant *)parseRestaurantResponse:(NSDictionary*)restDic withDetails:(BOOL)isDetail
{
    Restaurant *restaurant;
    
    NSString *restaurantId = [restDic valueForKey:@"MallResturantId"];
    restaurant = [[DataManager sharedInstance] restaurantWithId:restaurantId];
    
    id name = restDic[@"RestaurantName"];
    if (name != [NSNull null])
        restaurant.name = name;
    
    if (isDetail)
    {
        NSString *restaurantId = [restDic objectForKey:@"ResturantId"];
        restaurant = [[DataManager sharedInstance] restaurantWithId:restaurantId];
    }
    else
    {
        id categories = restDic[@"RestaurantCategories"];
        if (categories != [NSNull null])
        {
            NSArray *categoriesArray = [self parseEntityCategories:categories];
            [restaurant addCategories:[NSSet setWithArray:categoriesArray]];
        }
    }

    id logoURL = restDic[kLogoURL];
    if (logoURL != [NSNull null])
        restaurant.logoURL = logoURL;
    
    id floor = restDic[kFloor];
    if (floor != [NSNull null])
        restaurant.floor = floor;
    
    id briefText = restDic[kBriefText];
    if (briefText != [NSNull null])
        restaurant.briefText = briefText;
    
    if (isDetail)
    {
        id name = restDic[kName];
        if (name != [NSNull null])
            restaurant.name = name;
       
        id aboutText = restDic[kAboutText];
        if (aboutText != [NSNull null])
            restaurant.aboutText = aboutText;
        
        id address = restDic[kAddress];
        if (address != [NSNull null])
            restaurant.address = address;
        
        id  storeTiming = restDic[@"ResturantTimings"];
        if (storeTiming != [NSNull null])
        {
            NSArray *storeTimings = storeTiming;
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"HH:mm"];
            for (int i = 0; i< storeTimings.count; i++)
            {
                NSDictionary * timingDic = storeTiming[i];
                NSString * timingId = [timingDic valueForKey:@"Id"];
                Timing * timing = [[DataManager sharedInstance] timingWithId:timingId];
                
                id fromDay = timingDic[kFromDay];
                if (fromDay != [NSNull null])
                {
                    timing.fromDay = fromDay;
                }
                
                id toDay = timingDic[kToDay];
                if (toDay != [NSNull null])
                {
                    timing.toDay = toDay;
                }
                
                id openingTime = timingDic[@"OpeningTimings"];
                if (openingTime != [NSNull null])
                {
                    NSString *dateString = openingTime;
                    NSDate *date = [dateFormatter dateFromString:dateString];
                    timing.openingTime = date;
                }
                
                id closingTime = timingDic[@"ClosingTimings"];
                if (closingTime != [NSNull null])
                {
                    NSString *dateString = closingTime;
                    NSDate *closingDate = [dateFormatter dateFromString:dateString];
                    timing.closingTime = closingDate;
                }
                timing.index = i;
                [restaurant addTimingsObject:timing];
            }
        }
        
        id latitude = restDic[kLatitude];
        if (latitude != [NSNull null])
            restaurant.latitude = [latitude doubleValue];
        
        id longitude = restDic[kLongitude];
        if (longitude != [NSNull null])
            restaurant.longitude = [longitude doubleValue];
        
        id phone = restDic[kServerPhone];
        if (phone != [NSNull null])
            restaurant.phone = phone;
        
        id email = restDic[kUserEmail];
        if (email != [NSNull null])
            restaurant.email = email;
        
        id webURL = restDic[kWebURL];
        if (webURL != [NSNull null])
            restaurant.webURL = webURL;
        
        NSNumber * siteMapActive = restDic[kSiteMapActive];
        if (siteMapActive)
            restaurant.mapActive = [siteMapActive boolValue];
        
        id siteMapURL = restDic[kSiteMapURL];
        if (siteMapURL != [NSNull null])
            restaurant.siteMapURL = siteMapURL;
        
        id restMenu = restDic[@"ResturantMenu"];
        if (restMenu != [NSNull null])
        {
            for (NSDictionary *menuDic in restMenu)
            {
               MenuCategory * menuCategory = [self parseMenuCategoryResponse:menuDic];
               [restaurant addMenuCategoriesObject:menuCategory];
            }
        }
        
        id shopOffers = restDic[@"RestaurantOffers"];
        if (shopOffers != [NSNull null])
        {
            NSArray *activities =  [self parseEntityActivitiesListResponse:shopOffers];
            [restaurant addEntityActivities:[NSSet setWithArray:activities]];
        }
        id shopBanners = restDic[@"BannerImages"];
        if (shopBanners != [NSNull null])
        {
            NSArray *banner = [self parseBannerListResponse:shopBanners];
            [restaurant addBannerImages:[NSSet setWithArray:banner]];
        }

        restaurant.isEntityDetailLoaded = YES;
    }
    [[DataManager sharedInstance] saveContext];
    return restaurant;
}
- (MenuCategory*)parseMenuCategoryResponse:(NSDictionary*)responseDic
{
    NSString *menuCategoryId = [responseDic valueForKey:@"MenuCategoryId"];
    MenuCategory * menuCategory = [[DataManager sharedInstance] menuCategoryWithId:menuCategoryId];
    id name = responseDic[kName];
    if (name != [NSNull null])
    {
        menuCategory.title = name;
    }
    return menuCategory;
}
- (MenuItem *)parseMenuItemResponse:(NSDictionary*)responseDic
{
    NSString *menuItemId = [responseDic valueForKey:@"MenuItemId"];
    MenuItem *menuItem = [[DataManager sharedInstance] menuItemWithId:menuItemId];
    id name = responseDic[@"MenuItemTitle"];
    if (name != [NSNull null])
        menuItem.title = name;
    
    id imageURL = responseDic[kImageUrl];
    if (imageURL != [NSNull null])
        menuItem.imageURL = imageURL;

    id description = responseDic[@"MenuDescription"];
    if (description != [NSNull null])
        menuItem.itemDescription = description;
    
    id price = responseDic[@"MenuPrice"];
    if (price != [NSNull null])
        menuItem.itemPrice = price;

    id categoryId = responseDic[@"CategoryId"];
    if (categoryId != [NSNull null])
    {
        MenuCategory *menuCategory = [[DataManager sharedInstance] menuCategoryWithId:categoryId];
        id catName = responseDic[@"CategoryName"];
        if (catName != [NSNull null])
            menuCategory.title = catName;
        
        menuItem.itemCategory = menuCategory;
    }
    [[DataManager sharedInstance] saveContext];
    return menuItem;
}
#pragma mark -MallServices
- (MAService*)parseServiceResponse:(NSDictionary*)responseDic
{
    NSString *serviceId = [responseDic valueForKey:@"Id"];
    MAService * service = [[DataManager sharedInstance] serviceWithId:serviceId];
    
    id name = responseDic[@"FacilityType"];
    if (name != [NSNull null])
        service.name = name;
    
    id imageUrl = responseDic[@"FacilityImageURL"];
    if (imageUrl != [NSNull null])
        service.imageURL = imageUrl;
    
    id phone = responseDic[@"Phone"];
    if (phone != [NSNull null])
        service.phone = phone;
    
    id floor = responseDic[kFloor];
    if (floor != [NSNull null])
        service.floor = floor;
    
    id address = responseDic[kAddress];
    if (address != [NSNull null])
        service.address = address;
    
    id briefText = responseDic[kBriefText];
    if (briefText != [NSNull null])
        service.briefText = briefText;
    
    id mapImageURL = responseDic[@"MapImageURL"];
    if (mapImageURL != [NSNull null])
        service.siteMapURL = mapImageURL;
    
    [[DataManager sharedInstance] saveContext];
    return service;
}
#pragma mark -Timmings
- (NSArray*)parseTimingListResponse:(NSArray*)timingList
{
    NSMutableArray * entityTimings = [[NSMutableArray alloc] init];
    for (NSDictionary *responseDic in timingList)
    {
        NSString *entityId = [responseDic valueForKey:kEntityId];
        
        EntityTiming *entityTiming = [[DataManager sharedInstance] entityTimingWithId:entityId];
        id name = responseDic[kName];
        if (name != [NSNull null])
        {
            if (![name isEqualToString:entityTiming.name])
                entityTiming.name = name;
        }
        id entityType = responseDic[kEntityType];
        if (entityType != [NSNull null])
            entityTiming.entityType = entityType;
        
        Timing *timing = [self parseTimingResponse:responseDic];
        [entityTiming addTimingsObject:timing];
        [[DataManager sharedInstance] saveContext];
        
        NSUInteger index = [entityTimings indexOfObjectPassingTest:^BOOL(id obj,NSUInteger idx,BOOL *stop){
            if ([entityTiming.entityId isEqualToString:[(EntityTiming*)obj entityId]]) {
                *stop = YES;
                return YES;
            }
            return NO;
            }];
        if (index == NSNotFound) {
            [entityTimings addObject:entityTiming];
        }
        else
        {
            [entityTimings removeObjectAtIndex:index];
            [entityTimings addObject:entityTiming];
        }
    }
    return entityTimings;
}
- (Timing *)parseTimingResponse:(NSDictionary*)responseDic
{
    NSString * timingId = [responseDic valueForKey:@"TimingId"];
    Timing * timing = [[DataManager sharedInstance] timingWithId:timingId];
    
    id fromDay = responseDic[kFromDay];
    if (fromDay != [NSNull null])
        timing.fromDay = fromDay;
    
    id toDay = responseDic[kToDay];
    if (toDay != [NSNull null])
        timing.toDay = toDay;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    
    id startTime = responseDic[@"StartTime"];
    if(startTime != [NSNull null])
    {
        NSDate * opening = [dateFormatter dateFromString:startTime];
        timing.openingTime = opening;
    }
    
    id endTime = responseDic[@"EndTime"];
    if(endTime != [NSNull null])
    {
        NSDate * closing = [dateFormatter dateFromString:endTime];
        timing.closingTime = closing;
    }
    return timing;
}
@end
