//
//  EndrUserView.h
//  SalamPlanet
//
//  Created by Globit on 30/10/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EndrUserViewDelegate
-(void)removeThePictureView;
-(void)goToUserProfileViewPressed;
@end

@interface EndrUserView : UIView
@property (weak, nonatomic) id<EndrUserViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *dateLbl;
- (IBAction)gotoProfileBtn:(id)sender;
- (IBAction)closeAction:(id)sender;

-(void)loadViewWith:(UIImage *)img ANDName:(NSString *)name ANDDate:(NSString *)date;
@end
