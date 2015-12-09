//
//  MenuCategory.h
//  SalamCenterApp
//
//  Created by Waseem Asif on 27/10/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MenuItem, Restaurant;

@interface MenuCategory : NSManagedObject

@property (nonatomic, retain) NSString * menuCategoryId;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) Restaurant *restaurant;
@property (nonatomic, retain) NSSet *menuItems;
@end

@interface MenuCategory (CoreDataGeneratedAccessors)

- (void)addMenuItemsObject:(MenuItem *)value;
- (void)removeMenuItemsObject:(MenuItem *)value;
- (void)addMenuItems:(NSSet *)values;
- (void)removeMenuItems:(NSSet *)values;

@end
