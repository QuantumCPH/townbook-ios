//
//  MapViewController.m
//  GPSApp
//
//  Created by Mubashir Hussain on 6/23/14.
//  Copyright (c) 2014 com.rolustech. All rights reserved.
//

#import "MapViewController.h"
#import "MBProgressHUD.h"
#import "PlaceResults.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithPointsArray:(NSMutableArray *)array routesArray:(NSMutableArray *)routeArr ndSearchString:(NSString *)searchStr
{
    self = [super initWithNibName:@"MapViewController" bundle:nil];
    if (self)
	{
		pointsList = [[NSMutableArray alloc] init];
		routesArray = [[NSMutableArray alloc] init];
		routesArray	= routeArr;
		pointsList = array;
		placetoSearch = searchStr;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	results = [[PlaceResults alloc] init];
	
	operationQueue = [[NSOperationQueue alloc] init];
    operationQueue.maxConcurrentOperationCount = 1;

	[self getLocations];
	
	[self setTitle];
}

-(void)setTitle
{
	UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 110, 100, 64)];
	
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont fontWithName:@"Helvetica Neue" size:24];
	label.textAlignment = NSTextAlignmentCenter;
	label.textColor = [UIColor whiteColor];
	label.text = @"Map";
	
	[v addSubview:label];
	
	self.navigationItem.titleView = v;
}

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
//	UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
//	[self willRotateToInterfaceOrientation:orientation duration:1];
	
	// Implement here to check if already KVO is implemented.
//    [mapView_ addObserver:self forKeyPath:@"myLocation" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
//	[mapView_ removeObserver:self forKeyPath:@"myLocation"];
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    if ([keyPath isEqualToString:@"myLocation"] && [object isKindOfClass:[GMSMapView class]])
//    {
//        [mapView_ animateToCameraPosition:[GMSCameraPosition cameraWithLatitude:mapView_.myLocation.coordinate.latitude
//                                                                                 longitude:mapView_.myLocation.coordinate.longitude
//                                                                                      zoom:12]];
//    }
//}

- (void)viewWillLayoutSubviews
{
	[self willRotateToInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation] duration:0];
	[self willAnimateRotationToInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation] duration:0];
}

- (void)focusMapToShowAllMarkers
{
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] init];
    
    for (GMSMarker *marker in markersArray)
        bounds = [bounds includingCoordinate:marker.position];
    
    [mapView_ animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:0.0f]];
}

-(void)getLocations
{
    float distanceValue = 100.0;//[kAppPrefs floatForKey:kRadius];
	
	CLLocation *loc = pointsList[0];
	CLLocationCoordinate2D location = CLLocationCoordinate2DMake(loc.coordinate.latitude, loc.coordinate.longitude);
	myLocation = location;
	
	CLLocation *loc1 = pointsList[pointsList.count-1];
	CLLocationCoordinate2D location1 = CLLocationCoordinate2DMake(loc1.coordinate.latitude, loc1.coordinate.longitude);
	targetLocation = location1;
	
	UIWindow *window = (UIWindow *)[[[UIApplication sharedApplication] windows] lastObject];
	[MBProgressHUD showHUDAddedTo:window animated:YES];
	
    for(int i=0; i< pointsList.count; i++)
	{
		CLLocation *loc = pointsList[i];
		CLLocationCoordinate2D location = CLLocationCoordinate2DMake(loc.coordinate.latitude, loc.coordinate.longitude);
		
		NSString *address = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?sensor=true&location=%f,%f&radius=%f&name=%@&key=%@", location.latitude, location.longitude, distanceValue, placetoSearch, @"AIzaSyDia1A2vN84qZFejbTg5znNWAIN89Sv5Jo"];
		NSString *completeURL = [address stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
//Mine Key		    //AIzaSyCHzPCDPv4BiJp6hNzl1WsdwBPeu0IxDzg
//Client Key		//AIzaSyBp0hL3qz3WxyAATVXrsEm_rmdzKcLi8qI
		
//    NSString *completeURL = @"https://maps.googleapis.com/maps/api/place/nearbysearch/json?sensor=true&location=31.510501,74.351954&radius=1000.000000&name=bank&types=food&key=AIzaSyAv2pCeA5vssIaONQ44EPA8YPIv9VtJYJc";
		NSMutableURLRequest *request = [NSMutableURLRequest
										requestWithURL:[NSURL URLWithString:completeURL]];
		
		[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
		[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
		[request setHTTPMethod:@"GET"];
		
		AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
		
		[operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
			NSString * responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
			PlaceResults *places = [[PlaceResults alloc] initWithDictionary:[responseStr JSONValue]];
			
			NSMutableArray *addedArray = results.placesArray;
			/////// Duplicate records removal
			NSMutableArray *tempArr = [[NSMutableArray alloc] init];
			for(Place *p in places.placesArray)
			{
				BOOL found = NO;
				for(Place *addedPlace in addedArray)
				{
					if([addedPlace.place_id isEqualToString:p.place_id])
					{
						found = YES;
						
						CLLocation *dest = [[CLLocation alloc] initWithLatitude:p.latitude longitude:p.longitude];
						p.distance = [loc distanceFromLocation:dest]/1609.34;
						
						if(p.distance < addedPlace.distance)
						{
							[results.placesArray removeObject:addedPlace];
							[tempArr addObject:p];
						}
						break;
					}
				}
				if(!found)
				{
					CLLocation *dest = [[CLLocation alloc] initWithLatitude:p.latitude longitude:p.longitude];
					p.distance = [loc distanceFromLocation:dest]/1609.34;
					
					[tempArr addObject:p];
				}
			}
			
			[results.placesArray addObjectsFromArray:tempArr];
			
			if(i == pointsList.count-1)
			{
				for(UIView *v in self.view.subviews)
				{
					if([v isKindOfClass:[GMSMapView class]])
						[v removeFromSuperview];
				}
				
				[self createMapView];
				[MBProgressHUD hideAllHUDsForView:window animated:YES];
			}
		} failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
		}];
		
		[operationQueue addOperation:operation];
	}
}

-(void)createMapView
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:myLocation.latitude
                                                            longitude:myLocation.longitude
                                                                 zoom:12];
    mapView_ = [GMSMapView mapWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, ([[UIScreen mainScreen] bounds].size.height- 64)/2) camera:camera];
    mapView_.myLocationEnabled = YES;
    mapView_.delegate = self;
	
//    placesTableview.frame = CGRectMake(placesTableview.frame.origin.x, mapView_.frame.size.height, placesTableview.frame.size.width, [[UIScreen mainScreen] bounds].size.height - mapView_.frame.size.height-64);
    
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] init];
    
    GMSMarker *startMarker = [[GMSMarker alloc] init];
    startMarker.position = CLLocationCoordinate2DMake(myLocation.latitude, myLocation.longitude);
    startMarker.title = @"Starting Point";
    startMarker.icon = [GMSMarker markerImageWithColor:[UIColor purpleColor]];
    startMarker.map = mapView_;
    bounds = [bounds includingCoordinate:startMarker.position];
	
    markersArray = [NSMutableArray array];
    for(Place *eachPlace in results.placesArray)
    {
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(eachPlace.latitude, eachPlace.longitude);
        marker.title = eachPlace.name;
        marker.snippet = eachPlace.address;
        bounds = [bounds includingCoordinate:marker.position];
        
//        if(eachPlace.isOpen)
//            marker.icon = [GMSMarker markerImageWithColor:[UIColor greenColor]];
//        else if(!eachPlace.notAvailable)
//            marker.icon = [GMSMarker markerImageWithColor:[UIColor yellowColor]];
//        else
//            marker.icon = [GMSMarker markerImageWithColor:[UIColor redColor]];
		if(eachPlace.distance < 5.0)
			marker.icon =[GMSMarker markerImageWithColor:[UIColor colorWithRed:0.0/255.0 green:255.0/255.0 blue:0.0/255.0 alpha:1.0]];
//		else{
//			float multiplier = (eachPlace.distance/([kAppPrefs floatForKey:kRadius]/1609.34))*255.0;
//			NSLog(@"Distance:%f    Color: %f    Name:%@   ", eachPlace.distance, multiplier, eachPlace.name);
//			
//			marker.icon =[GMSMarker markerImageWithColor:[UIColor colorWithRed:multiplier/255.0 green:200.0/255.0 blue:0.0/255.0 alpha:1.0]];
//		}
		else if (eachPlace.distance >= 5.0 && eachPlace.distance <= 10.0)
			marker.icon =[GMSMarker markerImageWithColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:0.0/255.0 alpha:1.0]];
		else
			marker.icon =[GMSMarker markerImageWithColor:[UIColor colorWithRed:255.0/255.0 green:165.0/255.0 blue:0.0/255.0 alpha:1.0]];
		
        marker.map = mapView_;
        
        [markersArray addObject:marker];
    }
	
	GMSMarker *destMarker = [[GMSMarker alloc] init];
    destMarker.position = CLLocationCoordinate2DMake(targetLocation.latitude, targetLocation.longitude);
    destMarker.title = @"Destination";
    destMarker.icon = [GMSMarker markerImageWithColor:[UIColor redColor]];
    destMarker.map = mapView_;
	bounds = [bounds includingCoordinate:destMarker.position];
	
    [mapView_ animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:30.0f]];
    
    [self.view addSubview:mapView_];
    
//    [placesTableview reloadData];
	//    [self focusMapToShowAllMarkers];
	[self createRoute];
	
	UIWindow *window = (UIWindow *)[[[UIApplication sharedApplication] windows] lastObject];
	[MBProgressHUD hideAllHUDsForView:window animated:YES];
}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker
{
    Place *targetPlace = nil;
    for(Place *eachPlace in results.placesArray)
    {
        if(eachPlace.longitude == marker.position.longitude && eachPlace.latitude == marker.position.latitude)
        {
            targetPlace = eachPlace;
            break;
        }
    }
	
	CLLocation *loc = routesArray[routesArray.count-1];
	CLLocationCoordinate2D destLocation = CLLocationCoordinate2DMake(loc.coordinate.latitude, loc.coordinate.longitude);
	
//    PlaceDetailVC *detailVC = [[PlaceDetailVC alloc] initWithSelectedPlace:targetPlace startLocation:myLocation destinationLocation:destLocation];
//	detailVC.orignalRoutePoints = [routesArray mutableCopy];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:nil action:nil];
//    [self.navigationController pushViewController:detailVC animated:YES];
}

-(void)createRoute
{
	CLLocation *loc = routesArray[routesArray.count-1];
	CLLocationCoordinate2D destLocation = CLLocationCoordinate2DMake(loc.coordinate.latitude, loc.coordinate.longitude);
	
	CLLocation *loc1 = routesArray[0];
	CLLocationCoordinate2D srcLocation = CLLocationCoordinate2DMake(loc1.coordinate.latitude, loc1.coordinate.longitude);
	
    GMSMutablePath *path = [GMSMutablePath path];
    [path addCoordinate:CLLocationCoordinate2DMake(srcLocation.latitude, srcLocation.longitude)];
    for (CLLocation *loc in routesArray)
	{
		[path addCoordinate:CLLocationCoordinate2DMake(loc.coordinate.latitude, loc.coordinate.longitude)];
    }
    [path addCoordinate:CLLocationCoordinate2DMake(destLocation.latitude, destLocation.longitude)];
    
    GMSPolyline *rectangle = [GMSPolyline polylineWithPath:path];
    rectangle.geodesic =YES;
    rectangle.strokeWidth = 2.f;
    rectangle.map = mapView_;
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Autorotation Methods -

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//	return YES;
//}
//
//- (BOOL)shouldAutorotate
//{
//	return YES;
//}
//
//- (NSUInteger)supportedInterfaceOrientations
//{
//	return UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight | UIInterfaceOrientationPortrait;;
//}

-(BOOL)shouldAutorotate{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations{
    return (UIInterfaceOrientationMaskAllButUpsideDown);
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation))
	{
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.5];
		[UIView setAnimationBeginsFromCurrentState:FALSE];
		mapView_.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, ([[UIScreen mainScreen] bounds].size.height- 64)/2);
		[mapView_ animateToBearing:0];
//		[mapView_ animateToZoom:9.5];
		[UIView commitAnimations];
		
		isFullScreen = !isFullScreen;
	}
	else if(UIInterfaceOrientationIsLandscape(toInterfaceOrientation))
	{
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.5];
		[UIView setAnimationBeginsFromCurrentState:FALSE];
		mapView_.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width- 52);
		[mapView_ animateToBearing:90];
//		[mapView_ animateToZoom:10.5];
		[UIView commitAnimations];
	}
}

-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
//	if (UIInterfaceOrientationIsPortrait(fromInterfaceOrientation))
//	{
//		[UIView beginAnimations:nil context:nil];
//		[UIView setAnimationDuration:0.5];
//		[UIView setAnimationBeginsFromCurrentState:FALSE];
//		mapView_.frame = CGRectMake(0, 52, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
//		[mapView_ animateToBearing:90];
//		[mapView_ animateToZoom:10.5];
//		[UIView commitAnimations];
//	}
//	else if(UIInterfaceOrientationIsLandscape(fromInterfaceOrientation))
//	{
//		[UIView beginAnimations:nil context:nil];
//		[UIView setAnimationDuration:0.5];
//		[UIView setAnimationBeginsFromCurrentState:FALSE];
//		mapView_.frame = CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 250);
//		[mapView_ animateToBearing:0];
//		[mapView_ animateToZoom:9.5];
//		[UIView commitAnimations];
//		
//		isFullScreen = !isFullScreen;
//		
//	}
}

@end
