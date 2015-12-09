//
//  RestMenuDish.h
//  SalamCenterApp
//
//  Created by Globit on 04/02/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestMenuDish : NSObject
@property (nonatomic) NSInteger dishID;
@property (nonatomic, strong) NSString * dishType;
@property (nonatomic, strong) NSString * dishTitle;
@property (nonatomic, strong) NSString * dishDetail;
@property (nonatomic, strong) NSString * dishPrice;

-(RestMenuDish*) initWithID:(NSInteger)ID;
@end
