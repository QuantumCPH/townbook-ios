//
//  AddressLocationCell.h
//  TGFoursquareLocationDetail-Demo
//
//  Created by Thibault Guégan on 17/12/2013.
//  Copyright (c) 2013 Thibault Guégan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "UIUnderlinedButton.h"

@protocol AddressLocationCellDelegate
-(void)phoneNumberPressedForCallOnNumber:(NSString *)number;
-(void)addressPressedToShowMap;
-(void)goToWebsitePressedToOpenWebsite;
@end
@interface AddressLocationCell : UITableViewCell

+ (AddressLocationCell*) addressLocationDetailCell;
@property (weak, nonatomic) IBOutlet UITextView *addressTV;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;

@property (weak, nonatomic) IBOutlet UIView *mapContainerView;

@property (weak, nonatomic) id<AddressLocationCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
@property (weak, nonatomic) IBOutlet UIUnderlinedButton *websiteBtn;
@property (weak, nonatomic) IBOutlet UIUnderlinedButton *directionBtn;
- (IBAction)getDirectionBtnAction:(id)sender;
- (IBAction)websiteBtnPressed:(id)sender;
- (IBAction)phoneBtnPressed:(id)sender;
-(void)setFontsOfItemsInView;

@end

