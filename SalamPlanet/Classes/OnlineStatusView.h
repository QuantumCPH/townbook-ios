//
//  OnlineStatusView.h
//  SalamPlanet
//
//  Created by Globit on 20/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnlineStatusView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *statusImg;
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;

-(void)setStatusViewWithIsOnline:(BOOL)isOnline;
@end
