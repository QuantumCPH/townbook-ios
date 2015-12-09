//
//  EndrCommentsViewController.m
//  SalamPlanet
//
//  Created by Globit on 29/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "EndrCommentsViewController.h"
#import "EndorsementComment.h"
#import "EndrCommentImageCell.h"
#import "EndorsementUser.h"
#import "UserProfileVC.h"
#import "AppDelegate.h"

//#define kOFFSET_FOR_KEYBOARD 216.0

@interface EndrCommentsViewController ()
{
    BOOL isKeyBoardAppeared;
    NSMutableArray * mainArray;
    EndorsementUser * meUser;
    AppDelegate * appDelegate;
    
    NSDictionary * endoreDictMain;
    NSDictionary * userDictMain;
    float offset_for_keyboard;
}

@end

@implementation EndrCommentsViewController
- (id)initWithEndrDictMain:(NSDictionary*)endrDict ANDEndrUserMain:(NSDictionary *)userMain
{
    self = [super initWithNibName:@"EndrCommentsViewController" bundle:nil];
    if (self) {
        endoreDictMain=[[NSDictionary alloc]initWithDictionary:endrDict];
        userDictMain=[[NSDictionary alloc]initWithDictionary:userMain];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([endoreDictMain valueForKey:kTempEndrName]) {
        self.titleLbl.text=[endoreDictMain valueForKey:kTempEndrName];
    }
    mainArray=[[NSMutableArray alloc]init];
    [self loadMainArray];
    meUser=[[EndorsementUser alloc]initWithDummy];
    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    appDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [appDelegate hideBottomTabBar:YES];
    
    NSNotificationCenter * notifCenter=[NSNotificationCenter defaultCenter];
    [notifCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [notifCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    NSNotificationCenter * notifCenter=[NSNotificationCenter defaultCenter];
    [notifCenter removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [notifCenter removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark: Keyboard Hide/Show Methods
-(void)setKeyBoardHeightWithNotificationInfo:(NSNotification *)notif{
    //Set KeyBoard Height
    NSDictionary* keyboardInfo = [notif userInfo];
    NSValue* keyboardFrameEnd = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameEndRect = [keyboardFrameEnd CGRectValue];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    //This thing is for iOS Suggestion View on keyboard
    if (keyboardFrameBeginRect.size.height==keyboardFrameEndRect.size.height) {
    }
    else{
        [self updateTheMainViewHeightForSuggestionKeyboardWithHeight:(keyboardFrameBeginRect.size.height-keyboardFrameEndRect.size.height)];
    }
    offset_for_keyboard=keyboardFrameEndRect.size.height;
    //
}
-(void)updateTheMainViewHeightForSuggestionKeyboardWithHeight:(double)value{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    CGRect rect = self.mainView.frame;
    rect.size.height += value;
    
    self.mainView.frame = rect;
    [UIView commitAnimations];
}
- (void)keyboardWillHide:(NSNotification *)notif {
    if(isKeyBoardAppeared){
        [self setViewMoveUp:NO];
    }
    isKeyBoardAppeared=NO;
}

- (void)keyboardWillShow:(NSNotification *)notif{
    [self setKeyBoardHeightWithNotificationInfo:notif];
    if(!isKeyBoardAppeared){
        [self setViewMoveUp:YES];
    }
    isKeyBoardAppeared=YES;
    //Scroll the tableview to bottom
    NSIndexPath* ipath = [NSIndexPath indexPathForRow: mainArray.count-1 inSection: 0];
    [self.tableView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionBottom animated: YES];
}

-(void)setViewMoveUp:(BOOL)moveUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    CGRect rect = self.mainView.frame;
    if (moveUp)
    {
        rect.size.height -= offset_for_keyboard;
    }
    else
    {
        rect.size.height += offset_for_keyboard;
    }
    self.mainView.frame = rect;
    [UIView commitAnimations];
}

#pragma mark:Custom Methods
-(void)loadMainArray{
    EndorsementComment * endorCmt1=[[EndorsementComment alloc]initWithDummy];
    EndorsementComment * endorCmt2=[[EndorsementComment alloc]initWithDummy];

    [mainArray addObject:@"mainEndorsementInfo"];
    [mainArray addObject:endorCmt1];
    [mainArray addObject:endorCmt2];
}
-(CGSize)calculateSizeForText:(NSString *)txt{
    
    CGSize maximumLabelSize = CGSizeMake(228, 180);
    CGSize expectedSectionSize = [txt sizeWithFont:self.samplLbl.font
                                               constrainedToSize:maximumLabelSize
                                                   lineBreakMode:NSLineBreakByTruncatingTail];
    return expectedSectionSize;
}
-(IBAction)insertNewComment:(id)sender{
    if([self.commentTF.text length]==0){
        return;
    }
    EndorsementComment * endrCmt=[[EndorsementComment alloc]initWIthUser:meUser ANDComment:self.commentTF.text];
    [mainArray addObject:endrCmt];
    [self.tableView reloadData];
    [self scrollTableViewToBottom];
    self.commentTF.text=@"";
    
}
-(void)insertNewCommentImage:(UIImage *)img{
    EndorsementComment * endrCmt=[[EndorsementComment alloc]initWIthUser:meUser ANDImageTemp:img];
    [mainArray addObject:endrCmt];
    [self.tableView reloadData];
    [self scrollTableViewToBottom];
}
-(void)scrollTableViewToBottom{
    //Scroll the tableview to bottom
    NSIndexPath* ipath = [NSIndexPath indexPathForRow: mainArray.count-1 inSection: 0];
    [self.tableView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionBottom animated: YES];
}
#pragma mark: UITableView Delegates and Datasource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mainArray count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 158.0;
    }
    
    EndorsementComment * endrCmt=[mainArray objectAtIndex:indexPath.row];
    if (endrCmt.imgSharedTemp) {
        return 210;
    }
    return 64+[self calculateSizeForText:endrCmt.commentText].height+10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        static NSString *identifier=@"endorseCommentCell";
    
        EndoreCommentViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            NSArray * nibArray = [[NSBundle mainBundle] loadNibNamed:@"EndoreCommentViewCell" owner:nil options:nil];
            cell = (EndoreCommentViewCell*)[nibArray objectAtIndex:0];
        }
        [cell loadDictData:endoreDictMain ANDUserDict:userDictMain];
        cell.delegate=self;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    static NSString *identifierCommentCell=@"endorseCmtCell";
    static NSString *identifierCommentImgCell=@"endorseCmtImgCell";
    
    EndorsementComment * endrCmt=[mainArray objectAtIndex:indexPath.row];
    if (endrCmt.imgSharedTemp) {
        EndrCommentImageCell * cell = [tableView dequeueReusableCellWithIdentifier:identifierCommentImgCell];
        if (!cell) {
            NSArray * nibArray = [[NSBundle mainBundle] loadNibNamed:@"EndrCommentImageCell" owner:nil options:nil];
            cell = (EndrCommentCell*)[nibArray objectAtIndex:0];
        }
        [cell loadEndrCommentData:[mainArray objectAtIndex:indexPath.row]];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    else{
        EndrCommentCell * cell = [tableView dequeueReusableCellWithIdentifier:identifierCommentCell];
        if (!cell) {
            NSArray * nibArray = [[NSBundle mainBundle] loadNibNamed:@"EndrCommentCell" owner:nil options:nil];
            cell = (EndrCommentCell*)[nibArray objectAtIndex:0];
        }
        [cell loadEndrCommentData:[mainArray objectAtIndex:indexPath.row]];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.delegate=self;
        return cell;
    }
}

#pragma mark: IBActions and Selector Methods


- (IBAction)goBackAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addImageCommentAction:(id)sender {
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        [imagePickerController.navigationBar setTintColor:[UIColor colorWithRed:243.0/255.0 green:185.0/255.0 blue:0.0/255.0 alpha:1]];
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
    else
    {
        ShowMessage(@"Error", @"Sorry! Photo Library is not available");
    }
    
}
#pragma mark:EndorsementCellDelegate
-(void)goToUserProfileAction{
    UserProfileVC * userProfileVC=[[UserProfileVC alloc]init];
    [self.navigationController pushViewController:userProfileVC animated:YES];

}
#pragma mark:EndoreCommentViewCellDelegate
-(void)goToUserProfileFromCommentCellAction{
    UserProfileVC * userProfileVC=[[UserProfileVC alloc]init];
    [self.navigationController pushViewController:userProfileVC animated:YES];
}
#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage =info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self insertNewCommentImage:chosenImage];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma TextField Delegates
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
//    [textField resignFirstResponder];
//    return YES;
    [self insertNewComment:nil];
    return NO;
}
@end
