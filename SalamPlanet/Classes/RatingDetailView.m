//
//  RatingDetailView.m
//  SalamPlanet
//
//  Created by Globit on 06/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "RatingDetailView.h"

@implementation RatingDetailView

- (id)init{
    self = [self loadFromNib];
    if (self)
    {
        [self setFontsOfItemsInView];
    }
    return self;
}
- (id)loadFromNib
{
    NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"RatingDetailView" owner:nil options:nil];
    return [array objectAtIndex:0];
}
-(void)setFontsOfItemsInView{
    [self.excellentLbl setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:13.0f]];
    [self.excellentCountLbl setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:13.0f]];
    [self.goodLbl setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:13.0f]];
    [self.goodCountLbl setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:13.0f]];
    [self.avgLbl setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:13.0f]];
    [self.avgCountLbl setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:13.0f]];
    [self.poorLbl setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:13.0f]];
    [self.poorCountLbl setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:13.0f]];
    [self.terribleLbl setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:13.0f]];
    [self.terribleCountLbl setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:13.0f]];
}
@end
