//
//  NonEContactCell.h
//  SalamPlanet
//
//  Created by Globit on 19/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NonEContactCellDelegate
-(void)inviteTheUserWithCellTag:(NSInteger)tag;
@end

@interface NonEContactCell : UITableViewCell
@property (weak, nonatomic) id <NonEContactCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *userImgV;
@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;
- (IBAction)inviteUser:(id)sender;

@end
