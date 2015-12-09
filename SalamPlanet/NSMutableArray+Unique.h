//
//  NSMutableArray+Unique.h
//  SalamCenterApp
//
//  Created by Waseem Asif on 02/12/2015.
//  Copyright © 2015 Globit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Unique)

- (void)addObjectsFromArray:(NSArray *)otherArray excludingDuplicates:(BOOL)excludeDuplicates;

@end
