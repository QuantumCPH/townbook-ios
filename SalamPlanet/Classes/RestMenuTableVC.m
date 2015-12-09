//
//  RestMenuTableVC.m
//  SalamCenterApp
//
//  Created by Globit on 04/02/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import "RestMenuTableVC.h"
#import "RestMenuDish.h"
#import "MenuItem.h"
#import "UIImageView+WebCache.h"

@interface RestMenuTableVC ()
{
    NSMutableArray * mainArray;
}
@end

@implementation RestMenuTableVC
- (id)initWithDishesArray:(NSArray *)array
{
    self = [super initWithNibName:@"RestMenuTableVC" bundle:nil];
    if (self) {
        mainArray=[[NSMutableArray alloc]initWithArray:array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}
#pragma mark - Custom Method
-(CGSize)calculateSizeForText:(NSString *)txt{
    NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:txt]; // your attributed string
    CGFloat width = 208; // whatever your desired width is
    CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    return rect.size;
}

#pragma mark - UITableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return 80.0;
    MenuItem *menuItem = self.menuItems[indexPath.row];
    CGFloat rowHeight = [self calculateSizeForText:menuItem.itemDescription].height+50;
//    RestMenuDish *dish=[mainArray objectAtIndex:indexPath.row];
//    CGFloat rowHeight = [self calculateSizeForText:dish.dishDetail].height+50;
    if (rowHeight <120)
        rowHeight = 120;
    return rowHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuItems.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RestMenuDishCell * cell=[tableView dequeueReusableCellWithIdentifier:@"restMenuDishCell"];
    if (!cell) {
        NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"RestMenuDishCell" owner:self options:nil];
        cell=[array objectAtIndex:0];
    }
    //RestMenuDish *dish=[mainArray objectAtIndex:indexPath.row];
    MenuItem *menuItem = self.menuItems[indexPath.row];
    cell.titleLbl.text = menuItem.title;
    cell.detailTV.text = menuItem.itemDescription;
    cell.priceLbl.text = menuItem.itemPrice;
    [cell.dishImageView setImageWithURL:[NSURL URLWithString:menuItem.imageURL] placeholderImage:[UIImage imageNamed:@"place-holder"]];
    cell.selectionStyle=UITableViewCellSeparatorStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath :(NSIndexPath *)indexPath{
}

@end
