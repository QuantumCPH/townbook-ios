//
//  CategoryCell.h
//  SalamPlanet
//
//  Created by Globit on 25/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgVw;
@property (weak, nonatomic) IBOutlet UILabel *txtLbl;

@property (weak, nonatomic) IBOutlet UIImageView *imgPressed;
@end
