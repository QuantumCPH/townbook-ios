//
//  ShowMapVC.m
//  SalamPlanet
//
//  Created by Globit on 30/10/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "ShowMapVC.h"

@interface ShowMapVC (){
    CGFloat currentLat;
    CGFloat currentLong;
    NSString * locationName;
}

@end


@implementation ShowMapVC

-(id)initWithCoordinatesLong:(CGFloat)lng ANDLat:(CGFloat)lat ANDLocationName:(NSString *)locName{
    self = [super initWithNibName:@"ShowMapVC" bundle:nil];
    if (self) {
        currentLat=37.78275123;
        currentLong=-122.40416442;
        locationName=[[NSString alloc]initWithString:locName];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    //Set Center View of Map
    self.mapView.centerCoordinate=CLLocationCoordinate2DMake(currentLat, currentLong);
    self.mapView.delegate = self;
    self.mapView.showsBuildings = YES;
    
    MKCoordinateRegion regn;
    regn.center.latitude=currentLat;
    regn.center.longitude=currentLong;
    regn.span.latitudeDelta=0.02;
    regn.span.longitudeDelta=0.02;
    
    [self.mapView setRegion:regn];
    
    //Add Pin Annotation to the place
    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
    annotationPoint.coordinate = CLLocationCoordinate2DMake(currentLat, currentLong);
    annotationPoint.title = locationName;
    [self.mapView addAnnotation:annotationPoint];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark:MKMapKitDelegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
    if(annotationView)
        return annotationView;
    else
    {
        MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                                         reuseIdentifier:AnnotationIdentifier];
        annotationView.canShowCallout = YES;
        annotationView.image = [UIImage imageNamed:@"location-icon"];
        UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [rightButton addTarget:self action:@selector(annotationAction:) forControlEvents:UIControlEventTouchUpInside];
        [rightButton setTitle:annotation.title forState:UIControlStateNormal];
        annotationView.rightCalloutAccessoryView = rightButton;
        annotationView.canShowCallout = YES;
        annotationView.draggable = YES;
        return annotationView;
    }
    return nil;
}

#pragma mark:IBActions Selectors
-(void)annotationAction:(id)sender{
}
- (IBAction)backBtnAction:(id)sender {
    [self.backBtn setSelected:YES];    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
