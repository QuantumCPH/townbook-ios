//
//  SplashViewController.m
//  SalamCenterApp
//
//  Created by Waseem Asif on 21/09/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import "SplashViewController.h"
#import "RegisterationChoiceVC.h"
#import "AppDelegate.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mainImageView.image = _mainImage;
    [self performSelector:@selector(displayRegistrationChoiceScreen) withObject:nil afterDelay:2.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)displayRegistrationChoiceScreen
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //[appDelegate registerRemoteNotification];//for app presentation
    [appDelegate initializeLocationManager];
    RegisterationChoiceVC * regChoiceVC =[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"RegistrationChoice"];
    [self.navigationController pushViewController:regChoiceVC animated:NO];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
