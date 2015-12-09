//
//  NewEndorsementHomeViewController.h
//  SalamPlanet
//
//  Created by Saad Khan on 18/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "NewEndorsementHomeViewController.h"
#import "SlideMenuCustomCelll.h"
#import "AppDelegate.h"
#import "AKSegmentedControl.h"
#import "EndorsementViewController.h"
#import "NewCreatEndrStepOneOptionTwoViewController.h"
//#import "NewCreatEndrStepOneViewController.h"
#import "ODRefreshControl.h"


#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface NewEndorsementHomeViewController ()
{
    BOOL isSlided;
    AppDelegate * appDelegate;
    NSMutableArray * mainArray;
    NSMutableArray * mainArrayTrusted;
    NSMutableArray * mainArrayContacts;
    NSMutableArray * mainArrayAll;
    
    AKSegmentedControl *segmentedControl;
    NSDictionary * userDictMain;
    NSMutableArray * menuFavItemsArray;
    ODRefreshControl * refreshControl;
}

@end

@implementation NewEndorsementHomeViewController

- (id)init
{
    self = [super initWithNibName:@"NewEndorsementHomeViewController" bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    //For Collection view
    [self.collectionView registerNib:[UINib nibWithNibName:@"ECollectionCellAll" bundle:nil] forCellWithReuseIdentifier:@"AllEndColCell"];
    
    mainArray=[[NSMutableArray alloc]init];
    menuFavItemsArray=[[NSMutableArray alloc]init];
    mainArrayAll=[[NSMutableArray alloc]init];
    mainArrayContacts=[[NSMutableArray alloc]init];
    mainArrayTrusted=[[NSMutableArray alloc]init];
    


//    [self loadMainArrayWithDummyData];
    
    
    isSlided=NO;
    
    if(!IS_IPHONE_5){
        self.collectionView.frame=CGRectMake(self.collectionView.frame.origin.x, self.collectionView.frame.origin.y, self.collectionView.frame.size.width, 340.0);
    }
    [self addRefreshControlInCollectionView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [appDelegate hideBottomTabBar:NO];
    
    [self loadMenuFavItemArray];
    [self loadMainArrayWithDummyData];
    [self loadUserData];
    [self.collectionView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark: Custom Methods
-(void)addRefreshControlInCollectionView{
     refreshControl = [[ODRefreshControl alloc] initInScrollView:self.collectionView];
//    refreshControl.tintColor = [UIColor grayColor];
    [refreshControl addTarget:self action:@selector(refreshControlAction:) forControlEvents:UIControlEventValueChanged];
//    [self.collectionView addSubview:refreshControl];
    self.collectionView.alwaysBounceVertical = YES;
}
-(void)loadMenuFavItemArray{
    [menuFavItemsArray removeAllObjects];
    [menuFavItemsArray addObject:@"Food"];
    [menuFavItemsArray addObject:@"Hotels"];
    [menuFavItemsArray addObject:@"Books"];
    [menuFavItemsArray addObject:@"Parks"];
    [menuFavItemsArray addObject:@"Coffee"];
    [menuFavItemsArray addObject:@"Shopping"];
    MenuItemViewBar * menuItemViewBar=[[MenuItemViewBar alloc]initWIthArray:menuFavItemsArray];
    menuItemViewBar.frame=CGRectMake(0, 67+30, 320, 50);
    [self.view addSubview:menuItemViewBar];
}
-(void)loadUserData{
    NSData * savedObject=GetDataWithKey(kUserCreatedLocally);
    NSDictionary * dictnry=[NSKeyedUnarchiver unarchiveObjectWithData:savedObject];
    userDictMain=[[NSDictionary alloc]initWithDictionary:dictnry];
}
-(void)loadMainArrayWithDummyData{
    [mainArray removeAllObjects];

    NSArray * savedObjects=GetArrayWithKey(kArrayEndorsementCreatedLocally);
    for (NSData * item in savedObjects) {
        NSDictionary * dictnry=[NSKeyedUnarchiver unarchiveObjectWithData:item];
        [mainArray addObject:dictnry];
    }
    [self sortMainArrayForAudience];
}
-(void)addCustomSegmentBar{
    // Segmented Control
    segmentedControl = [[AKSegmentedControl alloc] initWithFrame:CGRectMake(10.0,10.0, 300.0, 37.0)];
    [segmentedControl addTarget:self action:@selector(segmentBarAction:) forControlEvents:UIControlEventValueChanged];
    // Setting the resizable background image
    UIImage *backgroundImage = [[UIImage imageNamed:@"segment-bg.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)];
    [segmentedControl setBackgroundImage:backgroundImage];
    
    [segmentedControl setSegmentedControlMode:AKSegmentedControlModeSticky];
    [segmentedControl setSelectedIndex:1];
}
-(void)sortMainArrayForAudience{
    NSSortDescriptor *idSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:kTempEndrID ascending:NO];
    NSArray  * sortedArray=[mainArray sortedArrayUsingDescriptors:@[idSortDescriptor]];
    [mainArray removeAllObjects];
    for (id obj in sortedArray) {
        [mainArray addObject:obj];
    }
    
    [mainArrayTrusted removeAllObjects];
    [mainArrayAll removeAllObjects];
    [mainArrayContacts removeAllObjects];
    for (NSDictionary * dict in mainArray) {
        if ([[dict valueForKey:kTempEndrAudience]isEqualToString:@"All"]) {
            [mainArrayAll addObject:dict];
        }
        else if([[dict valueForKey:kTempEndrAudience]isEqualToString:@"Contacts"]) {
            [mainArrayContacts addObject:dict];
        }
        else{
            [mainArrayTrusted addObject:dict];
        }
    }
}
#pragma mark: UICollectionView Delegates and Datasource Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(self.segmentControl.selectedSegmentIndex==0){
        return mainArrayTrusted.count;
    }
    else if(self.segmentControl.selectedSegmentIndex==1){
        return mainArrayContacts.count;
    }
    else{
        return mainArrayAll.count;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(310, 160);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);//(top, left, bottom, right);
}
- (ECollectionCellAll *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ECollectionCellAll *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AllEndColCell" forIndexPath:indexPath];
    if(!cell){
            NSArray * nibArray = [[NSBundle mainBundle] loadNibNamed:@"ECollectionCellAll" owner:nil options:nil];
            cell = (ECollectionCellAll*)[nibArray objectAtIndex:0];
    }
    NSDictionary * dict;
    if(self.segmentControl.selectedSegmentIndex==0){
        dict=[mainArrayTrusted objectAtIndex:indexPath.row];
    }
    else if(self.segmentControl.selectedSegmentIndex==1){
        dict=[mainArrayContacts objectAtIndex:indexPath.row];
    }
    else{
        dict=[mainArrayAll objectAtIndex:indexPath.row];
    }

    cell.endrNameLbl.text=[dict objectForKey:kTempEndrName];
    NSArray * arrayImages=[dict valueForKey:kTempEndrImageArray];
    if([arrayImages count]>0){
        cell.endrImageView.image=[arrayImages objectAtIndex:0];
    }
    else{
        cell.endrImageView.image=nil;
    }
    //Favourite Button
    if ([[dict valueForKey:kTempEndrIsFav]isEqualToString:@"NO"]) {
        [cell makeStarPressed:NO];
    }
    else{
        [cell makeStarPressed:YES];
    }
    //Bookmark Button
    if ([[dict valueForKey:kTempEndrIsBookmarked]isEqualToString:@"NO"]) {
        [cell makeBookmarkedPressed:NO];
    }
    else{
        [cell makeBookmarkedPressed:YES];
    }
    cell.endrUserNameLbl.text=[userDictMain objectForKey:kTempUserName];

    cell.commentCountLbl.text=@"1";
    cell.tag=[[dict valueForKey:kTempEndrID]integerValue];
    NSInteger rating=[[dict valueForKey:kTempEndrRating]integerValue];
    switch (rating) {
        case 0:
            [cell.moonImgOne setImage:[UIImage imageNamed:@"moon-empty.png"]];
            [cell.moonImgTwo setImage:[UIImage imageNamed:@"moon-empty.png"]];
            [cell.moonImgThree setImage:[UIImage imageNamed:@"moon-empty.png"]];
            [cell.moonImgFour setImage:[UIImage imageNamed:@"moon-empty.png"]];
            [cell.moonImgFive setImage:[UIImage imageNamed:@"moon-empty.png"]];
            break;
        case 1:
            [cell.moonImgOne setImage:[UIImage imageNamed:@"moon-filled.png"]];
            [cell.moonImgTwo setImage:[UIImage imageNamed:@"moon-empty.png"]];
            [cell.moonImgThree setImage:[UIImage imageNamed:@"moon-empty.png"]];
            [cell.moonImgFour setImage:[UIImage imageNamed:@"moon-empty.png"]];
            [cell.moonImgFive setImage:[UIImage imageNamed:@"moon-empty.png"]];
            break;
        case 2:
            [cell.moonImgOne setImage:[UIImage imageNamed:@"moon-filled.png"]];
            [cell.moonImgTwo setImage:[UIImage imageNamed:@"moon-filled.png"]];
            [cell.moonImgThree setImage:[UIImage imageNamed:@"moon-empty.png"]];
            [cell.moonImgFour setImage:[UIImage imageNamed:@"moon-empty.png"]];
            [cell.moonImgFive setImage:[UIImage imageNamed:@"moon-empty.png"]];
            break;
        case 3:
            [cell.moonImgOne setImage:[UIImage imageNamed:@"moon-filled.png"]];
            [cell.moonImgTwo setImage:[UIImage imageNamed:@"moon-filled.png"]];
            [cell.moonImgThree setImage:[UIImage imageNamed:@"moon-filled.png"]];
            [cell.moonImgFour setImage:[UIImage imageNamed:@"moon-empty.png"]];
            [cell.moonImgFive setImage:[UIImage imageNamed:@"moon-empty.png"]];
            break;
        case 4:
            [cell.moonImgOne setImage:[UIImage imageNamed:@"moon-filled.png"]];
            [cell.moonImgTwo setImage:[UIImage imageNamed:@"moon-filled.png"]];
            [cell.moonImgThree setImage:[UIImage imageNamed:@"moon-filled.png"]];
            [cell.moonImgFour setImage:[UIImage imageNamed:@"moon-filled.png"]];
            [cell.moonImgFive setImage:[UIImage imageNamed:@"moon-empty.png"]];
            break;
        case 5:
            [cell.moonImgOne setImage:[UIImage imageNamed:@"moon-filled.png"]];
            [cell.moonImgTwo setImage:[UIImage imageNamed:@"moon-filled.png"]];
            [cell.moonImgThree setImage:[UIImage imageNamed:@"moon-filled.png"]];
            [cell.moonImgFour setImage:[UIImage imageNamed:@"moon-filled.png"]];
            [cell.moonImgFive setImage:[UIImage imageNamed:@"moon-filled.png"]];
            break;
        default:
            break;
    }
    cell.delegate=self;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * dict;
    if(self.segmentControl.selectedSegmentIndex==0){
        dict=[mainArrayTrusted objectAtIndex:indexPath.row];
    }
    else if(self.segmentControl.selectedSegmentIndex==1){
        dict=[mainArrayContacts objectAtIndex:indexPath.row];
    }
    else{
        dict=[mainArrayAll objectAtIndex:indexPath.row];
    }
    EndorsementViewController *endoreVC=[[EndorsementViewController alloc]initWithEndorsementCreatedLocally:dict];
    [self.navigationController pushViewController:endoreVC animated:YES];
    NSLog(@"%li",(long)indexPath.row);
}
#pragma mark:EndorsementCollectionCellDelegate
-(void)eCollAllfavouriteButtonPressedWithOption:(BOOL)isFav ANDTag:(NSInteger)tag{
    if(isFav){
        for (NSDictionary * dict in mainArray) {
            if ([[dict valueForKey:kTempEndrID]integerValue]==tag) {
                [dict setValue:@"YES" forKey:kTempEndrIsFav];
                break;
            }
        }
        [UtilsFunctions saveAllEndorsementArrayInUserDefaults:mainArray];
        [self loadMainArrayWithDummyData];
        ShowMessage(kAppName, @"This endorsement have been saved");
    }
    else{
        for (NSDictionary * dict in mainArray) {
            if ([[dict valueForKey:kTempEndrID]integerValue]==tag) {
                [dict setValue:@"NO" forKey:kTempEndrIsFav];
                break;
            }
        }
        [UtilsFunctions saveAllEndorsementArrayInUserDefaults:mainArray];
        [self loadMainArrayWithDummyData];
        ShowMessage(kAppName, @"This endorsement have been removed");
    }
}

#pragma mark: IBAction and Selector Methods
-(void)refreshControlAction:(id)sender{
    [self performSelector:@selector(endRefreshControl) withObject:nil afterDelay:2];
}
-(void)endRefreshControl{
    [refreshControl endRefreshing];
}
-(void)showSlideMenu:(id)sender{
    if(isSlided){
        [appDelegate showHideSlideMenue:NO];
        isSlided=NO;
    }
    else{
        [appDelegate showHideSlideMenue:YES];
        isSlided=YES;
    }
}

- (IBAction)segmentChangeAction:(id)sender {
    UISegmentedControl * segment=(UISegmentedControl *)sender;
    appDelegate.audianceType=segment.selectedSegmentIndex;
    [self.collectionView reloadData];
}

- (IBAction)showSliderAction:(id)sender {
    [self showSlideMenu:sender];
}

- (IBAction)createEndorsementAction:(id)sender {
    NewCreatEndrStepOneOptionTwoViewController * createEndrVC=[[NewCreatEndrStepOneOptionTwoViewController alloc]init];
    [appDelegate hideBottomTabBar:YES];
    [self.navigationController pushViewController:createEndrVC animated:YES];
}
-(void)segmentBarAction:(id)sender{
    
}
@end
