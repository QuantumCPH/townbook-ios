//
//  DirectioanAndParkingMainVC.m
//  SalamCenterApp
//
//  Created by Globit on 30/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import "DirectioanAndParkingMainVC.h"
#import "AppDelegate.h"
#import "TGAnnotation.h"
#import "ParkinMainVC.h"
//#import "TransportHelpVC.h"

@interface DirectioanAndParkingMainVC ()
{
    CLLocationCoordinate2D currentLocation;
    AppDelegate * appDelegate;
    BOOL isSlided;
}
@end

@implementation DirectioanAndParkingMainVC
-(id)init{
    self = [super initWithNibName:@"DirectioanAndParkingMainVC" bundle:nil];
    if (self) {
        appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self dolocalizationText];
    [self.bgImgV setImage:[UIImage imageNamed:[appDelegate getBackgroundImageName]]];
    self.lblPageTitle.font=[appDelegate getFontOfPageTitle];
    
    currentLocation=[appDelegate getCurrentLocation];
    [self centerizeAndSetTheMap];
    isSlided=NO;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [appDelegate hideBottomTabBar:YES];
    
    [self.goMapDirectionBtn setSelected:NO];
    [self.btnParking setSelected:NO];
    [self.btnBusMap setSelected:NO];
}
-(void)dolocalizationText{
    self.lblPageTitle.text=NSLocalizedString(@"Directions & Parking", nil);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-Custome Methods
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
- (IBAction)btnMenuPressed:(id)sender {
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
//    UIActionSheet * actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Google Maps",@"Apple Maps", nil];
//    [actionSheet showInView:self.view];
    NSURL * url;
    url=[NSURL URLWithString:@"http://maps.apple.com/maps?daddr=Lahore"];//http://maps.apple.com/maps?saddr=%f,%f&daddr=%f,%f
    [[UIApplication sharedApplication] openURL:url];

}

- (IBAction)btnBusMapPressed:(id)sender {
    [self.btnBusMap setSelected:YES];
//    TransportHelpVC * transportHelpVC=[[TransportHelpVC alloc]init];
//    [self.navigationController pushViewController:transportHelpVC animated:YES];
}

- (IBAction)btnParkingPressed:(id)sender{
    [self.btnParking setSelected:YES];
    ParkinMainVC * parkingVC=[ParkinMainVC sharedInstance];//[[ParkingHelpVC alloc]init];
    [self.navigationController pushViewController:parkingVC animated:YES];
}

@end
