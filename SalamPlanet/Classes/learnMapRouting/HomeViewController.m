//
//  HomeViewController.m
//  GPSApp
//
//  Created by Mubashir Hussain on 6/23/14.
//  Copyright (c) 2014 com.rolustech. All rights reserved.
//

#import "HomeViewController.h"
#import "MapViewController.h"
#import "SPGooglePlacesAutocompleteQuery.h"
#import "SPGooglePlacesAutocompletePlace.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//	self.title = @"Home";
	[tableView setHidden:YES];
    searchQuery = [[SPGooglePlacesAutocompleteQuery alloc] init];
    searchQuery.radius = 100.0;
	routesArray = [[NSMutableArray alloc] init];
	routePointsArray = [[NSMutableArray alloc] init];
	
	operationQueue = [[NSOperationQueue alloc] init];
    operationQueue.maxConcurrentOperationCount = 1;
	
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"resign" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideTableView) name:@"resign" object:nil];
	
	[self setTitle];
	
//	fromTextField.text = @"Nottingham, PA, United States";
//	toTextField.text = @"Upper Darby, PA, United States";
}

-(void)setTitle
{
	UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
	
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont fontWithName:@"Helvetica Neue" size:24];
	label.textAlignment = NSTextAlignmentCenter;
	label.textColor = [UIColor whiteColor];
	label.text = @"Home";
	
	[v addSubview:label];
	
	self.navigationItem.titleView = v;
}

-(void)hideTableView
{
    [searchResultPlaces removeAllObjects];
    [tableView setHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
	[routesArray removeAllObjects];
	[routePointsArray removeAllObjects];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)currentLocationBtnPressed:(id)sender
{
	locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = 10;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}

- (IBAction)goBtnPressed:(id)sender
{
	toTextField.text = [self trimString:toTextField.text];
	fromTextField.text = [self trimString:fromTextField.text];
	
	if(![toTextField.text isEqualToString:fromTextField.text])
	{
		if(toTextField.text.length > 0 && fromTextField.text.length > 0 && searchTextField.text.length > 0)
		{
			UIWindow *window = (UIWindow *)[[[UIApplication sharedApplication] windows] lastObject];
			[MBProgressHUD showHUDAddedTo:window animated:YES];
			
			destLocation = [self geoCodeUsingAddress:toTextField.text];
			if(![fromTextField.text isEqualToString:@"Current Location"])
				currentLocation = [self geoCodeUsingAddress:fromTextField.text];
			[self getRoutetails];
		}
		else
		{
			[[[UIAlertView alloc] initWithTitle:kAppName message:@"Please fill all the fields." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
		}
	}
	else
	{
		[[[UIAlertView alloc] initWithTitle:kAppName message:@"Try different source and destination points." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
	}
}

- (CLLocationCoordinate2D) geoCodeUsingAddress: (NSString *) address
{
	NSString *esc_addr = [address stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
	
	NSString *req = [NSString stringWithFormat: @"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
	
	NSDictionary *googleResponse = [[NSString stringWithContentsOfURL: [NSURL URLWithString: req] encoding: NSUTF8StringEncoding error: NULL] JSONValue];
	
	NSDictionary *resultsDict = [googleResponse valueForKey: @"results"];
	NSDictionary *geometryDict = [resultsDict valueForKey: @"geometry"];
	NSDictionary *locationDict = [geometryDict valueForKey: @"location"];
	NSArray *latArray = [locationDict valueForKey: @"lat"]; NSString *latString = [latArray lastObject];
	NSArray *lngArray = [locationDict valueForKey: @"lng"]; NSString *lngString = [lngArray lastObject];
	
	CLLocationCoordinate2D location;
	
	location.latitude = [latString doubleValue];
	location.longitude = [lngString doubleValue];
	
	return location;
}

-(void) getRoutetails
{
//	[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    UIWindow *window = (UIWindow *)[[[UIApplication sharedApplication] windows] lastObject];
    AFHTTPClient *_httpClient = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:@"http://maps.googleapis.com/"]];
    [_httpClient registerHTTPOperationClass: [AFJSONRequestOperation class]];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:[NSString stringWithFormat:@"%f,%f", currentLocation.latitude, currentLocation.longitude] forKey:@"origin"];
    [parameters setObject:[NSString stringWithFormat:@"%f,%f", destLocation.latitude, destLocation.longitude] forKey:@"destination"];
//	[parameters setObject:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f,%f", 31.488909,74.327742], nil] forKey:@"waypoints"];
    [parameters setObject:@"true" forKey:@"sensor"];
    
    NSMutableURLRequest *request = [_httpClient requestWithMethod:@"GET" path: @"maps/api/directions/json" parameters:parameters];
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    
    AFHTTPRequestOperation *operation = [_httpClient HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id response) {
        NSInteger statusCode = operation.response.statusCode;
        if (statusCode == 200) {
            NSError* error;
            NSDictionary* json = [NSJSONSerialization
                                  JSONObjectWithData:response
                                  
                                  options:kNilOptions
                                  error:&error];
			
            [self parseResponse:json];
			[self getDistances];
			
			[MBProgressHUD hideAllHUDsForView:window animated:YES];
			
			[self moveToMapView];
			
        } else {
			[MBProgressHUD hideAllHUDsForView:window animated:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		[MBProgressHUD hideAllHUDsForView:window animated:YES];
	}];
    
    [_httpClient enqueueHTTPRequestOperation:operation];
}

-(void) moveToMapView
{
	UIWindow *window = (UIWindow *)[[[UIApplication sharedApplication] windows] lastObject];
	if(routesArray.count > 0)
	{
//		[kAppDeledate setFromField:fromTextField.text];
//		[kAppDeledate setToField:toTextField.text];
		
		NSString *path = [[NSBundle mainBundle] pathForResource:@"PlacesList" ofType:@"plist"];
		NSMutableDictionary *mappingDict = [NSMutableDictionary dictionaryWithContentsOfFile:path];
		NSString *searchStr = [mappingDict objectForKey:searchTextField.text];
		if(!searchStr)
		{
			searchStr = [searchTextField.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
		}
		
		MapViewController *mapVC = [[MapViewController alloc] initWithPointsArray:[routePointsArray mutableCopy] routesArray:[routesArray mutableCopy] ndSearchString:searchStr];
		[self.navigationController pushViewController:mapVC animated:YES];
	}
	else
	{
		[MBProgressHUD hideAllHUDsForView:window animated:YES];
		[[[UIAlertView alloc] initWithTitle:kAppName message:@"No route found from source to destination!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
	}
}

-(void) getDistances
{
	if(routesArray.count > 0)
	{
		[routePointsArray addObject:[routesArray objectAtIndex:0]];
		float distanceValue = [kAppPrefs floatForKey:kRadius]/2.0;
		
		CLLocationCoordinate2D lastLocation = currentLocation;
		for(int i=0; i<routesArray.count; i++)
		{
			CLLocation *locA = [[CLLocation alloc] initWithLatitude:lastLocation.latitude longitude:lastLocation.longitude];
			CLLocation *locB = [routesArray objectAtIndex:i];
			CLLocationDistance distance = [locB distanceFromLocation:locA];
			
			if(distance >= distanceValue)
			{
				CLLocationCoordinate2D location = CLLocationCoordinate2DMake(locB.coordinate.latitude, locB.coordinate.longitude);
				
				[routePointsArray addObject:[routesArray objectAtIndex:i]];
//				NSLog(@"Distance: %f meters :: Lat: %f   Long: %f", distance, location.latitude, location.longitude);
				lastLocation = location;
			}
			
			if(i+1 == routesArray.count)
			{
//			    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(locB.coordinate.latitude, locB.coordinate.longitude);
				[routePointsArray addObject:[routesArray objectAtIndex:i]];
//				NSLog(@"Distance: %f meters :: Lat: %f   Long: %f", distance, location.latitude, location.longitude);
			}
		}
	}
}

#pragma mark Parsing Methods
- (void)parseResponse:(NSDictionary *)response
{
    NSArray *routes = [response objectForKey:@"routes"];
    NSDictionary *route = [routes lastObject];
	if (route)
	{
        NSString *overviewPolyline = [[route objectForKey: @"overview_polyline"] objectForKey:@"points"];
        [self decodePolyLine:overviewPolyline];
    }
}

-(void)decodePolyLine:(NSString *)encodedStr
{
	@try {
		
		NSMutableString *encoded = [[NSMutableString alloc] initWithCapacity:[encodedStr length]];
		[encoded appendString:encodedStr];
		[encoded replaceOccurrencesOfString:@"\\\\" withString:@"\\"
									options:NSLiteralSearch
									  range:NSMakeRange(0, [encoded length])];
		NSInteger len = [encoded length];
		NSInteger index = 0;
		NSInteger lat=0;
		NSInteger lng=0;
		while (index < len) {
			NSInteger b;
			NSInteger shift = 0;
			NSInteger result = 0;
			do {
				b = [encoded characterAtIndex:index++] - 63;
				result |= (b & 0x1f) << shift;
				shift += 5;
			} while (b >= 0x20);
			NSInteger dlat = ((result & 1) ? ~(result >> 1) : (result >> 1));
			lat += dlat;
			shift = 0;
			result = 0;
			do {
				b = [encoded characterAtIndex:index++] - 63;
				result |= (b & 0x1f) << shift;
				shift += 5;
			} while (b >= 0x20);
			NSInteger dlng = ((result & 1) ? ~(result >> 1) : (result >> 1));
			lng += dlng;
			NSNumber *latitude = [[NSNumber alloc] initWithFloat:lat * 1e-5];
			NSNumber *longitude = [[NSNumber alloc] initWithFloat:lng * 1e-5];
			
			CLLocation *location = [[CLLocation alloc] initWithLatitude:[latitude floatValue] longitude:[longitude floatValue]];
			[routesArray addObject:location];
		}
		
	}
	@catch (NSException *exception) {
	}
	@finally {
	}
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    currentLocation.latitude = newLocation.coordinate.latitude;
    currentLocation.longitude = newLocation.coordinate.longitude;
	fromTextField.text = @"Current Location";
    [locationManager stopUpdatingLocation];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
    [tableView setHidden:YES];
	return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    tableView.frame = CGRectMake(tableView.frame.origin.x, textField.frame.origin.y + textField.frame.size.height + 2, tableView.frame.size.width, [[UIScreen mainScreen] bounds].size.height - (textField.frame.origin.y + textField.frame.size.height) - 64);
    [tableView setHidden:NO];
    [self handleSearchForSearchString:[NSString stringWithFormat:@"%@%@",textField.text,string]];
    return YES;
}
- (IBAction)openPlacesDropdown:(id)sender
{
	[toTextField resignFirstResponder];
	[fromTextField resignFirstResponder];
	[searchTextField resignFirstResponder];
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"PlacesList" ofType:@"plist"];
	NSMutableDictionary *mappingDict = [NSMutableDictionary dictionaryWithContentsOfFile:path];
	
	NSArray *placesArray = [NSArray arrayWithArray:[mappingDict allKeys]];
    NSArray *sortedArray = [placesArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
	
    DropDownTableView *dropDownTableView = [[DropDownTableView alloc] initWithTitle:@"Select Place" items:sortedArray icons:nil andDelegate:self forPopUp:NO];
    dropDownTableView.valuesArray = sortedArray;
    dropDownTableView.tag = 1;
    dropDownTableView.isMultiSelect = NO;
    dropDownTableView.minimize = YES ;
	
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:dropDownTableView animated:YES];
}

- (IBAction)openDistanceDropdown:(id)sender
{
	[toTextField resignFirstResponder];
	[fromTextField resignFirstResponder];
	
	NSArray *placesArray = [NSArray arrayWithObjects:@"1 Mi", @"5 Mi", @"10 Mi", @"50 Mi", @"100 Mi", nil];
    
    DropDownTableView *dropDownTableView = [[DropDownTableView alloc] initWithTitle:@"Select Distance" items:placesArray icons:nil andDelegate:self forPopUp:NO];
    dropDownTableView.valuesArray = placesArray;
    dropDownTableView.tag = 2;
    dropDownTableView.isMultiSelect = NO;
    dropDownTableView.minimize = YES ;
	
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:dropDownTableView animated:YES];
}

#pragma mark - DropDown Delegate Methods -

-(void) elementSelected:(NSString*) selectedElement ForDropDownTableView:(DropDownTableView*) dropDowntableView
{
	NSLog(@"Value: %@", selectedElement);
	if(dropDowntableView.tag == 1)
		searchTextField.text = selectedElement;
	else if(dropDowntableView.tag == 2)
	{
		float distance = 0.0;
		distanceTxtField.text = selectedElement;
		if([selectedElement isEqualToString:@"1 Mi"])
			distance = 1609.34*1;
		else if([selectedElement isEqualToString:@"5 Mi"])
			distance = 1609.34*5;
		else if([selectedElement isEqualToString:@"10 Mi"])
			distance = 1609.34*10;
		else if([selectedElement isEqualToString:@"50 Mi"])
			distance = 1609.34*50;
		else if([selectedElement isEqualToString:@"100 Mi"])
			distance = 1609.34*100;
		
		[kAppPrefs setFloat:distance forKey:kRadius];
		[kAppPrefs synchronize];
	}
}


//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//	return NO;
//}
//
//- (BOOL)shouldAutorotate
//{
//	return NO;
//}
//
//- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
//}
//
//-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
//{
//}
//
//- (NSUInteger)supportedInterfaceOrientations
//{
//	return UIInterfaceOrientationPortrait;
//}

-(BOOL)shouldAutorotate
{
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations{
    return (UIInterfaceOrientationMaskPortrait);
}

- (NSString *)trimString:(NSString *)str
{
	NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
	return [str stringByTrimmingCharactersInSet:whitespace];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [searchResultPlaces count];
}

- (SPGooglePlacesAutocompletePlace *)placeAtIndexPath:(NSIndexPath *)indexPath {
    return [searchResultPlaces objectAtIndex:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"SPGooglePlacesAutocompleteCell";
    UITableViewCell *cell = [tableView1 dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.font = [UIFont fontWithName:@"GillSans" size:16.0];
    cell.textLabel.text = [self placeAtIndexPath:indexPath].name;
    return cell;
}

- (void)tableView:(UITableView *)tableView1 didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SPGooglePlacesAutocompletePlace *place = [self placeAtIndexPath:indexPath];
    if([fromTextField isFirstResponder])
    {
        fromTextField.text = place.name;
        [fromTextField resignFirstResponder];
    }
    else
    {
        toTextField.text = place.name;
        [fromTextField resignFirstResponder];
    }
    [searchResultPlaces removeAllObjects];
    [tableView1 setHidden:YES];
    
}

#pragma mark -
#pragma mark UISearchDisplayDelegate

- (void)handleSearchForSearchString:(NSString *)searchString {
    searchQuery.location = currentLocation;
    searchQuery.input = searchString;
    [searchQuery fetchPlaces:^(NSArray *places, NSError *error) {
        if (error) {
            SPPresentAlertViewWithErrorAndTitle(error, @"Could not fetch Places");
        } else {
//            [searchResultPlaces release];
            searchResultPlaces = [places mutableCopy];
            [tableView reloadData];
        }
    }];
}


@end
