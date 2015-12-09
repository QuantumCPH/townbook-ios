//
//  BannerVC.h
//  SalamCenterApp
//
//  Created by Waseem Asif on 30/11/2015.
//  Copyright © 2015 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BannerVC : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, assign) NSInteger indexNumber;
@property (nonatomic,strong) NSString * imageUrl;

@end
