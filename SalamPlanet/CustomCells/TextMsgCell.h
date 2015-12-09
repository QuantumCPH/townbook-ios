//
//  TextMsgCell.h
//  SalamPlanet
//
//  Created by Globit on 10/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPLabel.h"
@interface TextMsgCell : UITableViewCell

@property (nonatomic, strong) PPLabel * messageLabel;
@property (nonatomic, readonly) UILabel * timeLabel;
@property (nonatomic, readonly) UIImageView * avatarImageView;
@property (nonatomic, readonly) UIImageView * balloonView;
@property (assign) BOOL sent;
@property(nonatomic, strong) NSArray* matches;//Saad

/**Returns the text margin in horizontal direction.
 @return CGFloat containing the horizontal text margin.
 */
+(CGFloat)textMarginHorizontal;

/**Returns the text margin in vertical direction.
 @return CGFloat containing the vertical text margin.
 */
+(CGFloat)textMarginVertical;

/** Returns the maximum width for a single message. The size depends on the UIInterfaceIdeom (iPhone/iPad). FOR CUSTOMIZATION: To edit the maximum width, edit this method.
 @return CGFloat containing the maximal width.
 */
+(CGFloat)maxTextWidth;

/** Calculates and returns the size of a frame containing the message, that is given as a parameter.
 @param message NSString containing the message string.
 @return CGSize containing the size of the message (w/h).
 */
+(CGSize)messageSize:(NSString*)message;

/**  Returns the ballon-Image for specified conditions.
 @param sent Indicates, wheather the message has been sent or received.
 @param selected Indicates, wheather the cell has been selected.
 FOR CUSTOMIZATION: To edit the image, user your own names in this method.
 */
+(UIImage*)balloonImage:(BOOL)sent isSelected:(BOOL)selected;

/**Initializes the PTSMessagingCell.
 @param reuseIdentifier NSString* containing a reuse Identifier.
 @return Instanze of the initialized PTSMessagingCell.
 */
-(id)initMessagingCellWithReuseIdentifier:(NSString*)reuseIdentifier;
@end
