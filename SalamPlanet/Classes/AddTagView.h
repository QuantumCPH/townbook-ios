//
//  AddTagView.h
//  SalamPlanet
//
//  Created by Globit on 02/10/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBView.h"

@protocol AddTagViewDelegate
-(void)tagsHasSelected:(NSArray *)tagsArray;
-(void)tagsViewIsCanceled;
@end

@interface AddTagView : UIView<UITextFieldDelegate,BBDelegate>
{
}
@property (weak, nonatomic) id<AddTagViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *inputTF;
@property (weak, nonatomic) IBOutlet BBView *bubbleView;
@property (strong, nonatomic)NSMutableArray * tagsArray;
- (IBAction)doneAction:(id)sender;
- (IBAction)cancelAction:(id)sender;
-(void)showBubbleButtonsForTags;
- (id)initWIthArray:(NSArray *)array;
@end
