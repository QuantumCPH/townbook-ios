//
//  AddTagViewController.m
//  SalamPlanet
//
//  Created by Globit on 24/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "AddTagViewController.h"

@interface AddTagViewController ()
{
    NSMutableArray * tagsArray;
}
@end

@implementation AddTagViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    tagsArray=[[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark: Custom Methods
-(void)addNewTagAsButtoninTagsArrayWithText:(NSString *)textAdded{
    [tagsArray addObject:textAdded];
    self.addTagTF.text=@"";
    //Remove all subviews from tagview
    [self.tagsView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];

    for (int i=0;i<[tagsArray count];i++) {
        NSString * text=[tagsArray objectAtIndex:i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button addTarget:self
               action:@selector(buttonAction:)
         forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:text forState:UIControlStateNormal];
        CGSize stringBoundingBox = [text sizeWithFont:[UIFont fontWithName:@"GillSans" size:17.0]];
        
        button.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        button.backgroundColor=[UIColor colorWithRed:62.0/255.0 green:180.0/255.0 blue:125.0/255.0 alpha:1.0];
        CGRect frame=CGRectMake(10, i*25, stringBoundingBox.width+15, 22);
        button.frame=frame;
        [self.tagsView addSubview:button];
    }
}
#pragma mark: IBActions and Selectors
-(void)buttonAction:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)cancelAction:(id)sender {
    [self.delegate tagsHasBeenSelected:tagsArray];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark: UITextFeild Delegate
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [self addNewTagAsButtoninTagsArrayWithText:textField.text];
    return NO;
}

@end
