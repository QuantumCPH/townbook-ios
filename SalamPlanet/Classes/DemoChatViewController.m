//
//  DemoChatViewController.m
//  SalamPlanet
//
//  Created by Globit on 01/10/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "DemoChatViewController.h"
#import "PTSMessagingCell.h"
#import "PTSImageCell.h"
#import "ChatMessage.h"
#import "EndoreMsgCell.h"
#import "AppDelegate.h"
#import "ChatSettingsVC.h"
#import "UEndoreMsgCell.h"
#import "DemoViewController.h"
#import "Constants.h"
#import "UtilsFunctions.h"
#import "ContactsHomeVC.h"
#import "OfferMsgCell.h"
#import "OfferDetailVC.h"
#import "NewShopDetailVC.h"

//#define kOFFSET_FOR_KEYBOARD 216.0
#define kOFFSET_FOR_BOTTOM_OPTION_BAR 70.0
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
@interface DemoChatViewController ()
{
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

@implementation DemoChatViewController

- (id)init
{
    self = [super initWithNibName:@"DemoChatViewController" bundle:nil];
    if (self) {
        // Custom initialization
        isKeyBoardAppeared=NO;
        isBottomOptionBarAppeared=NO;
        [self loadUserData];
    }
    return self;
}
-(id)initWithEndorsementCreatedLocally:(NSDictionary *)edoreDict{
    self = [super initWithNibName:@"DemoChatViewController" bundle:nil];
    if (self) {
        endoreDictMain=[[NSDictionary alloc]initWithDictionary:edoreDict];
        [self loadUserData];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    self.lblPageTitle.font=[appDelegate getFontOfPageTitle];
    mainArray=[[NSMutableArray alloc]init];
    if (endoreDictMain) {
        ChatMessage * msg1=[[ChatMessage alloc]initWithEndore];
        [mainArray addObject:msg1];
    }
    
    ChatMessage * msg2=[[ChatMessage alloc]initWithText:@"I'm fine, thanks. Up for dinner tonight?"];
    
    ChatMessage * msg5=[[ChatMessage alloc]initWithText: @"Oh that sucks. A pitty, well then - have a nice day.."];

    [mainArray addObject:msg2];
    [mainArray addObject:msg5];

    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //for app presentation
//    chatOptionView=[[ChatOptionsView alloc]init];
//    if(!IS_IPHONE_5){
//        chatOptionView.frame=CGRectMake(0,480.0, chatOptionView.frame.size.width, chatOptionView.frame.size.height);
//    }
//    else{
//        chatOptionView.frame=CGRectMake(0, self.view.frame.size.height, chatOptionView.frame.size.width, chatOptionView.frame.size.height);
//    }
//    [self.view addSubview:chatOptionView];
//    chatOptionView.delegate=self;
    
    //Add Timer for Delivery Status Demo
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self
                                   selector:@selector(updateDeliveryStatusOfMessages) userInfo:nil repeats:YES];
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
#pragma mark:Custom methods 
-(void)scrollTableViewToBottom{
    //Scroll the tableview to bottom
    if (mainArray.count==0) {
        return;
    }
    NSIndexPath* ipath = [NSIndexPath indexPathForRow: mainArray.count-1 inSection: 0];
    [self.tableView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionBottom animated: YES];
}
-(CGSize)calculateSizeForText:(NSString *)txt{
    
    CGSize maximumLabelSize = CGSizeMake(320, 40);
    CGSize expectedSectionSize = [txt sizeWithFont:[UIFont boldSystemFontOfSize:12.0]//self.commentView.font
                                 constrainedToSize:maximumLabelSize
                                     lineBreakMode:NSLineBreakByTruncatingTail];
    return expectedSectionSize;
}
-(void)updateDeliveryStatusOfMessages{
    for (ChatMessage * message in mainArray) {
        if (message.deliveryStatus==Sent) {
            message.deliveryStatus=Delivered;
        }
        else if(message.deliveryStatus==Delivered)
        {
            message.deliveryStatus=Seen;
        }
    }
    [self.tableView reloadData];
}
-(NSString *)getTheStatusTextWithValue:(DeliveryStatus)status{
    switch (status) {
        case Sent:
            return NSLocalizedString(@"\"Sent\"", nil);
            break;
        case Delivered:
            return NSLocalizedString(@"\"Delivered\"", nil);
            break;
        case Seen:
            return NSLocalizedString(@"\"Seen\"", nil);
            break;

        default:
            break;
    }
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
        [chatOptionView refreshButtonsView];
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
-(void)makeUIImageViewRoundedLeftSide:(UIImageView*)imgView ANDRadiues:(float)rad ANDTableViewCell:(UITableViewCell *)cell{
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:imgView.bounds
                                     byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerTopLeft)
                                           cornerRadii:CGSizeMake(rad, rad)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = cell.bounds;
    maskLayer.path = maskPath.CGPath;
    imgView.layer.mask = maskLayer;
}
#pragma mark:TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [mainArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatMessage * chatMessage=[mainArray objectAtIndex:indexPath.row];
    if (chatMessage.messageType==Text) {
        CGSize messageSize = [PTSMessagingCell messageSize:chatMessage.msgText];
        return messageSize.height + 2*[PTSMessagingCell textMarginVertical] + 40.0f + 20.0f;
    }
    else if(chatMessage.messageType==Image){
        return 168.0;
    }
    else if(chatMessage.messageType==UOffer || chatMessage.messageType==UShop){
        return 99.0;
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
        cell.timeLabel.text=[UtilsFunctions getFormattedTimeFromDate:[NSDate date]];
        cell.statusLabel.text=[self getTheStatusTextWithValue:chatMessage.deliveryStatus];
        return cell;
    }
    else if(chatMessage.messageType==Image){
        PTSImageCell *cell = [tableView1 dequeueReusableCellWithIdentifier:@"pTSImageSentCell"];
        
        if(cell == nil){
            NSArray * array= [[NSBundle mainBundle] loadNibNamed:@"PTSImageSentCell" owner:self options:nil];
            cell=[array objectAtIndex:0];
        }
        cell.bubleImgView.image=[[UIImage imageNamed:@"chat_right"] stretchableImageWithLeftCapWidth:24 topCapHeight:20];
        [UtilsFunctions makeUIImageViewRound:cell.userImgView ANDRadius:20];
        cell.sharedImgView.image=chatMessage.msgImg;
        [UtilsFunctions makeUIImageViewRound:cell.sharedImgView ANDRadius:2];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.timeLbl.text=[UtilsFunctions getFormattedTimeFromDate:[NSDate date]];
        cell.statusLabel.text=[self getTheStatusTextWithValue:chatMessage.deliveryStatus];
        //        cell.timeLbl.text=@"12:01";
        return cell;
    }
    else if(chatMessage.messageType==UOffer || chatMessage.messageType==UShop){
        OfferMsgCell * cell=[tableView1 dequeueReusableCellWithIdentifier:@"offerMsgCell"];
        if (cell==nil) {
            NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"OfferMsgCell" owner:self options:nil];
            cell=[array objectAtIndex:0];
        }
        if (chatMessage.messageType==UShop) {
            cell.offerNameLb.text=[chatMessage.uOfferShopDict valueForKey:kTempObjShop];
            cell.offerCenterLbl.text=[chatMessage.uOfferShopDict valueForKey:kTempObjPlace];
            cell.offerSenderInfoLbl.text=[NSString stringWithFormat:NSLocalizedString(@"%@ shared a shop", nil),GetStringWithKey(kTempUserName)];
        }
        else{
            cell.offerNameLb.text=[chatMessage.uOfferShopDict valueForKey:kTempObjTitle];
            cell.offerCenterLbl.text=[chatMessage.uOfferShopDict valueForKey:kTempObjShop];
            cell.offerSenderInfoLbl.text=[NSString stringWithFormat:NSLocalizedString(@"%@ shared an offer", nil),GetStringWithKey(kTempUserName)];
        }
        cell.offerTitleLbl.text=[chatMessage.uOfferShopDict valueForKey:kTempObjDetail];
        
        cell.offerImgView.image=[UtilsFunctions imageWithImage:[UIImage imageNamed:[chatMessage.uOfferShopDict valueForKey:kTempObjImgName]] scaledToSize:CGSizeMake(cell.offerImgView.frame.size.width*2,cell.offerImgView.frame.size.height*2)];

        cell.offerMsgTimeLbl.text=[UtilsFunctions getFormattedTimeFromDate:[NSDate date]];
        [self makeUIImageViewRoundedLeftSide:cell.offerImgView ANDRadiues:5.0 ANDTableViewCell:cell];
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
        if([endoreDictMain valueForKey:kTempEndrCategory] && [endoreDictMain valueForKey:kTempEndrSubCategory]){
            cell.catSubCatLbl.text=[NSString stringWithFormat:@"%@,%@",[endoreDictMain valueForKey:kTempEndrCategory],[endoreDictMain valueForKey:kTempEndrSubCategory]];
        }
        if ([endoreDictMain valueForKey:kTempEndrTagString]) {
            cell.tagsLbl.text=[endoreDictMain valueForKey:kTempEndrTagString];
            CGSize size=[self calculateSizeForText:[endoreDictMain valueForKey:kTempEndrTagString]];
            if (size.height>18) {
                cell.tagsLbl.frame=CGRectMake(cell.tagsLbl.frame.origin.x, cell.tagsLbl.frame.origin.y, cell.tagsLbl.frame.size.width, size.height);
            }
        }
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatMessage * chatMessage=[mainArray objectAtIndex:indexPath.row];
    if(chatMessage.messageType==UOffer){
        OfferDetailVC * offerDetailVC=[[OfferDetailVC alloc]initWithOfferCreatedLocally:chatMessage.uOfferShopDict ANDCenterName:[chatMessage.uOfferShopDict valueForKey:kTempObjPlace]];
        [self.navigationController pushViewController:offerDetailVC animated:YES];
    }
    if(chatMessage.messageType==UShop){
        NewShopDetailVC * newShopDetailVC=[[NewShopDetailVC alloc]initWithOfferCreatedLocally:chatMessage.uOfferShopDict ANDCenterName:[chatMessage.uOfferShopDict valueForKey:kTempObjPlace]];
        [self.navigationController pushViewController:newShopDetailVC animated:YES];
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
//    ccell.timeLabel.text = @"12:13";
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
//        UIImage * cropedImg=[UtilsFunctions imageByCroppingImage:chosenImage toSize:CGSizeMake(243*2, 112*2)];
        ChatMessage * chatMsg=[[ChatMessage alloc]initWithImage:chosenImage];
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
        [imagePickerController.navigationBar setTintColor:[UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1]];
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
    else
    {
        ShowMessage(NSLocalizedString(@"Error", nil), NSLocalizedString(@"Sorry! Camera is not available", nil));
    }
}
-(void)doActionForContactBtnPressed{
//    ContactsHomeVC * contactHomeVC=[[ContactsHomeVC alloc]init];
//    [self.navigationController pushViewController:contactHomeVC animated:YES];
}
-(void)doActionForShopBtnPressed{
    ShopsVC * shopsVC=[[ShopsVC alloc]init];
    shopsVC.delegate=self;
    shopsVC.isFromChat=YES;
    [self.navigationController pushViewController:shopsVC animated:YES];
}
-(void)doActionForPictureBtnPressed{

        UIImagePickerController * imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [imagePickerController.navigationBar setTintColor:[UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1]];
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
        else
        {
            ShowMessage(NSLocalizedString(@"Error", nil),NSLocalizedString(@"Sorry! Photo Library is not available", nil));
        }
    
}
-(void)doActionForOffersBtnPressed{
    ActivitiesMainVC * eOverViewVC=[[ActivitiesMainVC alloc]init];
    eOverViewVC.isFromChat=YES;
    eOverViewVC.delegate=self;
    [self.navigationController pushViewController:eOverViewVC animated:YES];
}
-(void)doActionForLocationBtnPressed{
    
}
#pragma mark-ShopsVCDelegate
-(void)shopIsSelectedForChat:(NSDictionary *)sDict{
    ChatMessage * chatMsg=[[ChatMessage alloc]initWithUShop:sDict];
    [mainArray addObject:chatMsg];
    [self.tableView reloadData];
}
#pragma mark:EOverViewVCDelegate
-(void)endoreIsSelectForChat:(NSDictionary *)eDict{
    ChatMessage * chatMsg=[[ChatMessage alloc]initWithOffer:eDict];
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

- (IBAction)locationBtnPressed:(id)sender {
    [self.locBtn setSelected:!self.locBtn.selected];
}

- (IBAction)backAction:(id)sender {
    [self.backBtn setSelected:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnSettingsAction:(id)sender {
    [self.settingBtn setSelected:YES];
    ChatSettingsVC * chatSettingVC=[[ChatSettingsVC alloc]init];
    [self.navigationController pushViewController:chatSettingVC animated:YES];
}
#pragma TextField Delegates
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
//    [textField resignFirstResponder];
    [self sendMessageAction:nil];
    return YES;
}
@end
