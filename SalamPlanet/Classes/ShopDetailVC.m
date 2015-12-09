//
//  ShopDetailVC.m
//  SalamCenterApp
//
//  Created by Globit on 01/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "ShopDetailVC.h"
#import "AppDelegate.h"

#define kCellTop    @"cellTop"
#define kCellMiddle @"cellMiddle"
#define kCellBottom @"cellBottom"
#define kShopDetailText @"The company later opened its most well-known department store in the building. It closed in 1971. It was then relaunched as City Arkaden (The City Arcade). In 2004, a joint-venture between Danish property developer Keops and American AIG purchased the building After a major refurbishment, it reope4ned in 2006 under the current name."
@interface ShopDetailVC ()
{
    NSMutableArray* mainArray;
    AppDelegate * appDelegate;
}
@end

@implementation ShopDetailVC
-(id)init{
    self = [super initWithNibName:@"ShopDetailVC" bundle:nil];
    if (self) {
        mainArray=[[NSMutableArray alloc]init];
        appDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadMainArray];
    [self.bgImgV setImage:[UIImage imageNamed:[appDelegate getBackgroundImageName]]];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Methods
-(void)initializeMapToShowInDetailCell{
    if (!_map) {
        _map = [[MKMapView alloc] init];//CGRectMake(0, 0, 101, 160.0)
        _map.userInteractionEnabled = FALSE;
        _map.delegate = self;
        MKCoordinateRegion myRegion;
        
        myRegion.center.latitude = 56.0;
        myRegion.center.longitude = 10.0;
        
        // this sets the zoom level, a smaller value like 0.02
        // zooms in, a larger value like 80.0 zooms out
        myRegion.span.latitudeDelta = 0.2;
        myRegion.span.longitudeDelta = 0.2;
        
        // move the map to our location
        [_map setRegion:myRegion animated:NO];
        
        //annotation
        TGAnnotation *annot = [[TGAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(56.0, 10.0)];
        [_map addAnnotation:annot];
    }
}

-(CGSize)calculateSizeForText:(NSString *)txt{
    
    CGSize maximumLabelSize = CGSizeMake(300, 600);
    CGSize expectedSectionSize = [txt sizeWithFont:self.shopDetailTV.font//self.commentView.font
                                 constrainedToSize:maximumLabelSize
                                     lineBreakMode:NSLineBreakByTruncatingTail];
    return expectedSectionSize;
}
-(void)loadMainArray{
    [mainArray removeAllObjects];
    
    [mainArray addObject:kCellTop];
    [mainArray addObject:kCellMiddle];
    [mainArray addObject:kCellBottom];
}
#pragma mark - UITableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellTop]) {
        return 250.0;
    }
    else if([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellMiddle])
    {
        CGSize size=[self calculateSizeForText:kShopDetailText];
        CGRect frame=self.shopDetailTV.frame;
        frame.size.height=size.height+10;
        self.shopDetailTV.frame=frame;
        return size.height+40;
    }
    else
    {
        return 160.0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mainArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellTop]) {
        self.cellTopContainer.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellTopContainer;
    }

    else if([[mainArray objectAtIndex:indexPath.row]isEqualToString:kCellMiddle])
    {
        self.shopDetailTV.text=kShopDetailText;
        self.cellCenterContainer.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellCenterContainer;
    }
    else
    {
        AddressLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addressLocationDetail"];
        
        if(cell == nil){
            cell = [AddressLocationCell addressLocationDetailCell];
            CGRect frame=cell.mapContainerView.frame;
            frame.origin.x=0;
            frame.origin.y=0;
            [self initializeMapToShowInDetailCell];
            _map.frame=frame;
            
            UITapGestureRecognizer * tapGestureForMap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mapHasBeenTapped:)];
            tapGestureForMap.delegate=self;

            [cell.mapContainerView addSubview:_map];
            [cell.mapContainerView addGestureRecognizer:tapGestureForMap];
            cell.delegate=self;
            [cell setFontsOfItemsInView];
        }
        [cell.addressTV setTextColor:[UIColor whiteColor]];
        [cell.phoneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cell.priceLbl setTextColor:[UIColor whiteColor]];
        [cell.directionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cell.websiteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cell.backgroundColor=[UIColor clearColor];
        cell.contentView.backgroundColor=[UIColor clearColor];
        return cell;
    }
}

#pragma mark:AddressLocationCellDelegate
-(void)phoneNumberPressedForCallOnNumber:(NSString *)number{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ABC Shop" message:[NSString stringWithFormat:@"Call %@",number]
                                                   delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Call",nil];
    
    [alert show];
}
-(void)addressPressedToShowMap{
    [self mapHasBeenTapped:nil];
}
-(void)goToWebsitePressedToOpenWebsite{
    WebVC * webVC=[[WebVC alloc]initWithUrl:@"https://www.google.com"];
    [self.navigationController pushViewController:webVC animated:YES];
}
#pragma mark - MKMap View methods

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    if (annotation == mapView.userLocation)
        return nil;
    
    static NSString *MyPinAnnotationIdentifier = @"Pin";
    MKPinAnnotationView *pinView =
    (MKPinAnnotationView *) [self.map dequeueReusableAnnotationViewWithIdentifier:MyPinAnnotationIdentifier];
    if (!pinView){
        MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                                        reuseIdentifier:MyPinAnnotationIdentifier];
        
        annotationView.image = [UIImage imageNamed:@"pin_map_blue"];
        
        return annotationView;
        
    }else{
        
        pinView.image = [UIImage imageNamed:@"pin_map_blue"];
        
        return pinView;
    }
    
    return nil;
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (buttonIndex==0) {
        ShowMapVC * showMapVC=[[ShowMapVC alloc]initWithCoordinatesLong:56.0 ANDLat:10.0 ANDLocationName:@"ABC City"];
        [self.navigationController pushViewController:showMapVC animated:YES];
    }
    else if (buttonIndex==1) {
//        ShowGoogleMapVC * showMapVC=[[ShowGoogleMapVC alloc]initWithCoordinatesLong:56.0 ANDLat:10.0 ANDLocationName:@"ABC City"];
//        [self.navigationController pushViewController:showMapVC animated:YES];
    }
}
#pragma mark - IBActions and Selector Methods
-(void)mapHasBeenTapped:(id)sender{
    UIActionSheet * actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Apple Maps",@"Google Maps", nil];
    [actionSheet showInView:self.view];
}
- (IBAction)goBackAction:(id)sender {
    [self.backBtn setSelected:YES];    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
