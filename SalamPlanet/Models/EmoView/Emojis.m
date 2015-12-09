//
//  Emojis.m
//  EmoViewControllerExample
//
//  Created by tian li on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Emojis.h"

@implementation Emojis

-(id)init {
    self = [super init];
    if(self) {
        _allEmojis = [[NSArray arrayWithObjects:
                      @"😄", @"😊", @"😃", @"😉", @"😍", @"😘", @"😚", @"😳", @"😌", @"😁", @"😜", @"😝", @"😒", @"😏", @"😓", @"😔", @"😞", @"😖", @"😥", @"😰", @"😨", @"😣", @"😢", @"😭", @"😂", @"😲", @"😱", @"😠", @"😡", @"😪", @"😷", @"👿", @"👽", @"💛", @"💙", @"💜", @"💗", @"💚", @"💔", @"💓", @"💘✨", @"🌟", @"💤", @"🎵", @"🔥", @"💩", @"👍", @"👎", @"👌", @"💝", @"🎎", @"🎒", @"🎓", @"🎏", @"🎆", @"🎃", @"🎄", @"🎁", @"🔔", @"💿", @"📷", @"💻", @"💡", nil]retain];
    }
    return self;
}
-(NSArray*) allEmojis {
    return _allEmojis;
}

-(void)dealloc {
    [_allEmojis release];
    [super dealloc];
}
@end
