//
//  ChatMessageCell.m
//  SalamPlanet
//
//  Created by Globit on 01/10/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "ChatMessageCell.h"
#import "UtilsFunctions.h"

#define kGreenLeftCapWidth  14
#define kTopCapHeight    15

@implementation ChatMessageCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}
-(CGSize)calculateSizeForText:(NSString *)txt{
    
    CGSize maximumLabelSize = CGSizeMake(236, 180);
    CGSize expectedSectionSize = [txt sizeWithFont:self.msgTF.font
                                 constrainedToSize:maximumLabelSize
                                     lineBreakMode:NSLineBreakByTruncatingTail];
    return expectedSectionSize;
}
-(void)loadData:(NSString *)msgTxt{
    
    
    CGSize txtSize=[self calculateSizeForText:msgTxt];
    CGRect frame=self.msgTF.frame;
    frame.size=txtSize;
    self.msgTF.frame=frame;
    
    CGSize bubbleSize;
    bubbleSize.height=txtSize.height+14;
    bubbleSize.width=txtSize.width+12;
    frame=self.bubbleImgView.frame;
    frame.size=bubbleSize;
    self.bubbleImgView.frame=frame;
    
    self.bubbleImgView.image=[[UIImage imageNamed:@"chat_left.png"] stretchableImageWithLeftCapWidth:kGreenLeftCapWidth
                                                                                        topCapHeight:kTopCapHeight];
    self.msgTF.text=msgTxt;
    
    self.picImgView.image=[UIImage imageNamed:@"imranKhan.jpg"];
    [UtilsFunctions makeUIImageViewRound:self.picImgView ANDRadius:self.picImgView.frame.size.width/2];
}
//248,44
//236,30
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
