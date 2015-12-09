//
//  EndorsementViewController.h
//  SalamPlanet
//
//  Created by Globit on 26/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EndorsementViewCell.h"

@interface EndorsementViewController : UIViewController<EndorsementCellDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellMainDetail;
@property (weak, nonatomic) IBOutlet UIScrollView *mainPictureScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *mainPicturesPageCntrlr;

- (IBAction)backAction:(id)sender;
- (IBAction)createEndrAction:(id)sender;
@end
