//
//  ServiceDetailCell.h
//  SalamCenterApp
//
//  Created by Globit on 29/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAService.h"

@protocol ServiceDetailCellDelegate

-(void)serviceDetailCellLocationButtonTappedForService:(MAService *)service;

@end

@interface ServiceDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *serviceNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *serviceFloorLbl;
@property (weak, nonatomic) IBOutlet UILabel *telLbl;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTV;
@property (weak, nonatomic) IBOutlet UILabel *addressHeadingLbl;
@property (weak, nonatomic) IBOutlet UITextView *addressTV;
@property (weak, nonatomic) IBOutlet UIImageView *serviceImage;
@property (strong, nonatomic) IBOutlet UIButton *locationBtn;

@property (weak, nonatomic) id <ServiceDetailCellDelegate> delegate;
@property (strong, nonatomic) MAService *service;

- (IBAction)locationBtnPressed:(id)sender;
- (IBAction)makeCallPressed:(id)sender;

@end
