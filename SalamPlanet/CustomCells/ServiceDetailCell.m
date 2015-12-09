//
//  ServiceDetailCell.m
//  SalamCenterApp
//
//  Created by Globit on 29/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "ServiceDetailCell.h"
#import "UIImageView+WebCache.h"
#import "BDVCountryNameAndCode.h"
#import "DataManager.h"
#import "MallCenter.h"

@implementation ServiceDetailCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    UIBezierPath *maskPath;
    CGRect imageRect = self.serviceImage.bounds;
    imageRect.size.width+= 50;//50 is for correcting error in iphone 6 and iphone 6+
    maskPath = [UIBezierPath bezierPathWithRoundedRect:imageRect
                                     byRoundingCorners:(UIRectCornerTopRight | UIRectCornerTopLeft)
                                           cornerRadii:CGSizeMake(3.0, 3.0)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.serviceImage.layer.mask = maskLayer;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setService:(MAService *)service
{
    _service = service;
    [self configureCell];
}
- (void)configureCell
{
    [_serviceImage setImageWithURL:[NSURL URLWithString:_service.imageURL] placeholderImage:[UIImage imageNamed:@"place-holder"]];
    _serviceNameLbl.text = _service.name;
    _serviceFloorLbl.text= _service.floor;
    _telLbl.text = _service.phone;
//    if (_service.phone)
//        _telLbl.text = [self getFormattedPhoneNumber:_service.phone];
    _descriptionTV.text = _service.briefText;
    _addressTV.text = _service.address ? _service.address :@"";
    if (!_service.siteMapURL)
        self.locationBtn.hidden = YES;
}
-(NSString*)getFormattedPhoneNumber:(NSString*)num
{
    NSString * number = num;
    NSString * country = [[[DataManager sharedInstance] currentMall] country];
    BDVCountryNameAndCode * bdvNameAndCode = [[BDVCountryNameAndCode alloc] init];
    NSNumber *prefix =  [bdvNameAndCode getPrefixFromCountryShortName:country];
    
    if (prefix) {
        NSString * formatterPrefix = @"+";
        formatterPrefix = [formatterPrefix stringByAppendingString:prefix.stringValue];
        if (![num hasPrefix:formatterPrefix]) {
            number = [NSString stringWithFormat:@"%@ %@",formatterPrefix,num];
        }
    }
    return number;
}

- (IBAction)locationBtnPressed:(id)sender {

    if (self.delegate)
    {
        [self.delegate serviceDetailCellLocationButtonTappedForService:_service];
    }
}

- (IBAction)makeCallPressed:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:self.serviceNameLbl.text message:[NSString stringWithFormat:@"Call %@",self.telLbl.text]
                                                   delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Call",nil];
    
    [alert show];
}
#pragma mark:UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        [self makeCallFromPhoneWithNumber:self.telLbl.text];
    }
}

-(void)makeCallFromPhoneWithNumber:(NSString *)phNo{
    NSString *urlString = [NSString stringWithFormat:@"tel:%@",phNo];
    NSString *escaped = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:escaped]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:escaped]];
    } else
    {
        ShowMessage(kAppName,NSLocalizedString(@"Call facility is not available!!!", nil));
    }
}
@end
