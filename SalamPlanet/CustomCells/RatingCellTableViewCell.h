//
//  RatingCellTableViewCell.h
//  SalamPlanet
//
//  Created by Globit on 23/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDStarRating.h"

@interface RatingCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet EDStarRating *ratingView;

@end
