//
//  AddressLocationCell.m
//  TGFoursquareLocationDetail-Demo
//
//  Created by  Guégan on 17/12/2013.
//  Copyright (c) 2013 Thibault Guégan. All rights reserved.
//

#import "AddressLocationCell.h"

@implementation AddressLocationCell
@synthesize delegate;

+ (AddressLocationCell*) addressLocationDetailCell
{
    AddressLocationCell * cell = [[[NSBundle mainBundle] loadNibNamed:@"AddressLocationCell" owner:self options:nil] objectAtIndex:0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    
}
-(void)setFontsOfItemsInView{
    [self.addressTV setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:13.0f]];
    [self.phoneBtn.titleLabel setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:13.0f]];
    [self.websiteBtn.titleLabel setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:12.0f]];
    [self.directionBtn.titleLabel setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:12.0f]];
    [self.priceLbl setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:13.0f]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)getDirectionBtnAction:(id)sender {
    [delegate addressPressedToShowMap];
}

- (IBAction)websiteBtnPressed:(id)sender {
//     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.google.com"]];
    [delegate goToWebsitePressedToOpenWebsite];
}

- (IBAction)phoneBtnPressed:(id)sender {
    [delegate phoneNumberPressedForCallOnNumber:@"042376889237"];
//    [self.phoneBtn setSelected:YES];
}
@end
