//
//  EndorsementViewController.m
//  SalamPlanet
//
//  Created by Globit on 26/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "EndorsementViewController.h"
#import "EndorsementViewCell.h"
#import "EndorsementUser.h"
#import "EndrCommentsViewController.h"
#import "Endorsement.h"
#import "DemoChatViewController.h"
//#import "NewCreatEndrStepOneViewController.h"
#import "AppDelegate.h"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface EndorsementViewController ()
{
    NSMutableArray * mainArray;
    NSMutableArray * mainPicturesArray;
    AppDelegate * appDelegate;
    NSDictionary * endoreDictMain;
    NSDictionary * userDictMain;
}
@end

@implementation EndorsementViewController

- (id)init
{
    self = [super initWithNibName:@"EndorsementViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithEndorsementCreatedLocally:(NSDictionary *)edoreDict{
    self = [super initWithNibName:@"EndorsementViewController" bundle:nil];
    if (self) {
        endoreDictMain=[[NSDictionary alloc]initWithDictionary:edoreDict];
        [self loadUserData];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if([endoreDictMain valueForKey:kTempEndrName]){
        self.titleLbl.text=[endoreDictMain valueForKey:kTempEndrName];
    }
    
    mainArray=[[NSMutableArray alloc]init];
    mainPicturesArray=[[NSMutableArray alloc]init];
    
    [self loadMainArray];
    [self loadMainPicturesArray];
    [self loadPictureInScrollView];
    
    self.tableView.separatorStyle=UITableViewCellSelectionStyleNone;
    
    if(!IS_IPHONE_5){
        self.tableView.frame=CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, 420.0);
    }
    
    appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [appDelegate hideBottomTabBar:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark:Custom Methods
-(void)loadUserData{
    NSData * savedObject=GetDataWithKey(kUserCreatedLocally);
    NSDictionary * dictnry=[NSKeyedUnarchiver unarchiveObjectWithData:savedObject];
    userDictMain=[[NSDictionary alloc]initWithDictionary:dictnry];
}
-(void)loadMainArray{
    [mainArray addObject:endoreDictMain];
}
-(void)loadMainPicturesArray{
    NSArray * array=[endoreDictMain valueForKey:kTempEndrImageArray];
    for (id imges in array) {
        [mainPicturesArray addObject:imges];
    }
}
-(void)loadPictureInScrollView{

    self.mainPictureScrollView.pagingEnabled = YES;
    NSInteger numberOfViews = [mainPicturesArray count];
    for(int i=0; i<numberOfViews; i++){
        UIImageView * imgView=[[UIImageView alloc]initWithImage:[mainPicturesArray objectAtIndex:i]];
        imgView.frame=CGRectMake(i*320, 0, 320, 220);
        imgView.contentMode=UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds=YES;
        [self.mainPictureScrollView addSubview:imgView];
    }
    self.mainPictureScrollView.contentSize=CGSizeMake(320*numberOfViews, 220);
    
    self.mainPicturesPageCntrlr.numberOfPages=[mainPicturesArray count];
}
#pragma mark: UITableView Delegates and Datasource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mainArray count]+1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0){
        return 250;
    }
    return 345;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0){
        self.cellMainDetail.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellMainDetail;
    }
    static NSString *identifier=@"endorseCell";
    
    EndorsementViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        NSArray * nibArray = [[NSBundle mainBundle] loadNibNamed:@"EndorsementViewCell" owner:nil options:nil];
        cell = (EndorsementViewCell*)[nibArray objectAtIndex:0];
    }
    [cell loadDictData:endoreDictMain ANDUserDict:userDictMain];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.delegate=self;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath :(NSIndexPath *)indexPath{
}
#pragma mark: IBActions and Selectors
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma UIScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.mainPicturesPageCntrlr.currentPage = floorf(self.mainPictureScrollView.contentOffset.x/320);
}

#pragma mark:EndorsementViewCell Delegate
-(void)goToSeeComments{
    EndrCommentsViewController * endrCmtVC=[[EndrCommentsViewController alloc]initWithEndrDictMain:endoreDictMain ANDEndrUserMain:userDictMain];
    [self.navigationController pushViewController:endrCmtVC animated:YES];

}
-(void)goToCall{
    
}
-(void)goToChat
{
    DemoChatViewController * chatVC=[[DemoChatViewController alloc]init];
    [self.navigationController pushViewController:chatVC animated:YES];
}
-(void)shareEndore{
    
}
@end
