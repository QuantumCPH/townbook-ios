//
//  NSString+Helpers.m
//  SalamCenterApp
//
//  Created by Waseem Asif on 16/09/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import "NSString+Helpers.h"

@implementation NSString (Helpers)

- (BOOL)isEmpty
{
    if(self == nil && self.length == 0) { //string is empty or nil
        return YES;
    }
    if(![[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]) {
        //string is all whitespace
        return YES;
    }
    return NO;
}
- (BOOL)isValidEmail
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
@end
