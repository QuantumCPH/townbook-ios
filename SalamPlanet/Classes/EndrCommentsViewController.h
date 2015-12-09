//
//  EndrCommentsViewController.h
//  SalamPlanet
//
//  Created by Globit on 29/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EndoreCommentViewCell.h"
#import "EndrCommentCell.h"

@interface EndrCommentsViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,EndoreCommentViewCellDelegate,EndrCommentCellDelegate>
@property (strong, nonatomic) IBOutlet UILabel *samplLbl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UITextField *commentTF;
- (IBAction)goBackAction:(id)sender;
- (IBAction)addImageCommentAction:(id)sender;
-(IBAction)insertNewComment:(id)sender;

- (id)initWithEndrDictMain:(NSDictionary*)endrDict ANDEndrUserMain:(NSDictionary *)userMain;
@end
