//
//  OnlineStatusView.m
//  SalamPlanet
//
//  Created by Globit on 20/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "OnlineStatusView.h"

@implementation OnlineStatusView

- (id)init{
    self = [self loadFromNib];
    if (self)
    {
    }
    return self;
}
- (id)loadFromNib
{
    NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"OnlineStatusView" owner:nil options:nil];
    return [array objectAtIndex:0];
}
-(void)setStatusViewWithIsOnline:(BOOL)isOnline{
    if (isOnline) {
        self.statusImg.image=[UIImage imageNamed:@"moonS-selected"];
        self.statusLbl.text=@"Online";
        self.statusLbl.textColor=[UIColor colorWithRed:73.0/255.0 green:189.0/255.0 blue:143.0/255.0 alpha:1];
    }
    else{
        self.statusImg.image=[UIImage imageNamed:@"moonS"];
        self.statusLbl.text=@"Offline";
        self.statusLbl.textColor=[UIColor colorWithRed:119.0/255.0 green:119.0/255.0 blue:119.0/255.0 alpha:1];
    }
}
@end
