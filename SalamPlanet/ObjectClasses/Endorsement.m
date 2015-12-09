//
//  Endorsement.m
//  SalamPlanet
//
//  Created by Saad Khan on 19/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "Endorsement.h"

@implementation Endorsement
-(Endorsement*) initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    if(self)
    {
    }
    return  self;
}
-(Endorsement*) initWithDummy
{
    self = [super init];
    if(self)
    {
        self.endrID=@"01";
        self.endrTitle=@"Nova";
        self.endrByUser=[[EndorsementUser alloc]initWithDummy];
        self.endrRating=3;
        self.endrImageURL=@"hotel1.jpeg";
        self.endrDates=@"02-09-2014";
        self.endrComment=@"Shoping at Nova was the best experiance ever! I got everything on such a low price!";
    }
    return  self;
}
//-(Endorsement*) initWithCreateInAppWth:(NSString *)title ANDRating:(int)rating ANDImagesArray:(NSArray *)imgArray ANDComment:(NSString *)comment
//{
//    self = [super init];
//    if(self)
//    {
//        self.endrID=@"01";
//        self.endrTitle=title;
//        self.endrByUser=[[EndorsementUser alloc]initWithDummy];
//        self.endrRating=rating;
//        self.endrImageArray=imgArray;
//        self.endrDates=@"02-09-2014";
//        self.endrComment=comment;
//    }
//    return  self;
//}
@end
