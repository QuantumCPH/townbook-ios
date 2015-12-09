//
//  EntityMapAddressVC.m
//  SalamCenterApp
//
//  Created by Waseem Asif on 21/10/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import "EntityMapAddressVC.h"
#import "AppDelegate.h"
#import "Shop.h"
#import "Restaurant.h"
#import "MAService.h"
#import "MallCenter.h"
#import "DataManager.h"

@interface EntityMapAddressVC ()
{
    CLLocationCoordinate2D entityLocation;
    AppDelegate * appDelegate;

}
@end

@implementation EntityMapAddressVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureMap];
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.bgImgV setImage:[UIImage imageNamed:[appDelegate getBackgroundImageName]]];
    
    if (_isForRestaurent)
    {
        self.lblPageTitle.text = _restaurant.name;
        self.addressTextView.text = _restaurant.address;
    }
    else if (_isForService)
    {
        self.lblPageTitle.text = _service.name;
        self.addressTextView.text = _service.address;
    }
    else
    {
        self.lblPageTitle.text = _shop.name;
        self.addressTextView.text = _shop.address;
    }
}

#pragma mark-Custome Methods
-(void)configureMap
{
    _mapView.userInteractionEnabled = YES;
    _mapView.showsUserLocation = YES;
    MKCoordinateRegion entityRegion;
    if (_isForRestaurent)
    {
        entityRegion.center.latitude = _restaurant.latitude;
        entityRegion.center.longitude = _restaurant.longitude;
       
    }
    else if (_isForService)
    {
        MallCenter *mallCenter = [[DataManager sharedInstance] currentMall];
        entityRegion.center.latitude = mallCenter.latitude;
        entityRegion.center.longitude = mallCenter.longitude;
    }
    else
    {
        entityRegion.center.latitude = _shop.latitude;
        entityRegion.center.longitude = _shop.longitude;
    }
    
    entityRegion.span.latitudeDelta = 0.04;
    entityRegion.span.longitudeDelta = 0.04;
    
    // move the map to our location
    [_mapView setRegion:entityRegion animated:NO];
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
//    if (annotation == mapView.userLocation)
//        return nil;
    
    static NSString *MyPinAnnotationIdentifier = @"Pin";
    MKPinAnnotationView *pinView =
    (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:MyPinAnnotationIdentifier];
    if (!pinView){
        MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                                        reuseIdentifier:MyPinAnnotationIdentifier];
        
        annotationView.image = [UIImage imageNamed:@"mapPin.png"];
        
        return annotationView;
        
    }else{
        
        pinView.image = [UIImage imageNamed:@"mapPin.png"];//pin_map_blue
        
        return pinView;
    }
    
    return nil;
}

- (IBAction)backTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
