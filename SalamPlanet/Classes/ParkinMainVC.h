//
//  ParkinMainVC.h
//  SalamCenterApp
//
//  Created by Globit on 30/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ParkinMainVC : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *bgImgV;
@property (strong, nonatomic) IBOutlet UILabel *lblPageTitle;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnParkHere;
@property (weak, nonatomic) IBOutlet UITextView *parkingTextV;
@property (weak, nonatomic) IBOutlet UIButton *btnAddPhoto;
@property (strong, nonatomic) IBOutlet UIView *commentPopUpView;
@property (weak, nonatomic) IBOutlet UITextView *commentTV;
@property (weak, nonatomic) IBOutlet UIButton *btnCommentViewDone;
@property (weak, nonatomic) IBOutlet UIButton *btnAddComment;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UIButton *btnDetail;
@property (weak, nonatomic) IBOutlet UIButton *btnNewLocation;
@property (weak, nonatomic) IBOutlet UIButton *btnCancelCommentView;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLbl;

@property (weak, nonatomic) IBOutlet UIImageView *popOverImgV;
@property (weak, nonatomic) IBOutlet UIButton *BtnPopOver;
@property (strong, nonatomic) IBOutlet UIView *viewPopOver;


- (IBAction)btnBackPressed:(id)sender;
- (IBAction)btnParkHerePressed:(id)sender;
- (IBAction)btnAddPhotoPressed:(id)sender;
- (IBAction)btnCommentViewDonePressed:(id)sender;
- (IBAction)btnAddCommentPressed:(id)sender;
- (IBAction)btnSavePressed:(id)sender;
- (IBAction)btnDetailPressed:(id)sender;
- (IBAction)btnNewLocationPressed:(id)sender;
- (IBAction)btnCancelCommentViewPressed:(id)sender;
- (IBAction)btnPopOverPressed:(id)sender;

+ (ParkinMainVC *)sharedInstance;
@end
