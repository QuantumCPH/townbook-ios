//
//  EDetailActionCell.m
//  SalamPlanet
//
//  Created by Globit on 28/10/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "EDetailActionCell.h"

@implementation EDetailActionCell
{
    DetailTabOptions tabOption;
}
@synthesize delegate;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setButtonViewsAccordingToOptionisPlace:(BOOL)isPlace{
    float btnWidth;
    float btnHeight=38.0;

    btnWidth=320.0/4;

    self.btnDetail.frame=CGRectMake(0, 0, btnWidth,btnHeight);
    self.lblDetail.frame=CGRectMake(0, btnHeight-27, btnWidth,btnHeight);
        
    self.btnDirection.frame=CGRectMake(btnWidth, 0, btnWidth, btnHeight);
    self.lblDirection.frame=CGRectMake(btnWidth, btnHeight-27, btnWidth, btnHeight);
        
    self.btnShare.frame=CGRectMake(2*btnWidth, 0, btnWidth, btnHeight);
    self.lblShare.frame=CGRectMake(2*btnWidth, btnHeight-27, btnWidth, btnHeight);
    
    self.btnOffers.frame=CGRectMake(3*btnWidth, 0, btnWidth, btnHeight);
    self.lblOffers.frame=CGRectMake(3*btnWidth, btnHeight-27, btnWidth, btnHeight);
        
    [self.contentView addSubview:self.btnDetail];
    [self.contentView addSubview:self.lblDetail];
    [self.contentView addSubview:self.btnDirection];
    [self.contentView addSubview:self.lblDirection];
    [self.contentView addSubview:self.btnShare];
    [self.contentView addSubview:self.lblShare];
    [self.contentView addSubview:self.btnOffers];
    [self.contentView addSubview:self.lblOffers];
    
    self.backgroundImg.image=[UIImage imageNamed:@"elower-bar-icons-image"];
    
    [self.btnDetail setSelected:YES];
}
-(void)updateView{
    switch (tabOption) {
        case ShowDetailOpt:
                        break;
        case ShowDirectionOpt:
            [self.btnDetail setSelected:NO];
            [self.btnDirection setSelected:YES];
            [self.btnShare setSelected:NO];
        case ShowShareOpt:
            [self.btnDetail setSelected:NO];
            [self.btnDirection setSelected:NO];
            [self.btnShare setSelected:YES];
        default:
            break;
    }
}
- (IBAction)btnDetailAction:(id)sender{
    tabOption=ShowDetailOpt;
    [self.btnDetail setSelected:YES];
    [self.btnDirection setSelected:NO];
    [self.btnShare setSelected:NO];
    [self.btnOffers setSelected:NO];
    
    [delegate buttonDetailPressed];
}
- (IBAction)btnDirectionAction:(id)sender{
    if (self.btnDirection.selected) {
        [self.btnDetail setSelected:YES];
    }
    else{
        [self.btnDetail setSelected:NO];
    }
    [self.btnDirection setSelected:!self.btnDirection.selected];
    [self.btnShare setSelected:NO];
    [self.btnOffers setSelected:NO];
    [delegate buttonCheckinPressed];
}
- (IBAction)btnShareAction:(id)sender{
    if (self.btnShare.selected) {
        [self.btnDetail setSelected:YES];
    }
    else{
        [self.btnDetail setSelected:NO];
    }
    [self.btnShare setSelected:!self.btnShare.selected];
    [self.btnDirection setSelected:NO];
    [self.btnOffers setSelected:NO];
    [delegate buttonSharePressed];
}

- (IBAction)btnOffersPressed:(id)sender {
    if (self.btnOffers.selected) {
        [self.btnDetail setSelected:YES];
    }
    else{
        [self.btnDetail setSelected:NO];
    }
    [self.btnOffers setSelected:!self.btnOffers.selected];
    [self.btnDirection setSelected:NO];
    [self.btnShare setSelected:NO];
    [delegate buttonOffersPressed];
}
@end
