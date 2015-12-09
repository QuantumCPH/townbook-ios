//
//  PTSImageCell.h
//  SalamPlanet
//
//  Created by Globit on 13/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTSImageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImgView;
@property (weak, nonatomic) IBOutlet UIImageView *sharedImgView;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UIImageView *bubleImgView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end
