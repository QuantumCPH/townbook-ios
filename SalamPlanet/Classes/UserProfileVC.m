//
//  UserProfileVC.m
//  SalamPlanet
//
//  Created by Globit on 07/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "UserProfileVC.h"

@interface UserProfileVC ()

@end

@implementation UserProfileVC

-(id)init{
    self = [super initWithNibName:@"UserProfileVC" bundle:nil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
