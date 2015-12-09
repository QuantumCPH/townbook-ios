//
//  MenuItemView.h
//  SalamPlanet
//
//  Created by Globit on 21/10/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuItemView : UIView
@property (weak, nonatomic) IBOutlet UILabel *itemLbl;
- (id)initWithItem:(NSString *)item;
@end
