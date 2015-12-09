//
//  ChatMessageCell.h
//  SalamPlanet
//
//  Created by Globit on 01/10/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatMessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picImgView;
@property (weak, nonatomic) IBOutlet UIImageView *bubbleImgView;
@property (weak, nonatomic) IBOutlet UITextField *msgTF;

-(void)loadData:(NSString *)msgTxt;
@end
