//
//  ParkingHelpVC.m
//  SalamCenterApp
//
//  Created by Globit on 27/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import "ParkingHelpVC.h"
#import "AppDelegate.h"

#define kCellOne    @"cellOne"
#define kCellTwo    @"cellTwo"

@interface ParkingHelpVC ()
{
    NSMutableArray * mainArray;
    AppDelegate * appDelegate;
    CLLocationCoordinate2D  parkedLocation;
    UIImage * parkedImage;
    NSString * parkedNote;
}
@end

@implementation ParkingHelpVC
-(id)initWithParkingDescription:(NSString *)desc ANDParkingPicture:(UIImage *)img ANDParkLocation:(CLLocationCoordinate2D)loc{
    self = [super initWithNibName:@"ParkingHelpVC" bundle:nil];
    if (self) {
        parkedImage=[[UIImage alloc]init];
        parkedImage=img;
        parkedNote=[[NSString alloc]initWithString:desc];
        parkedLocation=loc;
        mainArray=[[NSMutableArray alloc]init];
        appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imgVPicture.image=parkedImage;
    if(![parkedNote isEqualToString:@"Add you note here"]){
        self.detailTF.text=parkedNote;
    }
    
    [self.bgImgV setImage:[UIImage imageNamed:[appDelegate getBackgroundImageName]]];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [self loadMainArray];
    [UtilsFunctions makeUIImageViewRound:self.imgVPicture ANDRadius:7.0];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [appDelegate hideBottomTabBar:YES];
    [self.btnBack setSelected:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-Custom Methods
-(void)loadMainArray{
    [mainArray removeAllObjects];
    
    [mainArray addObject:kCellOne];
    [mainArray addObject:kCellTwo];
}
#pragma mark-UITableView DataSource and Delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
        return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mainArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 150.0;
    }
    else{
        return MAX(280.0, self.tableView.frame.size.height-150);
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        self.cellOne.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellOne;
    }
    else{
        self.cellTwo.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellTwo;
    }
}

#pragma mark-IBActions and Selectors
- (IBAction)btnAddPicturePressed:(id)sender {
    if (self.imgVPicture.image) {
        self.popOverImgV.image=self.imgVPicture.image;
        self.viewPopOver.frame=self.tableView.frame;
        [self.view addSubview:self.viewPopOver];
        return;
    }
}

- (IBAction)btnBackPressed:(id)sender {
    [self.btnBack setSelected:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnPopOverPressed:(id)sender {
    [self.viewPopOver removeFromSuperview];
}

- (IBAction)btnGetDirectionsPressed:(id)sender {
    NSURL * url;
    CLLocationCoordinate2D currentLocation=[appDelegate getCurrentLocation];
    url=[NSURL URLWithString:[NSString stringWithFormat:@"http://maps.apple.com/maps?saddr=%f,%f&daddr=%f,%f",currentLocation.latitude,currentLocation.longitude,parkedLocation.latitude,parkedLocation.longitude]];
    [[UIApplication sharedApplication] openURL:url];
}
@end
