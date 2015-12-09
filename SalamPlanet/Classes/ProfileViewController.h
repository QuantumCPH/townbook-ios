//
//  ProfileViewController.h
//  SalamCenterApp
//
//  Created by Waseem Asif on 02/11/2015.
//  Copyright © 2015 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+MHFacebookImageViewer.h"
@interface ProfileViewController : UIViewController
@property (nonatomic,strong) UIImage *profileImage;
@property (nonatomic) BOOL isPopedFromEditProfile;
@end
