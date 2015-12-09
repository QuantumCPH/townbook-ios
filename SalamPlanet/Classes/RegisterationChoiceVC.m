//
//  RegisterationChoiceVC.m
//  SalamCenterApp
//
//  Created by Waseem Asif on 17/09/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import "RegisterationChoiceVC.h"
#import "LoginViewController.h"
#import "EditProfileViewController.h"
#import "FBLogin.h"
#import "MBProgressHUD.h"
#import "WebManager.h"
#import "BDVCountryNameAndCode.h"
#import "CountryList.h"
#import "AppDelegate.h"
#import "AFNetworking.h"

@interface RegisterationChoiceVC ()<FBLoginDelegate>
{
    FBLogin * fbLogin;
    AppDelegate *appDelegate;
    NSMutableDictionary * countriesCode;
    
    __weak IBOutlet UIButton *phoneButton;
    __weak IBOutlet UIButton *facebookButton;
    __weak IBOutlet UILabel *welcomeLabel;
}
@end

@implementation RegisterationChoiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self applyTextLocalization];
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    CountryList *obj = [[CountryList alloc] init];
    countriesCode = [[NSMutableDictionary alloc] initWithDictionary:obj.countryCodes];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSNotificationCenter * notifCenter=[NSNotificationCenter defaultCenter];
    [notifCenter addObserver:self selector:@selector(doGeoCode) name:kLocationManagerLocationUpdateNotification object:nil];
    [notifCenter addObserver:self selector:@selector(getCountryFromPhoneLocale) name:kNotificationCLLocationManagerNotAuthentication object:nil];
    
}
#pragma mark:Custom Methods
- (void)getCountryFromPhoneLocale
{
    BDVCountryNameAndCode *bdvCountryNameAndCode = [[BDVCountryNameAndCode alloc] init];
    NSString *prefixOfCurrentLocale = [bdvCountryNameAndCode prefixForCurrentLocale]; // Returns "+1" for Canada
    NSString *nameOfCurrentLocale = [bdvCountryNameAndCode countryNameForCurrentLocale]; // Returns "Canada"
    if (prefixOfCurrentLocale && nameOfCurrentLocale) {
        //NSString *codeName = [NSString stringWithFormat:@"%@ (+%@)",nameOfCurrentLocale,prefixOfCurrentLocale];
        
        NSDictionary *codeDict = [[NSDictionary alloc] initWithDictionary:[countriesCode objectForKey:nameOfCurrentLocale]];
        
        [[NSUserDefaults standardUserDefaults] setObject:nameOfCurrentLocale forKey:kSelectedCountryName];
        [[NSUserDefaults standardUserDefaults] setObject:prefixOfCurrentLocale forKey:kSelectedCountryCode];
        [[NSUserDefaults standardUserDefaults] setObject:[codeDict objectForKey:@"Abbr"]forKey:kSelectedCountryShortName];
        [[NSUserDefaults standardUserDefaults] synchronize];
    
    }
    
}
- (void)applyTextLocalization
{
    welcomeLabel.text = [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"Welcome to", nil),kAppName];
    [phoneButton setTitle:NSLocalizedString(@"Register with Phone", nil) forState:UIControlStateNormal];
    [facebookButton setTitle:NSLocalizedString(@"Register with Facebook", nil) forState:UIControlStateNormal];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    NSNotificationCenter * notifCenter=[NSNotificationCenter defaultCenter];
    [notifCenter removeObserver:self name:kLocationManagerLocationUpdateNotification object:nil];
    [notifCenter removeObserver:self name:kNotificationCLLocationManagerNotAuthentication object:nil];
    
}
#pragma mark:Webservices
-(void)doGeoCode
{
    
    NSString *urlString = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=true&language=en",appDelegate.locationManager.location.coordinate.latitude,appDelegate.locationManager.location.coordinate.longitude];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [manager POST:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"JSON: %@", response);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([[response objectForKey:@"status"] isEqualToString:@"OK"]) {
            
            id results = [response objectForKey:@"results"];
            if ([results isKindOfClass:[NSArray class]]) {
                
                NSDictionary *firstResult = [results objectAtIndex:0];
                NSArray *addressComponent = [firstResult objectForKey:@"address_components"];
                
                for (NSDictionary *component in addressComponent) {
                    NSArray *types = [component objectForKey:@"types"];
                    if (types)
                    {
                        if ([types filteredArrayUsingPredicate: [NSPredicate predicateWithFormat:@"SELF == %@", @"country"]].count > 0) {
                            NSString * countryName=[component objectForKey:@"long_name"];
                            [[NSUserDefaults standardUserDefaults] setObject:countryName forKey:kSelectedCountryName];
                            NSDictionary *codeDict = [[NSDictionary alloc] initWithDictionary:[countriesCode objectForKey:countryName]];
                            NSLog(@"%@",codeDict);
                            [[NSUserDefaults standardUserDefaults] setObject:[codeDict objectForKey:@"Code"]forKey:kSelectedCountryCode];
                            [[NSUserDefaults standardUserDefaults] setObject:[codeDict objectForKey:@"Abbr"]forKey:kSelectedCountryShortName];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            
//                            NSString *codeName = [NSString stringWithFormat:@"%@ (+%@)",[[NSUserDefaults standardUserDefaults] objectForKey:kSelectedCountryName],[[NSUserDefaults standardUserDefaults] objectForKey:kSelectedCountryCode]];

                        }
                        
                    }
                    
                }
                //For city name
                NSDictionary *secondResult = [results objectAtIndex:1];
                NSString * formattedddress;
                if (secondResult)
                {
                    for (NSDictionary *component in addressComponent) {
                        NSArray *types = [component objectForKey:@"types"];
                        if (types)
                        {
                            if ([types filteredArrayUsingPredicate: [NSPredicate predicateWithFormat:@"SELF == %@", @"locality"]].count > 0)
                            {
                                NSString *cityName = [component objectForKey:@"long_name"];
                                SaveStringWithKey(cityName, kLocationServiceCity);
                            }
                        }
                    }
                    formattedddress=[secondResult objectForKey:@"formatted_address"];
                }
                else
                    formattedddress=[firstResult objectForKey:@"formatted_address"];
                
                if (formattedddress)
                    SaveStringWithKey(formattedddress, kLocationServiceAddress);
                else
                    NSLog(@"formatted address not saved");
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"Geocode error string %@", [error description]);
    }];
}
- (void)pushEditProfileScreenWithFacebookUser:(FBUserSelf *)fbUser
{
    EditProfileViewController * editProfileVC =[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"EditProfile"];
    editProfileVC.isFacebookRegistration = YES;
    editProfileVC.fbUser = fbUser;
    [self.navigationController pushViewController:editProfileVC animated:YES];
}
#pragma mark - IBActions
- (IBAction)regPhoneTapped:(UIButton*)sender {
//    [[WebManager sharedInstance] checkAPI];
//    return ;
    [phoneButton setSelected:YES];
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (IBAction)regFacebookTapped:(UIButton*)sender {
    [facebookButton setSelected:YES];
    if (!fbLogin) {
        fbLogin = [[FBLogin alloc] init];
        fbLogin.delegate = self;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [fbLogin loginFB];
}
#pragma mark - FBLoginDelegate
- (void)fbProfileHasBeenFetchedSuccessfullyWithInfo:(FBUserSelf *)fbUser
{
    [[WebManager sharedInstance] registerUserByFacebookId:fbUser.fbiD success:^(id response) {
        [[WebManager sharedInstance] getCurrentUserProfile:^(id response) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [self pushEditProfileScreenWithFacebookUser:fbUser];
        } failure:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [self pushEditProfileScreenWithFacebookUser:fbUser];
        }];

        
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
        ShowMessage(kAppName, NSLocalizedString([error localizedDescription],nil));
    }];
}
-(void)failedToFetchAnyAccount{
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
}
-(void)fbProfileDidNotFetched{
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
    ShowMessage(kAppName, @"Sorry, failed to fetch profile info.");
}
@end
