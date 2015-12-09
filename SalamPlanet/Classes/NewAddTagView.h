//
//  AddTagView.h
//  SalamPlanet
//
//  Created by Globit on 02/10/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCTagList.h"

@protocol NewAddTagViewDelegate
-(void)tagsHasSelected:(NSArray *)tagsArray;
-(void)tagsViewIsCanceled;
-(void)heightOfTagViewHasBeenChanged;
@end

@interface NewAddTagView : UIView<UITextFieldDelegate,GCTagListDataSource, GCTagListDelegate>
{
}
@property (weak, nonatomic) id<NewAddTagViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *inputTF;
@property (weak, nonatomic) IBOutlet GCTagList *gcTagView;
@property (strong, nonatomic)NSMutableArray * tagsArray;

@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
- (IBAction)addTagAction:(id)sender;


@property (nonatomic)CGFloat heightOfView;

- (IBAction)doneAction:(id)sender;
- (IBAction)cancelAction:(id)sender;
-(void)showTags;
- (id)initWIthArray:(NSArray *)array;
-(void)refreshTagsArray:(NSArray *)array;
@end
