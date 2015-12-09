//
//  AddTagViewController.h
//  SalamPlanet
//
//  Created by Globit on 24/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddTagsViewControllerDelegate
-(void)tagsHasBeenSelected:(NSArray *)tagsArray;
@end

@interface AddTagViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) id<AddTagsViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *addTagTF;
@property (weak, nonatomic) IBOutlet UIView *tagsView;
- (IBAction)cancelAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;


@end
