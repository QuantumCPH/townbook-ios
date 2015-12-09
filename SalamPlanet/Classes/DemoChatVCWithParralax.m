//
//  DemoChatVCWithParralax.h
//  SalamPlanet
//
//  Created by Globit on 01/10/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "DemoChatVCWithParralax.h"
#import "PTSMessagingCell.h"
#import "PTSImageCell.h"
#import "ChatMessage.h"
#import "EndoreMsgCell.h"
#import "AppDelegate.h"
#import "ChatSettingsVC.h"
#import "UEndoreMsgCell.h"
#import "DemoViewController.h"

//#define kOFFSET_FOR_KEYBOARD 216.0
#define kOFFSET_FOR_BOTTOM_OPTION_BAR 70.0
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

//For Parralaz Effect
#define HEADER_HEIGHT 320.0f
#define HEADER_INIT_FRAME CGRectMake(0, 0, self.view.frame.size.width, HEADER_HEIGHT)
#define TOOLBAR_INIT_FRAME CGRectMake (0, 292, 320, 22)

const CGFloat kBarHeight = 50.0f;
const CGFloat kBackgroundParallexFactor = 0.5f;
const CGFloat kBlurFadeInFactor = 0.005f;
const CGFloat kTextFadeOutFactor = 0.05f;
const CGFloat kCommentCellHeight = 50.0f;
//////end


@interface DemoChatVCWithParralax()
{
    //For Parralaz Effect
    UIScrollView *_mainScrollView;
    UIScrollView *_backgroundScrollView;
    //////end
    
    NSMutableArray * mainArray;
    BOOL isKeyBoardAppeared;
    BOOL isBottomOptionBarAppeared;
    ChatOptionsView * chatOptionView;
    AppDelegate * appDelegate;
    NSDictionary * endoreDictMain;
    NSDictionary * userDictMain;
    float offset_for_keyboard;
}
@end

@implementation DemoChatVCWithParralax

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        isKeyBoardAppeared=NO;
        isBottomOptionBarAppeared=NO;
    }
    return self;
}
-(id)initWithEndorsementCreatedLocally:(NSDictionary *)edoreDict{
    self = [super initWithNibName:@"DemoChatVCWithParralax" bundle:nil];
    if (self) {
        endoreDictMain=[[NSDictionary alloc]initWithDictionary:edoreDict];
        [self loadUserData];
//        [self initParralaxViews];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;

    mainArray=[[NSMutableArray alloc]init];
    ChatMessage * msg1=[[ChatMessage alloc]initWithEndore];
    ChatMessage * msg2=[[ChatMessage alloc]initWithText:@"I'm fine, thanks. Up for dinner tonight?"];


    ChatMessage * msg5=[[ChatMessage alloc]initWithText: @"Oh that sucks. A pitty, well then - have a nice day.."];

    [mainArray addObject:msg1];
    [mainArray addObject:msg2];
    [mainArray addObject:msg5];

    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    chatOptionView=[[ChatOptionsView alloc]init];
    if(!IS_IPHONE_5){
        chatOptionView.frame=CGRectMake(0,480.0, chatOptionView.frame.size.width, chatOptionView.frame.size.height);
    }
    else{
        chatOptionView.frame=CGRectMake(0, self.view.frame.size.height, chatOptionView.frame.size.width, chatOptionView.frame.size.height);
    }
    [self.view addSubview:chatOptionView];
    chatOptionView.delegate=self;
}
-(void)loadUserData{
    NSData * savedObject=GetDataWithKey(kUserCreatedLocally);
    NSDictionary * dictnry=[NSKeyedUnarchiver unarchiveObjectWithData:savedObject];
    userDictMain=[[NSDictionary alloc]initWithDictionary:dictnry];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSNotificationCenter * notifCenter=[NSNotificationCenter defaultCenter];
    [notifCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [notifCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [self scrollTableViewToBottom];
    [appDelegate hideBottomTabBar:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    NSNotificationCenter * notifCenter=[NSNotificationCenter defaultCenter];
    [notifCenter removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [notifCenter removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark:Parralax Effect Methods
-(void)initParralaxViews{
    _mainScrollView = [[UIScrollView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.frame];
    _mainScrollView.delegate = self;
    _mainScrollView.bounces = YES;
    _mainScrollView.alwaysBounceVertical = YES;
    _mainScrollView.contentSize = CGSizeZero;
    _mainScrollView.showsVerticalScrollIndicator = YES;
    _mainScrollView.scrollIndicatorInsets = UIEdgeInsetsMake(kBarHeight, 0, 0, 0);
    self.view = _mainScrollView;
    
    _backgroundScrollView = [[UIScrollView alloc] initWithFrame:HEADER_INIT_FRAME];
    _backgroundScrollView.scrollEnabled = NO;
    _backgroundScrollView.contentSize = CGSizeMake(320, 1000);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:HEADER_INIT_FRAME];
    imageView.image = [UIImage imageNamed:@"background"];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    UIView *fadeView = [[UIView alloc] initWithFrame:imageView.frame];
    fadeView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3f];
    fadeView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_backgroundScrollView addSubview:imageView];
    [_backgroundScrollView addSubview:fadeView];
    
    // Take a snapshot of the background scroll view and apply a blur to that image
    // Then add the blurred image on top of the regular image and slowly fade it in
    // in scrollViewDidScroll
    UIGraphicsBeginImageContextWithOptions(_backgroundScrollView.bounds.size, _backgroundScrollView.opaque, 0.0);
    [_backgroundScrollView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    self.mainVIew.frame=CGRectMake(0, CGRectGetHeight(_backgroundScrollView.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - kBarHeight );
//    [_commentsViewContainer addGradientMaskWithStartPoint:CGPointMake(0.5, 0.0) endPoint:CGPointMake(0.5, 0.03)];
    self.tableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - kBarHeight ) ;
    self.tableView.scrollEnabled = NO;

    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorColor = [UIColor clearColor];
    
    [self.view addSubview:_backgroundScrollView];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat delta = 0.0f;
    CGRect rect = HEADER_INIT_FRAME;
    // Here is where I do the "Zooming" image and the quick fade out the text and toolbar
    if (scrollView.contentOffset.y < 0.0f) {
        delta = fabs(MIN(0.0f, _mainScrollView.contentOffset.y));
        _backgroundScrollView.frame = CGRectMake(CGRectGetMinX(rect) - delta / 2.0f, CGRectGetMinY(rect) - delta, CGRectGetWidth(rect) + delta, CGRectGetHeight(rect) + delta);
        [self.tableView setContentOffset:(CGPoint){0,0} animated:NO];
    } else {
        delta = _mainScrollView.contentOffset.y;
        CGFloat backgroundScrollViewLimit = _backgroundScrollView.frame.size.height - kBarHeight;
        // Here I check whether or not the user has scrolled passed the limit where I want to stick the header, if they have then I move the frame with the scroll view
        // to give it the sticky header look
        if (delta > backgroundScrollViewLimit) {
            _backgroundScrollView.frame = (CGRect) {.origin = {0, delta - _backgroundScrollView.frame.size.height + kBarHeight}, .size = {self.view.frame.size.width, HEADER_HEIGHT}};
            _mainVIew.frame = (CGRect){.origin = {0, CGRectGetMinY(_backgroundScrollView.frame) + CGRectGetHeight(_backgroundScrollView.frame)}, .size = _mainVIew.frame.size };
            self.tableView.contentOffset = CGPointMake (0, delta - backgroundScrollViewLimit);
            CGFloat contentOffsetY = -backgroundScrollViewLimit * kBackgroundParallexFactor;
            [_backgroundScrollView setContentOffset:(CGPoint){0,contentOffsetY} animated:NO];
        }
        else {
            _backgroundScrollView.frame = rect;
            _mainVIew.frame = (CGRect){.origin = {0, CGRectGetMinY(rect) + CGRectGetHeight(rect)}, .size = _mainVIew.frame.size };
            [self.tableView setContentOffset:(CGPoint){0,0} animated:NO];
            [_backgroundScrollView setContentOffset:CGPointMake(0, -delta * kBackgroundParallexFactor)animated:NO];
        }
    }
}

#pragma mark:Custom methods
-(void)scrollTableViewToBottom{
    //Scroll the tableview to bottom
    if (mainArray.count==0) {
        return;
    }
    NSIndexPath* ipath = [NSIndexPath indexPathForRow: mainArray.count-1 inSection: 0];
    [self.tableView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionBottom animated: YES];

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
    
    CGRect rect = self.mainVIew.frame;
    rect.size.height += value;
    
    self.mainVIew.frame = rect;
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
    if (isBottomOptionBarAppeared) {
        [self bottomOptionBarAction:self.bottomOptionButton];
    }
    if(!isKeyBoardAppeared){
        [self setViewMoveUp:YES];
    }
    isKeyBoardAppeared=YES;
    [self scrollTableViewToBottom];
}

-(void)setViewMoveUp:(BOOL)moveUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    CGRect rect = self.mainVIew.frame;
    if (moveUp)
    {
        rect.size.height -= offset_for_keyboard;
    }
    else
    {
        rect.size.height += offset_for_keyboard;
    }
    self.mainVIew.frame = rect;
    [UIView commitAnimations];
}
#pragma mark: Bottom Subview Hide/Show Methods
-(void)setViewMoveUpForBottomOptionView:(BOOL)moveUp
{
    if (isKeyBoardAppeared) {
        [self.msgTV resignFirstResponder];
    }
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    CGRect rect = self.mainVIew.frame;
    CGRect rectOptionView = chatOptionView.frame;
    if (moveUp)
    {
        rect.size.height -= kOFFSET_FOR_BOTTOM_OPTION_BAR;
        rectOptionView.origin.y -=kOFFSET_FOR_BOTTOM_OPTION_BAR;
    }
    else
    {
        rect.size.height += kOFFSET_FOR_BOTTOM_OPTION_BAR;
        rectOptionView.origin.y += kOFFSET_FOR_BOTTOM_OPTION_BAR;
    }
    self.mainVIew.frame = rect;
    chatOptionView.frame=rectOptionView;
    [UIView commitAnimations];
    [self scrollTableViewToBottom];
}
#pragma mark:TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [mainArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatMessage * chatMessage=[mainArray objectAtIndex:indexPath.row];
    if (chatMessage.messageType==Text) {
        CGSize messageSize = [PTSMessagingCell messageSize:chatMessage.msgText];
        return messageSize.height + 2*[PTSMessagingCell textMarginVertical] + 40.0f;
    }
    else if(chatMessage.messageType==Image){
        return 153.0;
    }
    else if(chatMessage.messageType==UEndore){
        return 195.0;
    }
    else{
        return 200.0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*This method sets up the table-view.*/
    ChatMessage * chatMessage=[mainArray objectAtIndex:indexPath.row];
    if (chatMessage.messageType==Text) {
        static NSString* cellIdentifier = @"messagingCell";
    
        PTSMessagingCell * cell = (PTSMessagingCell*) [tableView1 dequeueReusableCellWithIdentifier:cellIdentifier];
    
        if (cell == nil) {
            cell = [[PTSMessagingCell alloc] initMessagingCellWithReuseIdentifier:cellIdentifier];
        }
        cell.selectionStyle=UITableViewCellSeparatorStyleNone;
        [self configureCell:cell atIndexPath:indexPath];
        cell.backgroundColor=[UIColor clearColor];
        return cell;
    }
    else if(chatMessage.messageType==Image){
        PTSImageCell *cell = [tableView1 dequeueReusableCellWithIdentifier:@"PTDRecImageCell"];
        
        if(cell == nil){
            NSArray * array= [[NSBundle mainBundle] loadNibNamed:@"PTSImageRecCell" owner:self options:nil];
            cell=[array objectAtIndex:0];
        }
        cell.bubleImgView.image=[[UIImage imageNamed:@"chat_left"] stretchableImageWithLeftCapWidth:24 topCapHeight:20];
        [UtilsFunctions makeUIImageViewRound:cell.userImgView ANDRadius:20];
        cell.sharedImgView.image=chatMessage.msgImg;
        [UtilsFunctions makeUIImageViewRound:cell.sharedImgView ANDRadius:2];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.timeLbl.text=@"12:01";
        return cell;
    }
    else if(chatMessage.messageType==UEndore){
        UEndoreMsgCell * cell=[tableView1 dequeueReusableCellWithIdentifier:@"uEndoreMsgCell"];
        if (cell==nil) {
            NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"UEndoreMsgCell" owner:self options:nil];
            cell=[array objectAtIndex:0];
        }
        [cell loadDataToViewWithDict:chatMessage.uEndoreDict ANDUserDict:userDictMain];
        cell.msgTimeLbl.text=@"12:01";
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    else{
        EndoreMsgCell * cell=[tableView1 dequeueReusableCellWithIdentifier:@"endoreMessageCell"];
        if (cell==nil) {
            NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"EndoreMsgCell" owner:self options:nil];
            cell=[array objectAtIndex:0];
        }
        NSInteger rating=[[endoreDictMain valueForKey:kTempEndrRating]integerValue];
        [cell setEndoreRatingWith:rating];
        [cell setRatingByUserWith:rating];
        [cell updateUserDataViewWith:userDictMain];
        cell.endrNameLbl.text=[endoreDictMain objectForKey:kTempEndrName];
        cell.userCommentTV.text=[endoreDictMain objectForKey:kTempEndrComment];
        NSArray * arrayImages=[endoreDictMain valueForKey:kTempEndrImageArray];
        if([arrayImages count]>0){
            cell.endrImageView.image=[UtilsFunctions imageWithImage:[arrayImages objectAtIndex:0] scaledToSize:CGSizeMake(300*2, 172*2)];
        }
        else{
            cell.endrImageView.image=nil;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
}


-(void)configureCell:(id)cell atIndexPath:(NSIndexPath *)indexPath {
    PTSMessagingCell* ccell = (PTSMessagingCell*)cell;
    
    if (indexPath.row % 2 == 0) {
        ccell.sent = YES;
        ccell.avatarImageView.image = [UIImage imageNamed:@"parallax_avatar.png"];
    } else {
        ccell.sent = NO;
        ccell.avatarImageView.image = [UIImage imageNamed:@"parallax_avatar.png"];
    }
    
    ccell.messageLabel.text = ((ChatMessage*)[mainArray objectAtIndex:indexPath.row]).msgText;
    ccell.timeLabel.text = @"12:13";
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}
#pragma mark: ImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if([info valueForKey:UIImagePickerControllerOriginalImage]){
        UIImage *chosenImage =info[UIImagePickerControllerOriginalImage];
        [picker dismissViewControllerAnimated:YES completion:nil];
        UIImage * cropedImg=[UtilsFunctions imageWithImage:chosenImage scaledToSize:CGSizeMake(125*2, 112*2)];
        ChatMessage * chatMsg=[[ChatMessage alloc]initWithImage:cropedImg];
        [mainArray addObject:chatMsg];
        [self.tableView reloadData];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark:ChatOptionsViewDelegate
-(void)doActionForCameraBtnPressed{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [imagePickerController.navigationBar setTintColor:[UIColor colorWithRed:73.0/255.0 green:189.0/255.0 blue:143.0/255.0 alpha:1]];
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
    else
    {
        ShowMessage(@"Error", @"Sorry! Camera is not available");
    }
}
-(void)doActionForContactBtnPressed{
    DemoViewController * demoVC=[[DemoViewController alloc]init];
    [self.navigationController pushViewController:demoVC animated:YES];
}
-(void)doActionForEndoreBtnPressed{
    EOverViewVC * eOverViewVC=[[EOverViewVC alloc]init];
    eOverViewVC.isFromChat=YES;
    eOverViewVC.delegate=self;
    [self.navigationController pushViewController:eOverViewVC animated:YES];
}
-(void)doActionForPictureBtnPressed{

        UIImagePickerController * imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [imagePickerController.navigationBar setTintColor:[UIColor colorWithRed:73.0/255.0 green:189.0/255.0 blue:143.0/255.0 alpha:1]];
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
        else
        {
            ShowMessage(@"Error", @"Sorry! Photo Library is not available");
        }
    
}
#pragma mark:EOverViewVCDelegate
-(void)endoreIsSelectForChat:(NSDictionary *)eDict{
    ChatMessage * chatMsg=[[ChatMessage alloc]initWithUendore:eDict];
    [mainArray addObject:chatMsg];
    [self.tableView reloadData];
}
#pragma mark:IBActions
- (IBAction)sendMessageAction:(id)sender {
    if([self.msgTV.text length]==0){
        return;
    }
    ChatMessage * chatMsg=[[ChatMessage alloc]initWithText:self.msgTV.text];
    [mainArray addObject:chatMsg];
    self.msgTV.text=@"";
    [self.tableView reloadData];
    [self scrollTableViewToBottom];
}

- (IBAction)bottomOptionBarAction:(UIButton *)sender {
    sender.selected=!sender.selected;
    if (!isBottomOptionBarAppeared) {
        [self setViewMoveUpForBottomOptionView:YES];
        isBottomOptionBarAppeared=YES;
    }
    else{
        [self setViewMoveUpForBottomOptionView:NO];
        isBottomOptionBarAppeared=NO;
    }
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnSettingsAction:(id)sender {
    ChatSettingsVC * chatSettingVC=[[ChatSettingsVC alloc]init];
    [self.navigationController pushViewController:chatSettingVC animated:YES];
}
#pragma TextField Delegates
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
//    [textField resignFirstResponder];
    [self sendMessageAction:nil];
    return NO;
}
@end
