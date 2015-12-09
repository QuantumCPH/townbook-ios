//
//  Endorsement.h
//  SalamPlanet
//
//  Created by Saad Khan on 19/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EndorsementUser.h"

@interface Endorsement : NSObject

@property (nonatomic, strong) NSString * endrID;
@property (nonatomic, strong) NSString * endrTitle;
@property (nonatomic, strong) EndorsementUser * endrByUser;
@property (nonatomic) int endrRating;
@property (nonatomic, strong) NSString * endrImageURL;
@property (nonatomic, strong) NSArray * endrImageArray;
@property (nonatomic, strong) NSString * endrDates;

@property (nonatomic, strong) NSString * endrComment;

-(Endorsement*) initWithDictionary:(NSDictionary*)dict;
-(Endorsement*) initWithDummy;
@end
