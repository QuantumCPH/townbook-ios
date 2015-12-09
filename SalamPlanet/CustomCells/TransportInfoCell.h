//
//  TransportInfoCell.h
//  SalamCenterApp
//
//  Created by Globit on 28/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"
@interface TransportInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblHeading;
@property (nonatomic, strong) RTLabel *rtLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgVBottomLine;
+ (RTLabel*)textLabel;
-(void)initializrRTLabel;
@end
