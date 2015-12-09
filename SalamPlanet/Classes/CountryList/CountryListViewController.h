//
//  CountryListViewController.h
//  SalamPlanet
//
//  Created by Saad Khan on 18/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "MJNIndexView.h"

@interface CountryListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,MJNIndexViewDataSource>
{

	NSMutableArray *countries;
    NSMutableDictionary *countriesCode;
	IBOutlet UITableView *tableView;
	NSIndexPath    *lastIndexPath;
}
@property (strong, nonatomic) IBOutlet UILabel *lblPageTitle;
@property (nonatomic, strong) MJNIndexView *indexView;// MJNIndexView
@property (weak, nonatomic) IBOutlet UIImageView *bgImgV;
- (IBAction)cancel:(id)sender;

@end
