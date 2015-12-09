//
//  CustomAnnotation.m
//  SalamCenterApp
//
//  Created by Globit on 02/02/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import "CustomAnnotation.h"

@implementation CustomAnnotation
-(id)initWithTitle:(NSString *)newTitle Location:(CLLocationCoordinate2D)location
{
    self=[super init];
    if (self) {
        _title=newTitle;
        _coordinate=location;
    }
    return self;
}
-(MKAnnotationView *)annotationView{
    MKAnnotationView * annotationView=[[MKAnnotationView alloc]initWithAnnotation:self reuseIdentifier:@"customAnnotation"];
    annotationView.enabled=YES;
    annotationView.canShowCallout=YES;
    annotationView.image =[UIImage imageNamed:@"location-icon"];
    annotationView.rightCalloutAccessoryView=[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    return annotationView;
}

@end
