//
//  AddTagView.m
//  SalamPlanet
//
//  Created by Globit on 02/10/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "TagView.h"

@implementation TagView
@synthesize delegate;
@synthesize tagsArray;

- (id)init{
    self = [self loadFromNib];
    if (self)
    {
        tagsArray=[[NSMutableArray alloc]init];
    }
    return self;
}

- (id)initWIthArray:(NSArray *)array{
    self = [self loadFromNib];
    if (self)
    {
        tagsArray=[[NSMutableArray alloc]initWithArray:array];
    }
    return self;
}
-(void)willMoveToSuperview:(UIView *)newSuperview{
}
- (id)loadFromNib
{
    NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"TagView" owner:nil options:nil];
    return [array objectAtIndex:0];
}
-(void)showTags{
    [self.gcTagView reloadData];
}
-(void)refreshTagsArray:(NSArray *)array{
    [tagsArray removeAllObjects];
    for (int i=0;i<[array count];i++) {
        NSString * string=[array objectAtIndex:i];
        [tagsArray addObject:string];
    }
    [self.gcTagView reloadData];
}
#pragma mark: GCTagList DataSource
- (NSInteger)numberOfTagLabelInTagList:(GCTagList *)tagList {
    return self.tagsArray.count;
}

- (GCTagLabel*)tagList:(GCTagList *)tagList tagLabelAtIndex:(NSInteger)index {
    
    static NSString* identifier = @"TagLabelIdentifier";
    
    GCTagLabel* tag = [tagList dequeueReusableTagLabelWithIdentifier:identifier];
    if(!tag) {
        tag = [GCTagLabel tagLabelWithReuseIdentifier:identifier];
        
        tag.gradientColors = [GCTagLabel defaultGradoentColors];
        
        [tag setCornerRadius:6.f];
    }
    
    NSString* labelText = self.tagsArray[index];
    
    /**
     * you can change the AccrssoryType with method setLabelText:accessoryType:
     * or with no accessoryButton with method setLabelText:
     */
    
    /* way 1 */
    GCTagLabelAccessoryType type = GCTagLabelAccessoryCrossSign;
    [tag setLabelText:labelText
        accessoryType:type];
    
    
    //way 2
    //[tag setLabelText:labelText];
    
    return tag;
}

- (void)tagList:(GCTagList *)tagList accessoryButtonTappedAtIndex:(NSInteger)index {
    
    /**
     * this is the delete method how to use.
     */
    /**
     [self.tagNames removeObjectsInRange:NSMakeRange(index, 2)];
     [tagList deleteTagLabelWithRange:NSMakeRange(index, 2)];
     [tagList deleteTagLabelWithRange:NSMakeRange(index, 2) withAnimation:YES];
     */
    
    
    /**
     * this is the reload method how to use.
     */
    /**
     self.tagNames[index] = @"Kim Jong Kook";
     [tagList reloadTagLabelWithRange:NSMakeRange(index, 1)];
     [tagList reloadTagLabelWithRange:NSMakeRange(index, 1) withAnimation:YES];
     
     self.tagNames[index] = @"Kim Jong Kook";
     self.tagNames[index+1] = @"Girls' Generation";
     [tagList reloadTagLabelWithRange:NSMakeRange(index, 2) withAnimation:YES];
     */
    
    /**
     * this is the insert method how to use.
     */
    //    [self.tagNames insertObject:@"Girls' Generation" atIndex:index];
    //    [self.tagNames insertObject:@"TaeTiSeo" atIndex:index];
    [self.tagsArray removeObjectAtIndex:index];
    [delegate tagHasBeenRemovedWithNewTagArray:tagsArray];
    //    [tagList insertTagLabelWithRange:NSMakeRange(index, 2) withAnimation:YES];
    [self.gcTagView reloadData];
}

- (void)tagList:(GCTagList *)taglist didChangedHeight:(CGFloat)newHeight {
    NSLog(@"%s:%.1f", __func__, newHeight);
}

//- (NSString*)tagList:(GCTagList *)tagList labelTextForGroupTagLabel:(NSInteger)interruptIndex {
//    return [NSString stringWithFormat:@"和其他%d位", self.tagsArray.count - interruptIndex];
//}

//- (void)tagList:(GCTagList *)taglist didSelectedLabelAtIndex:(NSInteger)index {
//    [taglist deselectedLabelAtIndex:index animated:YES];
//}

/**
 *
 */
- (NSInteger)maxNumberOfRowAtTagList:(GCTagList *)tagList {
    return 5;
}

- (GCTagLabelAccessoryType)accessoryTypeForGroupTagLabel {
    return GCTagLabelAccessoryArrowSign;
}

@end
