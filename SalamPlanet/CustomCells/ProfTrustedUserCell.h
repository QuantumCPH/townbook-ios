//
//  ProfTrustedUserCell.h
//  SalamPlanet
//
//  Created by Globit on 19/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OnlineStatusView.h"

@interface ProfTrustedUserCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *usrImgV;
@property (weak, nonatomic) IBOutlet UILabel *usrNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *lblLastActivity;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalEndore;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalTrustedBt;

@property (strong, nonatomic) OnlineStatusView *statusView;

-(void)loadDataWithDummy;
@end
