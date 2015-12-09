//
//  NewEndorsementHomeViewController.h
//  SalamPlanet
//
//  Created by Saad Khan on 18/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItemViewBar.h"
//#import "EndorsementCollectionCell.h"
#import "ECollectionCellAll.h"

@interface NewEndorsementHomeViewController : UIViewController<ECollectionCellAllDelegate>
{
 
}
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet MenuItemViewBar *menuFavItemsView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

- (IBAction)segmentChangeAction:(id)sender;
- (IBAction)showSliderAction:(id)sender;
- (IBAction)createEndorsementAction:(id)sender;
@end
