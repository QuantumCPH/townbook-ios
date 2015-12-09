//
//  ParkinMainVC.m
//  SalamCenterApp
//
//  Created by Globit on 30/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import "ParkinMainVC.h"
//#import "CustomAnnotation.h"

#import "JPSThumbnailAnnotation.h"
#import "JPSThumbnailAnnotationView.h"

#import "AppDelegate.h"
//#import "ParkingHelpVC.h"

@interface ParkinMainVC ()
{
    CLLocationCoordinate2D currentLocation;
    AppDelegate * appDelegate;
    JPSThumbnail * thumbAnnotation;
    JPSThumbnailAnnotation *jpsThumbnailAnnotation;
    JPSThumbnailAnnotationView * jpsThumbnailAnnotationView;
    BOOL isSavedParking;
    CLLocationCoordinate2D savedParkingLocation;
    UIImage * savedParkingImage;
    BOOL isNewLocation;
}
@end

@implementation ParkinMainVC
static ParkinMainVC *sharedInstance;
-(id)init{
    if(sharedInstance) {
        // avoid creating more than one instance
        [NSException raise:@"bug" format:@"tried to create more than one instance"];
    }
    self = [super initWithNibName:@"ParkinMainVC" bundle:nil];
    if (self) {
    }
    return self;
}
+ (ParkinMainVC *)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[ParkinMainVC alloc] initWithNibName:@"ParkinMainVC" bundle:nil];
    });
    return sharedInstance;
}
- (void)viewDidLoad {
    appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.bgImgV setImage:[UIImage imageNamed:[appDelegate getBackgroundImageName]]];
    self.lblPageTitle.font=[appDelegate getFontOfPageTitle];
    
    isSavedParking=NO;
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [appDelegate hideBottomTabBar:YES];
    [self.btnBack setSelected:NO];
    currentLocation=[appDelegate getCurrentLocation];
    [self centerizeAndSetTheMap];
    
//    [self.btnAddComment setHidden:isSavedParking];
//    [self.btnAddPhoto setHidden:isSavedParking];
//    [self.btnDetail setHidden:!isSavedParking];
    [self.btnSave setHidden:YES];
//    [self.btnNewLocation setHidden:!isSavedParking];
}
-(void)dolocalizationText{
    self.commentTV.text=NSLocalizedString(@"Add you note here", nil);
    [self.btnParkHere setTitle:NSLocalizedString(@"Park here", nil) forState:UIControlStateNormal];
    [self.btnParkHere setTitle:NSLocalizedString(@"Park here", nil) forState:UIControlStateHighlighted];
    [self.btnParkHere setTitle:NSLocalizedString(@"Park here", nil) forState:UIControlStateSelected];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-Custome Methods
-(void)centerizeAndSetTheMap{
    //        _map = [[MKMapView alloc] init];//CGRectMake(0, 0, 101, 160.0)
    _mapView.userInteractionEnabled = YES;
    //        _mapView.delegate = self;
    _mapView.showsUserLocation=YES;
    MKCoordinateRegion myRegion;
    if (isSavedParking) {
        myRegion.center.latitude = savedParkingLocation.latitude;
        myRegion.center.longitude = savedParkingLocation.longitude;
    }
    else{
        myRegion.center.latitude = currentLocation.latitude;
        myRegion.center.longitude = currentLocation.longitude;
    }
    
    // this sets the zoom level, a smaller value like 0.02
    // zooms in, a larger value like 80.0 zooms out
    myRegion.span.latitudeDelta = 0.04;
    myRegion.span.longitudeDelta = 0.04;
    
    // move the map to our location
    [_mapView setRegion:myRegion animated:NO];
}
#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage =info[UIImagePickerControllerOriginalImage];
    

//    [_mapView removeAnnotations:annotationsToRemove ] ;

    
    if (!savedParkingImage) {
        savedParkingImage=[[UIImage alloc]init];
    }
    savedParkingImage=chosenImage;
    
    if (thumbAnnotation && !isNewLocation) {
        thumbAnnotation.image = chosenImage;
        [_mapView addAnnotation:[JPSThumbnailAnnotation annotationWithThumbnail:thumbAnnotation]];
    }
    
    NSArray * annotationsToRemove = _mapView.annotations;
    for (id obj in annotationsToRemove) {
        if ([obj isKindOfClass:[JPSThumbnailAnnotation class]]) {
            [(JPSThumbnailAnnotation *)obj updateThumbnail:thumbAnnotation animated:YES];
        }
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - MKMap View methods
//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
//    if (annotation == mapView.userLocation)
//        return nil;
//    
//    static NSString *MyPinAnnotationIdentifier = @"Pin";
//    MKPinAnnotationView *pinView =
//    (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:MyPinAnnotationIdentifier];
//    if (!pinView){
//        MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
//                                                                        reuseIdentifier:MyPinAnnotationIdentifier];
//        
//        annotationView.image = [UIImage imageNamed:@"location-icon"];
//        return annotationView;
//        
//    }else{
//        
//        pinView.image = [UIImage imageNamed:@"location-icon"];//pin_map_blue
//        
//        return pinView;
//    }
//    
//    return nil;
//    if ([annotation isKindOfClass:[CustomAnnotation class]]) {
//        CustomAnnotation *myLocation=(CustomAnnotation *)annotation;
//        MKAnnotationView *annotationView=[mapView dequeueReusableAnnotationViewWithIdentifier:@"customAnnotation"];
//        if (annotationView == nil) {
//            annotationView = myLocation.annotationView;
//        }
//        else{
//            annotationView.annotation=annotation;
//        }
//        return annotationView;
//    }
//    return nil;
//}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
//    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
//        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didSelectAnnotationViewInMap:mapView];
//    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
//    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
//        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didDeselectAnnotationViewInMap:mapView];
//    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation conformsToProtocol:@protocol(JPSThumbnailAnnotationProtocol)]) {
        return [((NSObject<JPSThumbnailAnnotationProtocol> *)annotation) annotationViewInMap:mapView];
    }
    return nil;
}
#pragma mark-UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([self.commentTV.text isEqualToString:NSLocalizedString(@"Add you note here", nil)]) {
        self.commentTV.text=@"";
    }
    self.commentTV.textColor=[UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1];
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length==0) {
        self.commentTV.text=NSLocalizedString(@"Add you note here", nil);
        self.commentTV.textColor=[UIColor lightGrayColor];
        [self.commentTV resignFirstResponder];
        self.commentCountLbl.text=[NSString stringWithFormat:@"0/60"];
    }
    else{
        self.commentCountLbl.text=[NSString stringWithFormat:@"%lu/60",(unsigned long)textView.text.length];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@""]) {
        return YES;
    }
    NSUInteger newLength = textView.text.length;
    return (newLength > 59) ? NO : YES;
}
#pragma mark:UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        savedParkingImage=nil;
        isSavedParking=NO;
        isNewLocation=YES;
        savedParkingLocation=currentLocation;
        self.commentTV.text=NSLocalizedString(@"Add you note here", nil);
        NSArray * annotationsToRemove = _mapView.annotations;
        [_mapView removeAnnotations:annotationsToRemove ];
        thumbAnnotation.image=nil;
        thumbAnnotation.title=@"";
        thumbAnnotation.subtitle=@"";
        
        [self.btnParkHere setHidden:NO];
        //    [self.btnAddComment setHidden:isSavedParking];
        //    [self.btnAddPhoto setHidden:isSavedParking];
        //    [self.btnDetail setHidden:!isSavedParking];
        [self.btnSave setHidden:YES];
        //    [self.btnNewLocation setHidden:!isSavedParking];
        
        [self centerizeAndSetTheMap];
    }
}
#pragma mark-IBActions and Selectors
-(void)gotoDirectionMaps{
    NSURL * url;
    url=[NSURL URLWithString:[NSString stringWithFormat:@"http://maps.apple.com/maps?saddr=%f,%f&daddr=%f,%f",currentLocation.latitude,currentLocation.longitude,savedParkingLocation.latitude,savedParkingLocation.longitude]];
    [[UIApplication sharedApplication] openURL:url];
}
- (IBAction)btnBackPressed:(id)sender {
    [self.btnBack setSelected:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnParkHerePressed:(id)sender {
    //annotation
//    CustomAnnotation * customAnnotation=[[CustomAnnotation alloc]initWithTitle:@"My Car" Location:currentLocation];
//    [_mapView addAnnotation:customAnnotation];
    // Empire State Building
    isNewLocation=NO;
    thumbAnnotation = [[JPSThumbnail alloc] init];
    if (savedParkingImage) {
        thumbAnnotation.image=savedParkingImage;
    }
    else{
        thumbAnnotation.image = [UIImage imageNamed:@"OH_map-button-p"];
    }
    thumbAnnotation.title = NSLocalizedString(@"My Car", nil);
    if ([self.commentTV.text isEqualToString:NSLocalizedString(@"Add you note here", nil)]) {
        thumbAnnotation.subtitle =@"";
    }
    else{
        thumbAnnotation.subtitle=self.commentTV.text;
    }
    thumbAnnotation.coordinate = currentLocation;
    __weak typeof(self) weakSelf = self;
    thumbAnnotation.disclosureBlock = ^{ NSLog(@"selected Empire");
//        [weakSelf btnDetailPressed:nil];
        [weakSelf gotoDirectionMaps];
    };
    [_mapView addAnnotation:[JPSThumbnailAnnotation annotationWithThumbnail:thumbAnnotation]];
    savedParkingLocation=currentLocation;
    [self.btnParkHere setHidden:YES];
}

- (IBAction)btnAddPhotoPressed:(id)sender {
    if (savedParkingImage) {
        self.popOverImgV.image=savedParkingImage;
        self.viewPopOver.frame=self.view.frame;
        [self.view addSubview:self.viewPopOver];
        return;
    }
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [imagePickerController.navigationBar setTintColor:[UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1]];
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
    else
    {
        ShowMessage(NSLocalizedString(@"Error", nil),NSLocalizedString(@"Sorry! Camera is not available", nil));
    }
}

- (IBAction)btnCommentViewDonePressed:(id)sender {
    [self.commentTV resignFirstResponder];
    [self.commentPopUpView removeFromSuperview];

    if (thumbAnnotation && !isNewLocation) {
        thumbAnnotation.subtitle=self.commentTV.text;
        [_mapView addAnnotation:[JPSThumbnailAnnotation annotationWithThumbnail:thumbAnnotation]];
    }
    //Update Thumbnail view
    NSArray * annotationsToRemove = _mapView.annotations;
    for (id obj in annotationsToRemove) {
        if ([obj isKindOfClass:[JPSThumbnailAnnotation class]]) {
            [(JPSThumbnailAnnotation *)obj updateThumbnail:thumbAnnotation animated:YES];
        }
    }
}

- (IBAction)btnAddCommentPressed:(id)sender {

    CGRect frame = [UIScreen mainScreen].bounds;
    frame.origin.y=64;
    self.commentPopUpView.frame=frame;
    [self.view addSubview:self.commentPopUpView];
    [self.commentTV becomeFirstResponder];
}

- (IBAction)btnSavePressed:(id)sender {
    if (![self.btnParkHere isHidden]) {
        ShowMessage(kAppName,NSLocalizedString(@"Please drop the pin on map first", nil));
        return;
    }
    isSavedParking=YES;
    ShowMessage(kAppName,NSLocalizedString(@"Car parking has been saved", nil));
//    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnDetailPressed:(id)sender {
//    ParkingHelpVC * parkingDetailVC=[[ParkingHelpVC alloc]initWithParkingDescription:self.commentTV.text ANDParkingPicture:savedParkingImage ANDParkLocation:savedParkingLocation];
//    [self.navigationController pushViewController:parkingDetailVC animated:YES];
}

- (IBAction)btnNewLocationPressed:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppName message:NSLocalizedString(@"Your current saved location will be deleted", nil)
                                                   delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil)  otherButtonTitles:NSLocalizedString(@"Yes", nil),nil];
    
    [alert show];
}

- (IBAction)btnCancelCommentViewPressed:(id)sender {
    self.commentTV.text=NSLocalizedString(@"Add you note here", nil);
    self.commentTV.textColor=[UIColor lightGrayColor];
    [self.commentTV resignFirstResponder];
    self.commentCountLbl.text=[NSString stringWithFormat:@"0/60"];
    [self.commentPopUpView removeFromSuperview];
}
- (IBAction)btnPopOverPressed:(id)sender{
    [self.viewPopOver removeFromSuperview];
}
@end
