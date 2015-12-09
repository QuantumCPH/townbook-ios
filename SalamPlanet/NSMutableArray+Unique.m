

//
//  NSMutableArray+Unique.m
//  SalamCenterApp
//
//  Created by Waseem Asif on 02/12/2015.
//  Copyright © 2015 Globit. All rights reserved.
//

#import "NSMutableArray+Unique.h"

@implementation NSMutableArray (Unique)

- (void)addObjectsFromArray:(NSArray *)otherArray excludingDuplicates:(BOOL)excludeDuplicates
{
    if (excludeDuplicates) {

        NSMutableArray* mutableArray = [[NSMutableArray alloc] initWithArray:otherArray];
        NSIndexSet* duplicateObjectsIndexes = [mutableArray indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger index, BOOL* stop){
            return [self containsObject:obj];
        }];
        [mutableArray removeObjectsAtIndexes:duplicateObjectsIndexes];
        [self addObjectsFromArray:mutableArray];
    }
    else {
        [self addObjectsFromArray:otherArray];
    }
}

@end
