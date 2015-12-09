//
//  DBDemoVC.m
//  SalamCenterApp
//
//  Created by Globit on 18/02/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import "DBDemoVC.h"
#import "AFSQLManager.h"
#import "DBDemoTableView.h"

@interface DBDemoVC ()
@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation DBDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [_button addTarget:self action:@selector(performQuery) forControlEvents:UIControlEventTouchUpInside];
    self.lblDBName.text=@"MallAppDB.sqlite";
    [[AFSQLManager sharedManager]openLocalDatabaseWithName:@"MallAppDB.sqlite" andStatusBlock:^(BOOL success, NSError *error) {
        if (error) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Oops" message:error.description delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)performQuery {
    
    _array = [NSMutableArray array];
    [[AFSQLManager sharedManager]performQuery:_textField.text withBlock:^(NSArray *row, NSError *error, BOOL finished) {
        
        if (!error) {
            
            if (!finished) {
                [_array addObject:row];
            } else {
                DBDemoTableView *resultsVC = [[DBDemoTableView alloc]init];
                resultsVC.results = _array;
                [self.navigationController pushViewController:resultsVC animated:YES];
            }
        } else {
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Oops" message:error.description delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
    }];
}


@end
