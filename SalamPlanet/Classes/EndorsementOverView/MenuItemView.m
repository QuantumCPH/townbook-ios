//
//  MenuItemView.m
//  SalamPlanet
//
//  Created by Globit on 21/10/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "MenuItemView.h"

@implementation MenuItemView

- (id)init{
    self = [self loadFromNib];
    if (self)
    {
    }
    return self;
}
- (id)initWithItem:(NSString *)item{
    self = [self loadFromNib];
    if (self)
    {
        self.itemLbl.text=item;
    }
    return self;
}
- (id)loadFromNib
{
    NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"MenuItemView" owner:nil options:nil];
    return [array objectAtIndex:0];
}

@end
