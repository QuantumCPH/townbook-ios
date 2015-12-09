//
//  FBLogin.h
//  SalamPlanet
//
//  Created by Saad Khan on 04/11/2014.
//  Copyright (c) 2014 SalamPlanet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "FBUserSelf.h"
@import FBSDKLoginKit;
@import FBSDKCoreKit;

@protocol FBLoginDelegate
-(void)failedToFetchAnyAccount;
-(void)fbProfileHasBeenFetchedSuccessfullyWithInfo:(FBUserSelf *)fbUser;
-(void)fbProfileDidNotFetched;
@end
@interface FBLogin : NSObject
{
    NSString * fbAccountkey;
}
@property (weak, nonatomic) id<FBLoginDelegate> delegate;

@property (strong, nonatomic) ACAccountStore *accountStore;
@property (strong, nonatomic) ACAccount *facebookAccount;
@property (strong, nonatomic) ACAccountType *facebookAccountType;

-(void)facebookAccountInit;
-(id)initWithKey:(NSString *)accountKey;
-(void)loginFB;
@end
