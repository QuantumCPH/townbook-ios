//
//  EndorsementComment.m
//  SalamPlanet
//
//  Created by Saad Khan on 19/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "EndorsementComment.h"
#import "EndorsementUser.h"

@implementation EndorsementComment
-(EndorsementComment*) initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    if(self)
    {
    }
    return  self;
}
-(EndorsementComment*) initWithDummy
{
    self = [super init];
    if(self)
    {
        self.commentUser=[[EndorsementUser alloc]initWithDummy];
        self.commentText=@"I liked that place very much and recommend all of you to visit.";
        self.commentDate=@"14-06-14";
    }
    return  self;
}
-(EndorsementComment*)initWithDummyPicture
{
    self = [super init];
    if(self)
    {
        self.commentUser=[[EndorsementUser alloc]initWithDummy];
        self.commentDate=@"14-06-14";
        self.imgShared=@"hotel2.jpg";
    }
    return  self;
}
-(EndorsementComment *) initWIthUser:(EndorsementUser *)user ANDComment:(NSString *)comment{
    self = [super init];
    if(self)
    {
        self.commentUser=user;
        self.commentText=comment;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd-MM-yyyy"];
    
        self.commentDate=[formatter stringFromDate:[NSDate date]];
    }
    return  self;
}
-(EndorsementComment *) initWIthUser:(EndorsementUser *)user ANDImage:(NSString *)imageName{
    self = [super init];
    if(self)
    {
        self.commentUser=user;
        self.imgShared=imageName;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd-MM-yyyy"];
        
        self.commentDate=[formatter stringFromDate:[NSDate date]];
    }
    return  self;
}
-(EndorsementComment *) initWIthUser:(EndorsementUser *)user ANDImageTemp:(UIImage *)image{
    self = [super init];
    if(self)
    {
        self.commentUser=user;
        self.imgSharedTemp=image;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd-MM-yyyy"];
        
        self.commentDate=[formatter stringFromDate:[NSDate date]];
    }
    return  self;
}
@end
