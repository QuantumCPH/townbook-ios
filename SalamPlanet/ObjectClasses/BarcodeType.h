//
//  BarcodeType.h
//  SalamCenterApp
//
//  Created by Globit on 19/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Barcode.h"

@interface BarcodeType : NSObject

@property (nonatomic) NSInteger barcodeID;
@property (nonatomic, strong) NSString * barcodeName;
@property (nonatomic, strong) NSString * barcodeImageName;
@property (nonatomic, strong) NSString * barcodeType;
-(BarcodeType*)initWithID:(NSInteger)ID;
-(BarcodeType*)initWithBarcodeObj:(Barcode *)barcodeObj;
@end
