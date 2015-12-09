/*
 PTSMessagingCell.m
 
 Copyright (C) 2012 pontius software GmbH
 
 This program is free software: you can redistribute and/or modify
 it under the terms of the Createive Commons (CC BY-SA 3.0) license
*/

#import "PTSMessagingCell.h"

@implementation PTSMessagingCell

static CGFloat textMarginHorizontal = 17.0f;
static CGFloat textMarginVertical = 7.5f;
static CGFloat messageTextSize = 14.0;
static CGFloat tempOffset =10.0;
static CGFloat tempOffsetBubble=20.0;
static CGFloat statusMarginVrtical=20.0;
static CGFloat minMessageWidth=50;


@synthesize sent, messageView,statusLabel,timeLabel,timeLabelBG, avatarImageView,avatarImageViewOuterFrame, balloonView;
@synthesize messageLabel;
#pragma mark -
#pragma mark Static methods

+(CGFloat)textMarginHorizontal {
    return textMarginHorizontal;
}

+(CGFloat)textMarginVertical {
    return textMarginVertical;
}

+(CGFloat)maxTextWidth {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return 220.0f;
    } else {
        return 400.0f;
    }
}

+(CGSize)messageSize:(NSString*)message {
    CGSize newSize=[message sizeWithFont:[UIFont systemFontOfSize:messageTextSize] constrainedToSize:CGSizeMake([PTSMessagingCell maxTextWidth], CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    newSize.width=MAX(newSize.width, minMessageWidth);
    return newSize;
}

+(UIImage*)balloonImage:(BOOL)sent isSelected:(BOOL)selected {
    if (sent == YES) {
        return [[UIImage imageNamed:@"chat_right"] stretchableImageWithLeftCapWidth:24 topCapHeight:24];
    }
    else{
        UIImage * image=[[UIImage imageNamed:@"chat_left"] stretchableImageWithLeftCapWidth:24 topCapHeight:24];
        return image;
    }
      /*
    if (sent == YES && selected == YES) {
        return [[UIImage imageNamed:@"chat_right"] stretchableImageWithLeftCapWidth:15 topCapHeight:35];
    } else if (sent == YES && selected == NO) {
        return [[UIImage imageNamed:@"chat_right"] stretchableImageWithLeftCapWidth:15 topCapHeight:35];
    } else if (sent == NO && selected == YES) {
        return [[UIImage imageNamed:@"chat_left"] stretchableImageWithLeftCapWidth:15 topCapHeight:35];
    } else {
        return [[UIImage imageNamed:@"chat_left"] stretchableImageWithLeftCapWidth:15 topCapHeight:35];
    }*/
}
+(UIImage*)avatarFrameImage:(BOOL)sent{
    if (sent == YES) {
        return [[UIImage imageNamed:@"pic_frame_right"] stretchableImageWithLeftCapWidth:24 topCapHeight:20];
    } else {
        return [[UIImage imageNamed:@"pic_frame_left"] stretchableImageWithLeftCapWidth:24 topCapHeight:20];
    }
}

#pragma mark -
#pragma mark Object-Lifecycle/Memory management

-(id)initMessagingCellWithReuseIdentifier:(NSString*)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        /*Selection-Style of the TableViewCell will be 'None' as it implements its own selection-style.*/
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        /*Now the basic view-lements are initialized...*/
        messageView = [[UIView alloc] initWithFrame:CGRectZero];
        messageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        
        balloonView = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        messageLabel = [[PPLabel alloc] initWithFrame:CGRectZero];
        statusLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        timeLabelBG=[[UIImageView alloc]initWithImage:nil];
        avatarImageView = [[UIImageView alloc] initWithImage:nil];
        avatarImageViewOuterFrame=[[UIImageView alloc]initWithImage:nil];
       
        /*Message-Label*/
        self.messageLabel.backgroundColor = [UIColor clearColor];
        self.messageLabel.font = [UIFont systemFontOfSize:messageTextSize];
        self.messageLabel.textColor=[UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1.0];
        self.messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.messageLabel.numberOfLines = 0;
        self.messageLabel.userInteractionEnabled=YES;
        
        /*Status-Label*/
        self.statusLabel.backgroundColor=[UIColor clearColor];
        self.statusLabel.font = [UIFont italicSystemFontOfSize:9.0f];
        self.statusLabel.textColor = [UIColor darkGrayColor];
        
        /*Time-Label*/
        self.timeLabel.font = [UIFont boldSystemFontOfSize:9.0f];
        self.timeLabel.textColor = [UIColor whiteColor];
        self.timeLabel.backgroundColor = [UIColor clearColor];
        
        /*...and adds them to the view.*/
        [self.messageView addSubview: self.balloonView];
        [self.messageView addSubview: self.messageLabel];
        [self.messageView addSubview:self.statusLabel];
        
        [self.contentView addSubview: self.timeLabelBG];
        [self.contentView addSubview: self.timeLabel];
        [self.contentView addSubview: self.messageView];
        [self.contentView addSubview: self.avatarImageView];
        [self.contentView addSubview: self.avatarImageViewOuterFrame];
//        [self.contentView addSubview:self.statusLabel];
        
        /*...and a gesture-recognizer, for LongPressure is added to the view.*/
        UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        [recognizer setMinimumPressDuration:1.0f];
        [self addGestureRecognizer:recognizer];
        [self.messageView bringSubviewToFront:self.superview];
        self.messageLabel.delegate = self;
    }
    return self;
}


#pragma mark -
#pragma mark Layouting

- (void)layoutSubviews {
    /*This method layouts the TableViewCell. It calculates the frame for the different subviews, to set the layout according to size and orientation.*/
    
    /*Calculates the size of the message. */
    CGSize textSize = [PTSMessagingCell messageSize:self.messageLabel.text];
    
    /*Calculates the size of the timestamp.*/
    CGSize dateSize = [self.timeLabel.text sizeWithFont:self.timeLabel.font forWidth:[PTSMessagingCell maxTextWidth] lineBreakMode:NSLineBreakByClipping];
    
    /*Initializes the different frames , that need to be calculated.*/
    CGRect ballonViewFrame = CGRectZero;
    CGRect messageLabelFrame = CGRectZero;
    CGRect statusLabelFrame =  CGRectZero;
    CGRect timeLabelFrame = CGRectZero;
    CGRect timeLabelBGFrame=CGRectZero;
    CGRect avatarImageFrame = CGRectZero;
    CGRect avatarImageOuterFrameFrame=CGRectZero;
       
    if (self.sent == YES) {
        
        avatarImageOuterFrameFrame=CGRectMake(self.frame.size.width - 42.0-tempOffset, textMarginVertical, 42.0, 42.0);
        
        avatarImageFrame = CGRectMake(avatarImageOuterFrameFrame.origin.x+1, avatarImageOuterFrameFrame.origin.y+1, 40.0, 40.0);

        ballonViewFrame = CGRectMake(self.frame.size.width - (textSize.width + 2*textMarginHorizontal)-avatarImageOuterFrameFrame.size.width-tempOffsetBubble, textMarginVertical, textSize.width + 2*textMarginHorizontal, textSize.height + 2*textMarginVertical+statusMarginVrtical);
        
        statusLabelFrame = CGRectMake(ballonViewFrame.origin.x+10,ballonViewFrame.origin.y+ballonViewFrame.size.height-15 , 50, 10);//Saad
        
        messageLabelFrame = CGRectMake(self.frame.size.width - (textSize.width + textMarginHorizontal)-avatarImageOuterFrameFrame.size.width-tempOffsetBubble-5,  ballonViewFrame.origin.y + textMarginVertical, textSize.width, textSize.height);
        
        timeLabelFrame = CGRectMake(ballonViewFrame.origin.x+tempOffsetBubble, ballonViewFrame.size.height+5+textMarginVertical, dateSize.width, dateSize.height);
        timeLabelBGFrame=CGRectMake(timeLabelFrame.origin.x-12, timeLabelFrame.origin.y-1, 44.0, 13.0);

    } else {
        avatarImageOuterFrameFrame=CGRectMake(tempOffset, textMarginVertical, 42.0, 42.0);
        
        avatarImageFrame = CGRectMake(avatarImageOuterFrameFrame.origin.x+1,avatarImageOuterFrameFrame.origin.y+1, 40.0f, 40.0f);
        
        ballonViewFrame = CGRectMake(avatarImageFrame.size.width+tempOffsetBubble, textMarginVertical, textSize.width + 2*textMarginHorizontal, textSize.height + 2*textMarginVertical+statusMarginVrtical);

        statusLabelFrame = CGRectMake(ballonViewFrame.origin.x+ballonViewFrame.size.width-60,ballonViewFrame.origin.y+ballonViewFrame.size.height-15 , 50, 10);//Saad
        
        messageLabelFrame = CGRectMake(avatarImageFrame.size.width+textMarginHorizontal+tempOffsetBubble+5, ballonViewFrame.origin.y + textMarginVertical, textSize.width, textSize.height);
        
        timeLabelFrame = CGRectMake(ballonViewFrame.origin.x+ballonViewFrame.size.width-44,ballonViewFrame.size.height+5+textMarginVertical, dateSize.width, dateSize.height);
        timeLabelBGFrame=CGRectMake(timeLabelFrame.origin.x-12,timeLabelFrame.origin.y-1, 44.0, 13.0);
    }
    
    self.balloonView.image = [PTSMessagingCell balloonImage:self.sent isSelected:self.selected];
    
    self.avatarImageViewOuterFrame.image=[PTSMessagingCell avatarFrameImage:self.sent];
    self.avatarImageViewOuterFrame.frame=avatarImageOuterFrameFrame;
    /*Sets the pre-initialized frames  for the balloonView and messageView.*/
    self.balloonView.frame = ballonViewFrame;
    self.messageLabel.frame = messageLabelFrame;
    
    //Status Labels
    if (self.sent == YES) {
        self.statusLabel.textAlignment=NSTextAlignmentLeft;
    }
    else{
        self.statusLabel.textAlignment=NSTextAlignmentRight;
    }
    self.statusLabel.frame = statusLabelFrame;
    
    /*If shown (and loaded), sets the frame for the avatarImageView*/
    if (self.avatarImageView.image != nil) {
        self.avatarImageView.frame = avatarImageFrame;
        [UtilsFunctions makeUIImageViewRound:avatarImageView ANDRadius:20];
    }
    /*If there is next for the timeLabel, sets the frame of the timeLabel.*/
    
    if (self.timeLabel.text != nil) {
        self.timeLabel.frame = timeLabelFrame;
        self.timeLabelBG.image=[UIImage imageNamed:@"time"];
        self.timeLabelBG.frame=timeLabelBGFrame;
    }
    
    //For highlighting the links for PPLabel By Saad
    
    NSError *error = NULL;
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:&error];
    
    self.matches = [detector matchesInString:self.messageLabel.text options:0 range:NSMakeRange(0, self.messageLabel.text.length)];
    
    [self highlightLinksWithIndex:NSNotFound];
    ///
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//	/*Selecting a UIMessagingCell will cause its subviews to be re-layouted. This process will not be animated! So handing animated = YES to this method will do nothing.*/
//    [super setSelected:selected animated:NO];
//    
//    [self setNeedsLayout];
//    
//    /*Furthermore, the cell becomes first responder when selected.*/
//    if (selected == YES) {
//        [self becomeFirstResponder];
//    } else {
//        [self resignFirstResponder];
//    }
//}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {

}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
	
}
//It will be called  when any touch on the cell will be occured
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if (CGRectContainsPoint([self.messageLabel frame], [touch locationInView:self])){
        //do whatever you want
        NSInteger charIndex=[UtilsFunctions getIndexOfCharTappedWith:touch ANDInTheLabel:self.messageLabel];
        [self checkAndOpenTheURLIfFoundWithCharIndex:charIndex];
    }
}
#pragma mark -
#pragma mark UIGestureRecognizer-Handling

- (void)handleLongPress:(UILongPressGestureRecognizer *)longPressRecognizer {
    /*When a LongPress is recognized, the copy-menu will be displayed.*/
    if (longPressRecognizer.state != UIGestureRecognizerStateBegan) {
        return;
    }
    
    if ([self becomeFirstResponder] == NO) {
        return;
    }
    
    UIMenuController * menu = [UIMenuController sharedMenuController];
    [menu setTargetRect:self.balloonView.frame inView:self];
    
    [menu setMenuVisible:YES animated:YES];
}

-(BOOL)canBecomeFirstResponder {
    /*This cell can become first-responder*/
    return YES;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    /*Allows the copy-Action on this cell.*/
    if (action == @selector(copy:)) {
        return YES;
    } else {
        return [super canPerformAction:action withSender:sender];
    }
}

-(void)copy:(id)sender {
    /**Copys the messageString to the clipboard.*/
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:self.messageLabel.text];
}
#pragma mark - PPlabel

- (BOOL)isIndex:(CFIndex)index inRange:(NSRange)range {
    return index > range.location && index < range.location+range.length;
}

- (void)highlightLinksWithIndex:(CFIndex)index {
    
    NSMutableAttributedString* attributedString = [self.messageLabel.attributedText mutableCopy];
    
    for (NSTextCheckingResult *match in self.matches) {
        
        if ([match resultType] == NSTextCheckingTypeLink) {
            
            NSRange matchRange = [match range];
            
            if ([self isIndex:index inRange:matchRange]) {
                [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:matchRange];
            }
            else {
                [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:matchRange];
            }
            
            [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:matchRange];
        }
    }
    
    self.messageLabel.attributedText = attributedString;
}
-(void)checkAndOpenTheURLIfFoundWithCharIndex:(NSInteger)charIndex{
    [self highlightLinksWithIndex:NSNotFound];
    
    for (NSTextCheckingResult *match in self.matches) {
        
        if ([match resultType] == NSTextCheckingTypeLink) {
            
            NSRange matchRange = [match range];
            
            if ([self isIndex:charIndex inRange:matchRange]) {
                
                [[UIApplication sharedApplication] openURL:match.URL];
                break;
            }
        }
    }
}
@end


