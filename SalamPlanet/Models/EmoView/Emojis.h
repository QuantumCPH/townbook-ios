//
//  Emojis.h
//  EmoViewControllerExample
//
//  Created by tian li on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Emojis : NSObject {
    NSArray* _allEmojis;
}

//return our big list of hard-coded emojis
-(NSArray*)allEmojis;

@end
