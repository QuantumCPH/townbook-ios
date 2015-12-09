//
//  AddTagView.m
//  SalamPlanet
//
//  Created by Globit on 02/10/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "AddTagView.h"

@implementation AddTagView
@synthesize delegate;
@synthesize tagsArray;

- (id)init{
    self = [self loadFromNib];
    if (self)
    {
        tagsArray=[[NSMutableArray alloc]init];
        self.inputTF.delegate=self;
//        [self.inputTF becomeFirstResponder];
        self.bubbleView.delegate=self;
    }
    return self;
}

- (id)initWIthArray:(NSArray *)array{
    self = [self loadFromNib];
    if (self)
    {
        tagsArray=[[NSMutableArray alloc]initWithArray:array];
        self.inputTF.delegate=self;
//        [self.inputTF becomeFirstResponder];
        self.bubbleView.delegate=self;
    }
    return self;
}
-(void)willMoveToSuperview:(UIView *)newSuperview{
    [self.inputTF becomeFirstResponder];
}
- (id)loadFromNib
{
    NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"AddTagView" owner:nil options:nil];
    return [array objectAtIndex:0];
}

#pragma mark: UITextFeild delegates
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
//    [textField resignFirstResponder];
    [tagsArray addObject:textField.text];
    textField.text=@"";
    [self showBubbleButtonsForTags];

    return NO;
}
-(void)showBubbleButtonsForTags{
    // Create colors for buttons
    UIColor *textColor = [UIColor colorWithRed:255/255.0 green:47/255.0 blue:51/255.0 alpha:1.0];
    UIColor *bgColor = [UIColor colorWithRed:254/255.0 green:255/255.0 blue:235/255.0 alpha:1.0];
    
    [self.bubbleView removeBubbleButtonsWithInterval:0.0000001];
    // Now make them sucka's.
    [self.bubbleView fillBubbleViewWithButtons:tagsArray bgColor:bgColor textColor:textColor fontSize:14];
}

- (IBAction)doneAction:(id)sender {
    [delegate tagsHasSelected:tagsArray];
    [self.inputTF resignFirstResponder];
    [self removeFromSuperview];
}

- (IBAction)cancelAction:(id)sender {
    [self removeFromSuperview];
    [delegate tagsViewIsCanceled];
}
#pragma mark:BBView Delegate
-(void)didClickBubbleButton:(UIButton *)bubble{
    NSInteger index=bubble.tag;
    if(index<[tagsArray count]){
        [tagsArray removeObjectAtIndex:index];
    }
    [self showBubbleButtonsForTags];
}

@end
