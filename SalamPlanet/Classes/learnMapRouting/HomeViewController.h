//
//  HomeViewController.h
//  GPSApp
//
//  Created by Mubashir Hussain on 6/23/14.
//  Copyright (c) 2014 com.rolustech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>
#import "AFNetworking.h"
//#import "LoadingView.h"
#import "MBProgressHUD.h"
#import "DropDownTableView.h"

@class SPGooglePlacesAutocompleteQuery;
@interface HomeViewController : UIViewController <CLLocationManagerDelegate, UITextFieldDelegate, DropDownTableViewProtocol,UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate>
{
	IBOutlet UITextField *toTextField;
	IBOutlet UITextField *fromTextField;
	IBOutlet UITextField *searchTextField;
	IBOutlet UITextField *distanceTxtField;
	
	CLLocationManager *locationManager;
	CLLocationCoordinate2D currentLocation;
	CLLocationCoordinate2D destLocation;
	
	NSURLConnection *connection;
	NSOperationQueue *operationQueue;
	
//	LoadingView *loadingView;
	
	NSMutableArray *routesArray;
	NSMutableArray *routePointsArray;
    
    NSMutableArray *searchResultPlaces;
    SPGooglePlacesAutocompleteQuery *searchQuery;
    IBOutlet UITableView *tableView;
}

- (IBAction)currentLocationBtnPressed:(id)sender;
- (IBAction)goBtnPressed:(id)sender;
- (IBAction)openPlacesDropdown:(id)sender;
- (IBAction)openDistanceDropdown:(id)sender;

@end
