//
//  EDetailActionCell.h
//  SalamPlanet
//
//  Created by Globit on 28/10/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EDetailActionCellDelegate
-(void)buttonDetailPressed;
-(void)buttonCheckinPressed;
-(void)buttonSharePressed;
-(void)buttonOffersPressed;
@end

@interface EDetailActionCell : UITableViewCell
@property (weak, nonatomic) id<EDetailActionCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *btnDetail;
@property (weak, nonatomic) IBOutlet UIButton *btnDirection;
@property (weak, nonatomic) IBOutlet UIButton *btnShare;
@property (weak, nonatomic) IBOutlet UIButton *btnOffers;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImg;
@property (weak, nonatomic) IBOutlet UILabel *lblDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblDirection;
@property (weak, nonatomic) IBOutlet UILabel *lblShare;
@property (weak, nonatomic) IBOutlet UILabel *lblOffers;


-(void)setButtonViewsAccordingToOptionisPlace:(BOOL)isPlace;
- (IBAction)btnDetailAction:(id)sender;
- (IBAction)btnDirectionAction:(id)sender;
- (IBAction)btnShareAction:(id)sender;
- (IBAction)btnOffersPressed:(id)sender;

@end
