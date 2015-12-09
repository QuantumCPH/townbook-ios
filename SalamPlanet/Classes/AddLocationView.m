//
//  AddLocationView.m
//  SalamPlanet
//
//  Created by Globit on 25/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "AddLocationView.h"
#import "SPGooglePlacesAutocompleteQuery.h"
#import "SPGooglePlacesAutocompletePlace.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "Constants.h"

@implementation AddLocationView
@synthesize delegate;


- (id)initWithGoogleApi:(BOOL)check{
    self = [self loadFromNib];
    if (self)
    {
        searchedPlacesArray=[[NSMutableArray alloc]init];
        appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
        searchQuery = [[SPGooglePlacesAutocompleteQuery alloc] init];
        suggestionArray = [[NSMutableArray alloc]init];
        searchQuery.radius = 100.0;
        self.inputTF.delegate=self;
        self.inputTF.placeholder=NSLocalizedString(@"Enter location", nil);
//        [self.inputTF becomeFirstResponder];
    }
    return self;
}
- (id)initWithGoogleApi:(BOOL)check ANDLoc:(NSString *)loc{
    self = [self loadFromNib];
    if (self)
    {
        searchedPlacesArray=[[NSMutableArray alloc]init];
        appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
        searchQuery = [[SPGooglePlacesAutocompleteQuery alloc] init];
        suggestionArray = [[NSMutableArray alloc]init];
        searchQuery.radius = 100.0;
        self.inputTF.delegate=self;
        self.inputTF.text=loc;
        self.inputTF.placeholder=NSLocalizedString(@"Enter location", nil);
    }
    return self;
}
-(void)resetData{
    [searchedPlacesArray removeAllObjects];
    [self.inputTF setText:@""];
    [self.tableView reloadData];
}
-(void)loadSuggestionArray{
    
}
-(void)willMoveToSuperview:(UIView *)newSuperview{
    [self.inputTF becomeFirstResponder];
}
- (id)loadFromNib
{
    NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"AddLocationView" owner:nil options:nil];
    return [array objectAtIndex:0];
}
#pragma mark UITableViewDataSource & Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [searchedPlacesArray count];
}

- (SPGooglePlacesAutocompletePlace *)placeAtIndexPath:(NSIndexPath *)indexPath {
    return [searchedPlacesArray objectAtIndex:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"SPGooglePlacesAutocompleteCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.font = [UIFont fontWithName:@"GillSans" size:12.0];
    cell.textLabel.numberOfLines=0;
    cell.textLabel.text = [self placeAtIndexPath:indexPath].name;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * locationNameSelected=[self placeAtIndexPath:indexPath].name;
    _selectedLocationName=locationNameSelected;
    NSString * placeReference = [self placeAtIndexPath:indexPath].reference;
    [self webserviceForGettingGPSLocationOfSelectedLocationWithReference:placeReference];
}
#pragma mark: UITextFeild delegates
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string   // return NO to not change text
{
    NSLog(@"String: %@",textField.text);
    if([textField.text length]>1){
        [self callSPGoogleSearchQueryWithText:textField.text];
    }
    return YES;
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark: SPGoogleSearchQuery Method
-(void)callSPGoogleSearchQueryWithText:(NSString *)string{
    
    searchQuery.location = appDelegate.locationManager.location.coordinate;//self.mapView.userLocation.coordinate;
    searchQuery.input = string;
    [searchQuery fetchPlaces:^(NSArray *places, NSError *error) {
        if (error) {
            SPPresentAlertViewWithErrorAndTitle(error, @"Could not fetch Places");
        } else {
            [searchedPlacesArray removeAllObjects];
            for (id obj in places) {
                [searchedPlacesArray addObject:obj];
            }
            [self.tableView reloadData];
        }
    }];
}
#pragma mark-IBActions & Selectors
- (IBAction)doneAction:(id)sender {
    [self.inputTF resignFirstResponder];
    [self removeFromSuperview];
    [delegate locationViewIsCancelled];
}
-(void)calledTheDelegatedWithLocatioNameAndGPSValues{
    [delegate locationNameisSelected:_selectedLocationName ANDGPSValues:_selectedLocationGPS];
    [self removeFromSuperview];
    [self.inputTF resignFirstResponder];
}
#pragma mark-Webservices
-(void)webserviceForGettingGPSLocationOfSelectedLocationWithReference:(NSString *)reference{
    
    NSString * urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?input=bar&reference=%@&key=%@",reference,kGoogleAPIKey];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    [manager POST:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id response) {
        //NSLog(@"JSON: %@", response);
        if([response objectForKey:@"result"])
        {
            if(![[NSNull null]isEqual:[response objectForKey:@"result"]])
            {
                NSDictionary * resultDict=[response objectForKey:@"result"];
                if([resultDict objectForKey:@"geometry"])
                {
                    if(![[NSNull null]isEqual:[resultDict objectForKey:@"geometry"]])
                    {
                        NSDictionary *geometryDict=[resultDict objectForKey:@"geometry"];
                        if([geometryDict objectForKey:@"location"])
                        {
                            if(![[NSNull null]isEqual:[geometryDict objectForKey:@"location"]])
                            {
                                NSDictionary * locationDict=[geometryDict objectForKey:@"location"];
                                _selectedLocationGPS.latitude=[[locationDict valueForKey:@"lat"]floatValue];
                                _selectedLocationGPS.longitude=[[locationDict valueForKey:@"lng"]floatValue];
                            }
                        }
                    }
                }
            }
        }
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        [self performSelectorOnMainThread:@selector(calledTheDelegatedWithLocatioNameAndGPSValues) withObject:nil waitUntilDone:NO];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Geocode error string %@", [error description]);
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        [self performSelectorOnMainThread:@selector(calledTheDelegatedWithLocatioNameAndGPSValues) withObject:nil waitUntilDone:NO];
    }];

}
@end
