//
//  MenuItem.h
//  SalamCenterApp
//
//  Created by Waseem Asif on 27/10/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MenuCategory;

@interface MenuItem : NSManagedObject

@property (nonatomic, retain) NSString * menuItemId;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * itemDescription;
@property (nonatomic, retain) NSString * itemPrice;
@property (nonatomic, retain) MenuCategory *itemCategory;

@end
