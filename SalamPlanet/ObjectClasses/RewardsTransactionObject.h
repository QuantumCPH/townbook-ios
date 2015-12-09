//
//  RewardsTransactionObject.h
//  SalamCenterApp
//
//  Created by Globit on 17/02/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RewardsTransactionObject : NSObject
@property (nonatomic) NSInteger transID;

@property (nonatomic, strong) NSString * transTitle;
@property (nonatomic, strong) NSString * transShop;
@property (nonatomic, strong) NSString * transDate;
@property (nonatomic, strong) NSString * transImageName;
@property (nonatomic) NSInteger transPoints;
@property (nonatomic) BOOL isPositive;
-(RewardsTransactionObject*) initWithID:(NSInteger)ID;

@end
