//
//  ShopOfferView.m
//  SalamPlanet
//
//  Created by Globit on 06/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "ShopOfferView.h"
#import "UIImageView+WebCache.h"

@implementation ShopOfferView

- (id)init{
    self = [self loadFromNib];
    if (self)
    {
        [self setFontsOfItemsInView];
    }
    return self;
}
- (IBAction)offerHasBeenTapped:(id)sender {
    [self.delegate shopOfferHasBeenTappedWithOffer:self.offer];
}

- (id)initWithOffer:(Offer*)offer
{
    self = [self loadFromNib];
    if (self)
    {
        [self setFontsOfItemsInView];
        self.offer = offer;
        [self setViewWithOffer];
    }
    return self;

}
-(void)setViewWithOffer
{
    [self.imgOffer setImageWithURL:[NSURL URLWithString:self.offer.imageURL] placeholderImage:[UIImage imageNamed:@"place-holder"]];
    self.lblOfferTitle.text = self.offer.title;
    self.lblOfferPercentOff.text = self.offer.detailText;
}

- (id)initWithOfferObj:(OfferObject *)offerObj{
    self = [self loadFromNib];
    if (self)
    {
        [self setFontsOfItemsInView];
        self.offerObject=offerObj;
        [self setViewWithOfferObject];
    }
    return self;
}

- (id)loadFromNib
{
    NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"ShopOfferView" owner:nil options:nil];
    return [array objectAtIndex:0];
}
-(void)setViewWithOfferObject{
    self.imgOffer.image=[UIImage imageNamed:self.offerObject.offerImgName];
    self.lblOfferTitle.text=self.offerObject.offerTitle;
    self.lblOfferPercentOff.text=[NSString stringWithFormat:@"%li%% off",(long)self.offerObject.offerOffPercent];
}
-(void)setFontsOfItemsInView{
//    [self.excellentLbl setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:13.0f]];
    [self.lblOfferTitle setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:10.0]];
    [self.lblOfferPercentOff setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:12.0]];
    
}
@end
