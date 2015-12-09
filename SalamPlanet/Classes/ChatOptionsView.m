//
//  ChatOptionsView.m
//  SalamPlanet
//
//  Created by Globit on 10/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "ChatOptionsView.h"

@implementation ChatOptionsView
@synthesize delegate;

- (id)init{
    self = [self loadFromNib];
    if (self)
    {
        self.lblCamera.text=NSLocalizedString(@"Camera", nil);
        self.lblContacts.text=NSLocalizedString(@"Contact", nil);
        self.lblGallery.text=NSLocalizedString(@"Gallery", nil);
        self.lblLocations.text=NSLocalizedString(@"Location", nil);
        self.lblOffers.text=NSLocalizedString(@"Offers",nil);
        self.lblShop.text=NSLocalizedString(@"Shop", nil);
    }
    return self;
}
- (id)loadFromNib
{
    NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"ChatOptionsView" owner:nil options:nil];
    return [array objectAtIndex:0];
}
-(void)refreshButtonsView{
    [self.btnCamera setSelected:NO];
    [self.btnContact setSelected:NO];
    [self.btnGallery setSelected:NO];
    [self.btnLocation setSelected:NO];
    [self.btnOffer setSelected:NO];
    [self.btnShop setSelected:NO];
    
    [self.lblCamera setTextColor:[UIColor lightGrayColor]];
    [self.lblContacts setTextColor:[UIColor lightGrayColor]];
    [self.lblGallery setTextColor:[UIColor lightGrayColor]];
    [self.lblLocations setTextColor:[UIColor lightGrayColor]];
    [self.lblOffers setTextColor:[UIColor lightGrayColor]];
    [self.lblShop setTextColor:[UIColor lightGrayColor]];
}
- (IBAction)pictureBtnPressed:(id)sender {
    [self refreshButtonsView];
    [self.btnGallery setSelected:YES];
    [self.lblGallery setTextColor:[UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1]];
    [delegate doActionForPictureBtnPressed];
}
- (IBAction)contactBtnPressed:(id)sender {
    [self refreshButtonsView];
    [self.btnContact setSelected:YES];
    [self.lblContacts setTextColor:[UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1]];
    [delegate doActionForContactBtnPressed];
}
- (IBAction)cameraBtnPressed:(id)sender {
    [self refreshButtonsView];
    [self.btnCamera setSelected:YES];
    [self.lblCamera setTextColor:[UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1]];
    [delegate doActionForCameraBtnPressed];
}
- (IBAction)shopBtnPressed:(id)sender {
    [self refreshButtonsView];
    [self.btnShop setSelected:YES];
    [self.lblShop setTextColor:[UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1]];
    [delegate doActionForShopBtnPressed];
}
- (IBAction)offerBtnPressed:(id)sender {
    [self refreshButtonsView];
    [self.btnOffer setSelected:YES];
    [self.lblOffers setTextColor:[UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1]];
    [delegate doActionForOffersBtnPressed];
}
- (IBAction)locationBtnPressed:(id)sender {
    [self refreshButtonsView];
    [self.btnLocation setSelected:YES];
    [self.lblLocations setTextColor:[UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1]];
    [delegate doActionForLocationBtnPressed];
}
@end
