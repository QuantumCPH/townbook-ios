//
//  AddLocationViewController.m
//  SalamPlanet
//
//  Created by Globit on 23/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "AddLocationViewController.h"
#import "AppDelegate.h"
#import "SPGooglePlacesAutocompleteQuery.h"
#import "SPGooglePlacesAutocompletePlace.h"

@interface AddLocationViewController ()
{
    AppDelegate * appDelegate;
    NSMutableArray * searchedPlacesArray;
}

@end

@implementation AddLocationViewController

@synthesize locationNameSelected;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        searchQuery = [[SPGooglePlacesAutocompleteQuery alloc] init];
        searchQuery.radius = 100.0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    searchedPlacesArray=[[NSMutableArray alloc]init];
    appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    cell.textLabel.font = [UIFont fontWithName:@"GillSans" size:16.0];
    cell.textLabel.text = [self placeAtIndexPath:indexPath].name;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    locationNameSelected=[self placeAtIndexPath:indexPath].name;
    [self.delegate locationNameisSelected:locationNameSelected];
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
            [self.placesTableView reloadData];
        }
    }];
}
#pragma mark: IBActions and Selectors
- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
