//
//  OpeningHoursMainVC.m
//  SalamCenterApp
//
//  Created by Globit on 12/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import "OpeningHoursMainVC.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "Place.h"
#import "TGAnnotation.h"
#import "ParkingHelpVC.h"
#import "EmptyVC.h"
#import "Constants.h"
#import "TimingCell.h"
#import "EntityTiming.h"
#import "Timing.h"
#import "WebManager.h"
#import "DataManager.h"
#import "MallCenter.h"

@interface OpeningHoursMainVC ()
{
    AppDelegate * appDelegate;
    BOOL isSlided;
    NSMutableArray * mainArrayOfVC;
    NSMutableArray * mainItemsForTimingsArray;
    NSMutableArray * timings;
    CLLocationCoordinate2D currentLocation;
}
@end

@implementation OpeningHoursMainVC
-(id)init{
    self = [super initWithNibName:@"OpeningHoursMainVC" bundle:nil];
    if (self) {
        appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
        mainItemsForTimingsArray=[[NSMutableArray alloc]init];
        mainArrayOfVC=[[NSMutableArray alloc]init];
        timings = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self dolocalizationText];
    [self.bgImgV setImage:[UIImage imageNamed:[appDelegate getBackgroundImageName]]];
    self.lblPageTitle.font=[appDelegate getFontOfPageTitle];
    
    [appDelegate getCurrentSelectedCenter];
    isSlided=NO;
    //[self loadmainItemsForTimingsArray];
    //self.pagerView.hidden = YES;
    [mainItemsForTimingsArray addObject:[[DataManager sharedInstance] currentMall]];
    [self loadMainArrayOfCollectionView];
    [self.pagerView reloadData];
    [self loadEntityTimings];
    currentLocation=[appDelegate getCurrentLocation];
    [self centerizeAndSetTheMap];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [appDelegate hideBottomTabBar:YES];
    [self.pagerView changeIndexToTheIndex:0];
    
    [self.goMapDirectionBtn setSelected:NO];
    [self.btnParking setSelected:NO];
    [self.btnBusMap setSelected:NO];
}
-(void)dolocalizationText{
        self.lblPageTitle.text=NSLocalizedString(@"Opening Hours & Information", nil);//
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-Custom Methods
//NSComparator kMostRecentComparator = ^NSComparisonResult(id obj1, id obj2){
//    Timing * timing1 = (Timing*)obj1;
//    Timing * timing2 = (Timing*)obj2;
//    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"EEEE"];
//    NSDate *date1 = [dateFormatter dateFromString:timing1.fromDay];
//    NSDate *date2 = [dateFormatter dateFromString:timing2.fromDay];
//    return [date1 compare:date2];
//    
//};
- (int)weekdayNumberFromWeekDay:(NSString*)weekDayString
{
    if ([weekDayString isEqualToString:@"Monday"])
        return 1;
    else if ([weekDayString isEqualToString:@"Tuesday"])
        return 2;
    else if ([weekDayString isEqualToString:@"Wednesday"])
        return 3;
    else if ([weekDayString isEqualToString:@"Thursday"])
        return 4;
    else if ([weekDayString isEqualToString:@"Friday"])
        return 5;
    else if ([weekDayString isEqualToString:@"Saturday"])
        return 6;
    else
        return 7;
}
- (void)loadEntityTimings
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WebManager sharedInstance] getMallTimingList:^(NSArray *resultArray, NSString *message) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (message){
            ShowMessage(kAppName,message);
        }
        else if(resultArray.count == 0)
        {
            ShowMessage(kAppName, NSLocalizedString(@"No timings available for this Mall",nil));
        }
        else
        {
            mainItemsForTimingsArray = [[NSMutableArray alloc] initWithArray:resultArray];
            NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"entityType" ascending:YES];
            [mainItemsForTimingsArray sortUsingDescriptors:@[sortDescriptor]];
            [self loadMainArrayOfCollectionView];
            [self configureTimingsArrayForEntityTiming:mainItemsForTimingsArray.firstObject];
            [self.pagerView reloadData];
            //[self.tableView reloadData];
        }
    } failure:^(NSString *errorString) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ShowMessage(kAppName,errorString);
    }];
}
-(void)loadMainArrayOfCollectionView{
    [mainArrayOfVC removeAllObjects];
    
    for (int i=0;i<mainItemsForTimingsArray.count;i++) {
        EmptyVC * emptyVC=[[EmptyVC alloc]init];
        [mainArrayOfVC addObject:emptyVC];
    }
}
- (void)configureTimingsArrayForEntityTiming:(EntityTiming*)entityTiming
{
    timings = [[NSMutableArray alloc] initWithArray:[entityTiming.timings allObjects]];
//    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"fromDay" ascending:YES];
//    [timings sortUsingDescriptors:@[sortDescriptor]];
    [timings sortUsingComparator:^NSComparisonResult(id obj1, id obj2){
        Timing * timing1 = (Timing*)obj1;
        Timing * timing2 = (Timing*)obj2;
        int day1 = [self weekdayNumberFromWeekDay:timing1.fromDay];
        int day2 = [self weekdayNumberFromWeekDay:timing2.fromDay];
        return day1>day2;
    }];
    [self.tableView reloadData];
}

-(void)centerizeAndSetTheMap{
//        _map = [[MKMapView alloc] init];//CGRectMake(0, 0, 101, 160.0)
        _mapView.userInteractionEnabled = YES;
//        _mapView.delegate = self;
        MKCoordinateRegion myRegion;
        
        myRegion.center.latitude = currentLocation.latitude;
        myRegion.center.longitude = currentLocation.longitude;
        
        // this sets the zoom level, a smaller value like 0.02
        // zooms in, a larger value like 80.0 zooms out
        myRegion.span.latitudeDelta = 0.04;
        myRegion.span.longitudeDelta = 0.2;
        
        // move the map to our location
        [_mapView setRegion:myRegion animated:NO];
        
        //annotation
        TGAnnotation *annot = [[TGAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(currentLocation.latitude, currentLocation.longitude)];
        [_mapView addAnnotation:annot];
}

#pragma mark: UITableView Delegates and Datasource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return timings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TimingCell * cell=[tableView dequeueReusableCellWithIdentifier:@"TimingCell"];
    if (!cell) {
        NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"TimingCell" owner:self options:nil];
        cell=[array objectAtIndex:0];
    }
    Timing *timing = timings[indexPath.row];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString * timingText;
    if ([timing.fromDay isEqualToString: timing.toDay])
        timingText = [NSString stringWithFormat:@"%@: %@-%@",timing.fromDay,[dateFormatter stringFromDate:timing.openingTime],[dateFormatter stringFromDate:timing.closingTime]];
    else
        timingText = [NSString stringWithFormat:@"%@-%@: %@-%@",timing.fromDay,timing.toDay,[dateFormatter stringFromDate:timing.openingTime],[dateFormatter stringFromDate:timing.closingTime]];
    cell.timingLbl.text = timingText;
    return cell;
}

#pragma mark - SHViewPagerDataSource stack

- (NSInteger)numberOfPagesInViewPager:(SHViewPager *)viewPager
{
    return mainItemsForTimingsArray.count;
}

- (UIViewController *)containerControllerForViewPager:(SHViewPager *)viewPager
{
    return self;
}

- (UIViewController *)viewPager:(SHViewPager *)viewPager controllerForPageAtIndex:(NSInteger)index
{
    if (mainArrayOfVC.count>0)
        return [mainArrayOfVC objectAtIndex:index];
    else
        return [[EmptyVC alloc] init];
}

- (UIImage *)indexIndicatorImageForViewPager:(SHViewPager *)viewPager
{
    return [UIImage imageNamed:@"horizontal_line"];
}

- (UIImage *)indexIndicatorImageDuringScrollAnimationForViewPager:(SHViewPager *)viewPager
{
    return [UIImage imageNamed:@"horizontal_line_moving"];
}

- (NSString *)viewPager:(SHViewPager *)viewPager titleForPageMenuAtIndex:(NSInteger)index
{
    return [[mainItemsForTimingsArray objectAtIndex:index] name];
}

- (SHViewPagerMenuWidthType)menuWidthTypeInViewPager:(SHViewPager *)viewPager
{
    return SHViewPagerMenuWidthTypeDefault;
}
- (UIColor *)colorForMenuInViewPager:(SHViewPager *)viewPager{
    //    return [UIColor colorWithRed:166.0/255.0 green:168.0/255.0 blue:171.0/255.0 alpha:1.0];
    return [UIColor colorWithRed:206.0/255.0 green:206.0/255.0 blue:206.0/255.0 alpha:1.0];
}
#pragma mark - SHViewPagerDelegate stack

- (void)firstContentPageLoadedForViewPager:(SHViewPager *)viewPager
{
    NSLog(@"first viewcontroller content loaded");
}

- (void)viewPager:(SHViewPager *)viewPager :(NSInteger)toIndex fromIndex:(NSInteger)fromIndex
{
    NSLog(@"content will move to page %ld from page: %ld", (long)toIndex, (long)fromIndex);
}

- (void)viewPager:(SHViewPager *)viewPager didMoveToPageAtIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex
{
    NSLog(@"content moved to page%ld from page: %ld", (long) toIndex, (long)fromIndex);
    id entityObj = mainItemsForTimingsArray[toIndex];
    if (![entityObj isMemberOfClass:[MallCenter class]] )
    {
        [self configureTimingsArrayForEntityTiming:(EntityTiming*)entityObj];
//        timings = [[NSMutableArray alloc] initWithArray:[[(EntityTiming*)entityObj timings] allObjects]];
//        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"fromDay" ascending:YES];
//        [timings sortUsingDescriptors:@[sortDescriptor]];
//        [self.tableView reloadData];
    }
//    if (toIndex%2==0) {
//        self.timeLblOne.text=@"monday - friday: 10am - 10pm";
//        self.timeLblTwo.text=@"saturday - sunday: 10am - 6pm";
//    }
//    else{
//        self.timeLblOne.text=@"monday - thursday: 8am - 8pm";
//        self.timeLblTwo.text=@"friday - sunday: 9am - 6pm";
//    }
}
-(void)rightSwipedWhenIndexisZero{
    //do nothing
}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    NSURL * url;
    if (buttonIndex==0) {
        url = [NSURL URLWithString:@"https://www.google.com/maps/dir//Lahore"];//:@"http://maps.google.com/?q=Lahore"];
        [[UIApplication sharedApplication] openURL:url];
    }
    else if (buttonIndex==1) {
        url=[NSURL URLWithString:@"http://maps.apple.com/maps?daddr=Lahore"];//http://maps.apple.com/maps?saddr=%f,%f&daddr=%f,%f
        [[UIApplication sharedApplication] openURL:url];
    }
    else{
        [self.goMapDirectionBtn setSelected:NO];
    }
}
#pragma mark - MKMap View methods

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    if (annotation == mapView.userLocation)
        return nil;
    
    static NSString *MyPinAnnotationIdentifier = @"Pin";
    MKPinAnnotationView *pinView =
    (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:MyPinAnnotationIdentifier];
    if (!pinView){
        MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                                        reuseIdentifier:MyPinAnnotationIdentifier];
        
        annotationView.image = [UIImage imageNamed:@"location-icon"];
        
        return annotationView;
        
    }else{
        
        pinView.image = [UIImage imageNamed:@"location-icon"];//pin_map_blue
        
        return pinView;
    }
    
    return nil;
}

#pragma mark-IBActions and Selectors
- (IBAction)backBtnPressed:(id)sender {
    if(isSlided){
        [appDelegate showHideSlideMenue:YES withCenterName:nil];
        isSlided=NO;
    }
    else{
        [appDelegate showHideSlideMenue:YES withCenterName:nil];
        isSlided=YES;
    }
}

- (IBAction)goMapDirectionBtnPressed:(id)sender {
    [self.goMapDirectionBtn setSelected:YES];
    UIActionSheet * actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Google Maps",@"Apple Maps", nil];
    [actionSheet showInView:self.view];
}

- (IBAction)btnBusMapPressed:(id)sender {
    [self.btnBusMap setSelected:YES];
//    TransportHelpVC * transportHelpVC=[[TransportHelpVC alloc]init];
//    [self.navigationController pushViewController:transportHelpVC animated:YES];
}

- (IBAction)btnParkingPressed:(id)sender{
    [self.btnParking setSelected:YES];
//    ParkingHelpVC * parkingHelpVC=[ParkingHelpVC sharedInstance];//[[ParkingHelpVC alloc]init];
//    [self.navigationController pushViewController:parkingHelpVC animated:YES];
}
@end
