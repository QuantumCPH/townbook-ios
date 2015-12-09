//
//  OfferObject.h
//  SalamCenterApp
//
//  Created by Globit on 26/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OfferObject : NSObject

@property (nonatomic) NSInteger offerID;
@property (nonatomic, strong) NSString * offerTitle;
@property (nonatomic, strong) NSString * offerImgName;
@property (nonatomic) NSInteger offerOffPercent;

-(OfferObject*) initWithID:(NSInteger)ID;
@end
