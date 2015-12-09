//
//  RestMenuDishCell.h
//  SalamCenterApp
//
//  Created by Globit on 04/02/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestMenuDishCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *detailTV;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UIImageView *dishImageView;

@end
