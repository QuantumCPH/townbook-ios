//
//  LoyaltyCard.h
//  SalamCenterApp
//
//  Created by Waseem Asif on 03/12/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface LoyaltyCard : NSManagedObject

@property (nonatomic, retain) NSString * backImageString;
@property (nonatomic, retain) NSString * backImageURL;
@property (nonatomic, retain) NSString * barcode;
@property (nonatomic, retain) NSString * barcodeImageURL;
@property (nonatomic, retain) NSString * barcodeType;
@property (nonatomic, retain) NSString * cardId;
@property (nonatomic, retain) NSString * cardNumber;
@property (nonatomic, retain) NSString * frontImageString;
@property (nonatomic, retain) NSString * frontImageURL;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * providerName;
@property (nonatomic, retain) NSDate * issueDate;
@property (nonatomic, retain) NSDate * expiryDate;
@property (nonatomic, retain) User *cardUser;

@end
