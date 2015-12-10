//
//  EventItem.h
//  SalamCenterApp
//
//  Created by Globit on 10/12/2015.
//  Copyright © 2015 Globit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventItem : NSObject

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * desc;
@property (nonatomic, strong) NSString * userName;
@property (nonatomic, strong) NSString * imgName;
@property (nonatomic, strong) NSString * place;
@property (nonatomic, strong) NSString * dateEvent;
@property (nonatomic, strong) NSString * dateCreated;
@end
