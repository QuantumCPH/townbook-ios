//
//  ShowMapVC.h
//  SalamPlanet
//
//  Created by Globit on 30/10/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ShowMapVC : UIViewController<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

- (IBAction)backBtnAction:(id)sender;
-(id)initWithCoordinatesLong:(CGFloat)lng ANDLat:(CGFloat)lat ANDLocationName:(NSString *)locName;
@end
