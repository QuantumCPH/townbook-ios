//
//  OfferMsgCell.h
//  SalamCenterApp
//
//  Created by Globit on 29/12/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfferMsgCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *offerImgView;
@property (weak, nonatomic) IBOutlet UILabel *offerNameLb;
@property (weak, nonatomic) IBOutlet UILabel *offerCenterLbl;
@property (weak, nonatomic) IBOutlet UILabel *offerMsgTimeLbl;
@property (weak, nonatomic) IBOutlet UITextView *offerTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *offerSenderInfoLbl;


@end
