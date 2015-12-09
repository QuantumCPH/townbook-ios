//
//  ChatOptionsView.h
//  SalamPlanet
//
//  Created by Globit on 10/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  ChatOptionsViewDelegate
-(void)doActionForPictureBtnPressed;
-(void)doActionForCameraBtnPressed;
-(void)doActionForContactBtnPressed;
-(void)doActionForShopBtnPressed;
-(void)doActionForOffersBtnPressed;
-(void)doActionForLocationBtnPressed;
@end

@interface ChatOptionsView : UIView
@property (weak,nonatomic)id <ChatOptionsViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *btnCamera;
@property (weak, nonatomic) IBOutlet UIButton *btnGallery;
@property (weak, nonatomic) IBOutlet UIButton *btnContact;
@property (weak, nonatomic) IBOutlet UIButton *btnShop;
@property (weak, nonatomic) IBOutlet UIButton *btnOffer;
@property (weak, nonatomic) IBOutlet UIButton *btnLocation;
@property (strong, nonatomic) IBOutlet UILabel *lblCamera;
@property (strong, nonatomic) IBOutlet UILabel *lblGallery;
@property (strong, nonatomic) IBOutlet UILabel *lblContacts;
@property (strong, nonatomic) IBOutlet UILabel *lblShop;
@property (strong, nonatomic) IBOutlet UILabel *lblOffers;
@property (strong, nonatomic) IBOutlet UILabel *lblLocations;

-(void)refreshButtonsView;

- (IBAction)pictureBtnPressed:(id)sender;
- (IBAction)contactBtnPressed:(id)sender;
- (IBAction)cameraBtnPressed:(id)sender;
- (IBAction)shopBtnPressed:(id)sender;
- (IBAction)offerBtnPressed:(id)sender;
- (IBAction)locationBtnPressed:(id)sender;
@end
