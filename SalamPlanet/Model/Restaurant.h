//
//  Restaurant.h
//  SalamCenterApp
//
//  Created by Waseem Asif on 27/10/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Entity.h"

@class MenuCategory, User;

@interface Restaurant : Entity

@property (nonatomic, retain) NSString * floor;
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) NSSet *menuCategories;
@end

@interface Restaurant (CoreDataGeneratedAccessors)

- (void)addMenuCategoriesObject:(MenuCategory *)value;
- (void)removeMenuCategoriesObject:(MenuCategory *)value;
- (void)addMenuCategories:(NSSet *)values;
- (void)removeMenuCategories:(NSSet *)values;

@end
