//
//  AddTagView.h
//  SalamPlanet
//
//  Created by Globit on 02/10/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCTagList.h"

@protocol TagViewDelegate
-(void)tagHasBeenRemovedWithNewTagArray:(NSArray *)tagArray;
@end

@interface TagView : UIView<UITextFieldDelegate,GCTagListDataSource, GCTagListDelegate>
{
}
@property (weak, nonatomic) id<TagViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet GCTagList *gcTagView;
@property (strong, nonatomic)NSMutableArray * tagsArray;
-(void)showTags;
-(void)refreshTagsArray:(NSArray *)array;
- (id)initWIthArray:(NSArray *)array;
@end
