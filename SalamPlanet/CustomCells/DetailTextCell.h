//
//  DetailTextCell.h
//  SalamCenterApp
//
//  Created by Waseem Asif on 07/12/2015.
//  Copyright © 2015 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTextCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightConstraint;
@property (assign,nonatomic) int detailTextHeight;

@end
