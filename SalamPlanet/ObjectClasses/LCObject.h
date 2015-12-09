//
//  LCObject.h
//  SalamCenterApp
//
//  Created by Globit on 26/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCObject : NSObject

@property (nonatomic) NSInteger lcID;
@property (nonatomic, strong) NSString * lcTitle;
@property (nonatomic, strong) NSString * lcShopName;
@property (nonatomic, strong) NSString * lcFrontImgName;
@property (nonatomic, strong) NSString * lcBackImgName;
@property (nonatomic, strong) NSString * lcCardNumber;
@property (nonatomic, strong) NSString * lcBarcodeNumber;
@property (nonatomic, strong) NSString * lcDescription;
@property (nonatomic, strong) NSString * lcBarcodeImgName;
@property (nonatomic, strong) NSString * lcBarcodeName;
@property (nonatomic, strong) UIImage * lcBackImage;
@property (nonatomic, strong) UIImage * lcFrontImage;

-(LCObject*) initWithID:(NSInteger)ID;
@end
