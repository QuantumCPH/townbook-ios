//
//  SelectBarcodeCell.m
//  SalamCenterApp
//
//  Created by Globit on 19/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import "SelectBarcodeCell.h"

@implementation SelectBarcodeCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        self.backgroundColor = [UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1];
        self.barcodeTypeTF.textColor=[UIColor whiteColor];
    } else {
        self.backgroundColor = [UIColor clearColor];
        self.barcodeTypeTF.textColor=[UIColor blackColor];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        self.backgroundColor = [UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1];
        self.barcodeTypeTF.textColor=[UIColor whiteColor];
    } else {
        self.backgroundColor = [UIColor clearColor];
        self.barcodeTypeTF.textColor=[UIColor blackColor];
    }
}

@end
