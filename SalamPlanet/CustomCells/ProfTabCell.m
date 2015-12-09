//
//  ProfTabCell.m
//  SalamPlanet
//
//  Created by Globit on 21/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "ProfTabCell.h"
#import "AppDelegate.h"

@implementation ProfTabCell
@synthesize delegate;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setViewAccordingToTabValue:(ProfileTabSelect)tabSelect{
//    AppDelegate * appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    switch (tabSelect) {
        case DefaultOpt:
            [self.detailBtn setImage:[UIImage imageNamed:@"edetails-icon"] forState:UIControlStateNormal];
            
            [self.endorsementBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            self.endorsementBtn.titleLabel.font=[UIFont fontWithName:@"MyriadPro-Regular" size:14.0];
            
            [self.trustedBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            self.trustedBtn.titleLabel.font=[UIFont fontWithName:@"MyriadPro-Regular" size:14.0];
            
            [self.trustedByBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            self.trustedByBtn.titleLabel.font=[UIFont fontWithName:@"MyriadPro-Regular" size:14.0];
            break;
        case DetailOpt:
            [self.detailBtn setImage:[UIImage imageNamed:@"edetails-icon-p"] forState:UIControlStateNormal];
            [self.endorsementBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            self.endorsementBtn.titleLabel.font=[UIFont fontWithName:@"MyriadPro-Regular" size:14.0];
            
            [self.trustedBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            self.trustedBtn.titleLabel.font=[UIFont fontWithName:@"MyriadPro-Regular" size:14.0];
            
//            [self.trustedByBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [self.trustedByBtn setSelected:NO];
//            self.trustedByBtn.titleLabel.font=[UIFont fontWithName:@"MyriadPro-Regular" size:14.0];
            break;
        case CentersOpt:
            [self.detailBtn setImage:[UIImage imageNamed:@"edetails-icon"] forState:UIControlStateNormal];
            [self.endorsementBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//[appDelegate getTheGeneralColor]
            self.endorsementBtn.titleLabel.font=[UIFont fontWithName:@"MyriadPro-Bold" size:20.0];
            
            [self.trustedBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            self.trustedBtn.titleLabel.font=[UIFont fontWithName:@"MyriadPro-Regular" size:14.0];
            
//            [self.trustedByBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [self.trustedByBtn setSelected:NO];
//            self.trustedByBtn.titleLabel.font=[UIFont fontWithName:@"MyriadPro-Regular" size:14.0];
            break;
        case InterestsOpt:
            [self.detailBtn setImage:[UIImage imageNamed:@"edetails-icon"] forState:UIControlStateNormal];
            [self.endorsementBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            self.endorsementBtn.titleLabel.font=[UIFont fontWithName:@"MyriadPro-Regular" size:14.0];
            
            [self.trustedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.trustedBtn.titleLabel.font=[UIFont fontWithName:@"MyriadPro-Bold" size:20.0];
            
//            [self.trustedByBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [self.trustedByBtn setSelected:NO];
//            self.trustedByBtn.titleLabel.font=[UIFont fontWithName:@"MyriadPro-Regular" size:14.0];
            break;
        case PointsOpt:
            [self.detailBtn setImage:[UIImage imageNamed:@"edetails-icon"] forState:UIControlStateNormal];
            [self.endorsementBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            self.endorsementBtn.titleLabel.font=[UIFont fontWithName:@"MyriadPro-Regular" size:14.0];
            
            [self.trustedBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            self.trustedBtn.titleLabel.font=[UIFont fontWithName:@"MyriadPro-Regular" size:14.0];
            
//            [self.trustedByBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.trustedByBtn setSelected:YES];
//            self.trustedByBtn.titleLabel.font=[UIFont fontWithName:@"MyriadPro-Bold" size:20.0];
            break;
        default:
            break;
    }
}
-(void)loadNumberEndorsementLableWith:(NSInteger)num{
    [self.endorsementBtn setTitle:[NSString stringWithFormat:@"%li",(long)num] forState:UIControlStateNormal];
}
-(void)loadNumberInterestsLableWith:(NSInteger)num{
    [self.trustedBtn setTitle:[NSString stringWithFormat:@"%li",(long)num] forState:UIControlStateNormal];
}
- (IBAction)detailBtnAction:(id)sender{
    [delegate btnDetailProfTabCellPressed];
}
- (IBAction)endorsementBtnAction:(id)sender{
    [delegate btnEndorsementsProfTabCellPressed];
}
- (IBAction)trustedBtnAction:(id)sender{
    [delegate btnTrustedProfTabCellPressed];
}
- (IBAction)trustedByAction:(id)sender{
    [delegate btnTrustedByProfTabCellPressed];
}
@end
