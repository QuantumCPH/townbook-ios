//
//  LanguageCell.h
//  SalamCenterApp
//
//  Created by Waseem Asif on 03/11/2015.
//  Copyright © 2015 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LanguageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblSelectLanguage;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentBarLanguage;
@end
