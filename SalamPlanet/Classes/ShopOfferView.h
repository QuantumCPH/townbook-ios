//
//  ShopOfferView.h
//  SalamPlanet
//
//  Created by Globit on 06/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OfferObject.h"
#import "Offer.h"
#import "Activity.h"

@protocol ShopOfferViewDelegate
-(void)shopOfferHasBeenTappedWithOffer:(Offer*)offer;
@end

@interface ShopOfferView : UIView
{
}
@property (weak, nonatomic) id<ShopOfferViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *imgOffer;
@property (weak, nonatomic) IBOutlet UILabel *lblOfferTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblOfferPercentOff;
@property (strong, nonatomic)OfferObject * offerObject;
@property (strong, nonatomic)Offer * offer;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

- (IBAction)offerHasBeenTapped:(id)sender;
- (id)initWithOfferObj:(OfferObject *)offerObj;
- (id)initWithOffer:(Offer*)offer;
@end
