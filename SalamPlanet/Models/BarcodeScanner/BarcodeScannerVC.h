//
//  BarcodeScannerVC.h
//  iOS7_BarcodeScanner
//
//  Created by Jake Widmer on 11/16/13.
//  Copyright (c) 2013 Jake Widmer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Barcode.h"

@protocol BarcodeScannerVCDelegate
-(void)addBarcodeWithNumber:(Barcode *)barCodeObj;
@end

@interface BarcodeScannerVC : UIViewController<UIAlertViewDelegate>
@property (weak, nonatomic) id<BarcodeScannerVCDelegate> delegate;
@property (strong, nonatomic) NSMutableArray * allowedBarcodeTypes;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (strong, nonatomic)Barcode * barCodeScanned;

- (IBAction)backBtnPressed:(id)sender;
@end
