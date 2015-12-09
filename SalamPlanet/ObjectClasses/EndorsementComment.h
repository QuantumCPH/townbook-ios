//
//  EndorsementComment.h
//  SalamPlanet
//
//  Created by Saad Khan on 19/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EndorsementUser.h"

@interface EndorsementComment : NSObject

@property (nonatomic, strong) EndorsementUser * commentUser;
@property (nonatomic, strong) NSString * commentText;
@property (nonatomic, strong) NSString * commentDate;
@property (nonatomic, strong) NSString * imgShared;
@property (nonatomic, strong) UIImage * imgSharedTemp;

-(EndorsementComment*) initWithDictionary:(NSDictionary*)dict;
-(EndorsementComment*) initWithDummy;
-(EndorsementComment*) initWithDummyPicture;
-(EndorsementComment*) initWIthUser:(EndorsementUser *)user ANDComment:(NSString *)comment;
-(EndorsementComment*) initWIthUser:(EndorsementUser *)user ANDImage:(NSString *)imageName;
-(EndorsementComment *) initWIthUser:(EndorsementUser *)user ANDImageTemp:(UIImage *)image;
@end
