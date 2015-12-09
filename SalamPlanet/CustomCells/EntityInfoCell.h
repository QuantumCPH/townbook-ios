//
//  EntityInfoCell.h
//  SalamCenterApp
//
//  Created by Waseem Asif on 19/11/2015.
//  Copyright © 2015 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntityInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *infoImageView;

@property (weak, nonatomic) IBOutlet UILabel *textLbl;
@property (weak, nonatomic) IBOutlet UIButton *entityInfoBtn;

@end
