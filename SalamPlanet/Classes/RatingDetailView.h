//
//  RatingDetailView.h
//  SalamPlanet
//
//  Created by Globit on 06/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RatingDetailView : UIView

@property (weak, nonatomic) IBOutlet UILabel *excellentLbl;
@property (weak, nonatomic) IBOutlet UILabel *goodLbl;
@property (weak, nonatomic) IBOutlet UILabel *avgLbl;
@property (weak, nonatomic) IBOutlet UILabel *poorLbl;
@property (weak, nonatomic) IBOutlet UILabel *terribleLbl;
@property (weak, nonatomic) IBOutlet UILabel *excellentCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *goodCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *avgCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *poorCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *terribleCountLbl;

@end
