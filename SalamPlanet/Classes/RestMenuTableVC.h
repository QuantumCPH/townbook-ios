//
//  RestMenuTableVC.h
//  SalamCenterApp
//
//  Created by Globit on 04/02/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestMenuDishCell.h"

@interface RestMenuTableVC : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *menuItems;
- (id)initWithDishesArray:(NSArray *)array;
@end
