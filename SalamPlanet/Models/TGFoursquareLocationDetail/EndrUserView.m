//
//  EndrUserView.m
//  SalamPlanet
//
//  Created by Globit on 30/10/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "EndrUserView.h"

@implementation EndrUserView
@synthesize delegate;
- (id)init{
    self = [self loadFromNib];
    if (self)
    {
    }
    return self;
}

- (id)loadFromNib
{
    NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"EndrUserView" owner:nil options:nil];
    return [array objectAtIndex:0];
}

- (IBAction)gotoProfileBtn:(id)sender {
    [delegate goToUserProfileViewPressed];
}

- (IBAction)closeAction:(id)sender {
    [delegate removeThePictureView];
}

-(void)loadViewWith:(UIImage *)img ANDName:(NSString *)name ANDDate:(NSString *)date{
    self.imgView.image=img;
    self.nameLbl.text=name;
    self.dateLbl.text=date;
    [UtilsFunctions makeUIImageViewRound:self.imgView ANDRadius:20];
}
@end
