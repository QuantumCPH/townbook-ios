//
//  EndrMenuViewController.h
//  SalamPlanet
//
//  Created by Globit on 25/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EndrMenuViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIImageView *bgImgV;
@property (strong, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) IBOutlet UIImageView *centerLogoImgV;
@property (weak, nonatomic) IBOutlet UILabel *lblNoCenter;

-(void)changeTheCenterLogoWithImageName:(NSString *)imageName;
-(void)viewWillAppearOnScreen;
@end
