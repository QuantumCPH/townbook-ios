//
//  MapViewController.h
//  GPSApp
//
//  Created by Mubashir Hussain on 6/23/14.
//  Copyright (c) 2014 com.rolustech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "PlaceResults.h"
#import <CoreLocation/CoreLocation.h>
#import "AFNetworking.h"

@interface MapViewController : UIViewController <CLLocationManagerDelegate, GMSMapViewDelegate>
{
	NSMutableArray *pointsList;
	NSMutableArray *routesArray;
	NSString *placetoSearch;
	
	GMSMapView *mapView_;
    PlaceResults *results;
    NSURLConnection *connection;
	NSOperationQueue *operationQueue;

	NSMutableArray *markersArray;
    BOOL isFullScreen;
	
	CLLocationCoordinate2D myLocation;
	CLLocationCoordinate2D targetLocation;
}

- (id)initWithPointsArray:(NSMutableArray *)array routesArray:(NSMutableArray *)routeArr ndSearchString:(NSString *)searchStr;

@end
