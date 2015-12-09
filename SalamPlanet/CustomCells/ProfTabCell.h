//
//  ProfTabCell.h
//  SalamPlanet
//
//  Created by Globit on 21/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProfTabCellDelegate
-(void)btnDetailProfTabCellPressed;
-(void)btnEndorsementsProfTabCellPressed;
-(void)btnTrustedProfTabCellPressed;
-(void)btnTrustedByProfTabCellPressed;
@end

@interface ProfTabCell : UITableViewCell
@property(weak,nonatomic)id <ProfTabCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (weak, nonatomic) IBOutlet UILabel *lblDetail;
@property (weak, nonatomic) IBOutlet UIButton *endorsementBtn;
@property (weak, nonatomic) IBOutlet UILabel *lblCenters;
@property (weak, nonatomic) IBOutlet UIButton *trustedBtn;
@property (weak, nonatomic) IBOutlet UIButton *trustedByBtn;
@property (weak, nonatomic) IBOutlet UILabel *lblInterest;
@property (weak, nonatomic) IBOutlet UILabel *lblSettings;


- (IBAction)detailBtnAction:(id)sender;
- (IBAction)endorsementBtnAction:(id)sender;
- (IBAction)trustedBtnAction:(id)sender;
- (IBAction)trustedByAction:(id)sender;

-(void)loadNumberInterestsLableWith:(NSInteger)num;
-(void)setViewAccordingToTabValue:(ProfileTabSelect)tabSelect;
-(void)loadNumberEndorsementLableWith:(NSInteger)num;
@end
