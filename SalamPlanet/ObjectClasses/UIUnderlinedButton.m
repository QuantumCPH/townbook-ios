//
//  UIUnderlinedButton.m
//  SalamPlanet
//
//  Created by Globit on 11/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "UIUnderlinedButton.h"

@implementation UIUnderlinedButton

+ (UIUnderlinedButton*) underlinedButton {
    UIUnderlinedButton* button = [[UIUnderlinedButton alloc] init];
    return button;
}
- (void) drawRect:(CGRect)rect {
    CGRect textRect = self.titleLabel.frame;
    
    // need to put the line at top of descenders (negative value)
    CGFloat descender = self.titleLabel.font.descender;
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    // set to same colour as text
    CGContextSetStrokeColorWithColor(contextRef, self.titleLabel.textColor.CGColor);
    
    CGContextMoveToPoint(contextRef, textRect.origin.x, textRect.origin.y + textRect.size.height + descender+2);

    
    CGContextAddLineToPoint(contextRef, textRect.origin.x + textRect.size.width, textRect.origin.y + textRect.size.height + descender+2);
    
    CGContextClosePath(contextRef);
    
    CGContextDrawPath(contextRef, kCGPathStroke);
}

@end
