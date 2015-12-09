//
//  AddLocationView.h
//  SalamPlanet
//
//  Created by Globit on 25/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SPGooglePlacesAutocompleteQuery.h"

@protocol AddLocViewDelegate
-(void)locationNameisSelected:(NSString *)locationName ANDGPSValues:(CLLocationCoordinate2D)locationCoordinates;
-(void)locationViewIsCancelled;
@end

@interface AddLocationView : UIView<UITextFieldDelegate>
{
    NSMutableArray * searchedPlacesArray;
    AppDelegate * appDelegate;
    SPGooglePlacesAutocompleteQuery *searchQuery;
    NSMutableArray * suggestionArray;
}
@property (weak, nonatomic) id<AddLocViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *inputTF;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString * selectedLocationName;
@property (nonatomic) CLLocationCoordinate2D selectedLocationGPS;
- (IBAction)doneAction:(id)sender;

- (id)initWithGoogleApi:(BOOL)check;
- (id)initWithGoogleApi:(BOOL)check ANDLoc:(NSString *)loc;
-(void)resetData;
@end
