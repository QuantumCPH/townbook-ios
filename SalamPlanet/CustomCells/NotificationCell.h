//
//  NotificationCell.h
//  SalamCenterApp
//
//  Created by Waseem Asif on 04/11/2015.
//  Copyright © 2015 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UISwitch *notificationSwtch;

@end
