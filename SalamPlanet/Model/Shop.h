//
//  Shop.h
//  SalamCenterApp
//
//  Created by Waseem Asif on 20/10/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Entity.h"

@class User;

@interface Shop : Entity

@property (nonatomic, retain) NSString * floor;
@property (nonatomic, retain) User *user;

@end
