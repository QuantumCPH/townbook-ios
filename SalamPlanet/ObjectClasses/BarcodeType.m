//
//  BarcodeType.m
//  SalamCenterApp
//
//  Created by Globit on 19/01/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import "BarcodeType.h"

@implementation BarcodeType
@synthesize barcodeID;
@synthesize barcodeImageName;
@synthesize barcodeName;
@synthesize barcodeType;

-(BarcodeType*) initWithID:(NSInteger)ID
{
    self = [super init];
    if(self)
    {
        switch (ID) {
            case 0:
                barcodeID=ID;
                barcodeName=@"Code128";
                barcodeImageName=@"BTCode128";
                barcodeType=@"org.iso.Code128";
                break;
//            case 1:
//                barcodeID=ID;
//                barcodeName=@"Codabar";
//                barcodeImageName=@"BTCodabar";
//                break;
            case 1:
                barcodeID=ID;
                barcodeName=@"Code39";
                barcodeType=@"org.iso.Code39";
                barcodeImageName=@"BTCode39";
                break;
            case 2:
                barcodeID=ID;
                barcodeName=@"Ean13";
                barcodeType=@"org.gs1.EAN-13";
                barcodeImageName=@"BTEan13";
                break;
            case 3:
                barcodeID=ID;
                barcodeName=@"Ean8";
                barcodeType=@"org.gs1.EAN-8";
                barcodeImageName=@"BTEAN8";
                break;
//            case 4:
//                barcodeID=ID;
//                barcodeName=@"Standard 2 of 5";
//                barcodeImageName=@"BTStandard2of5";
//                break;
            case 4:
                barcodeID=ID;
                barcodeName=@"Interleaved 2 of 5";
                barcodeImageName=@"BTInterleaved2of5";
                barcodeType=@"org.ansi.Interleaved2of5";
                break;
            case 5:
                barcodeID=ID;
                barcodeName=@"Code93";
                barcodeImageName=@"BTCode93";
                barcodeType=@"com.intermec.Code93";
                break;
            case 6:
                barcodeID=ID;
                barcodeName=@"QRCode";
                barcodeType=@"org.iso.QRCode";
                barcodeImageName=@"BTQRCode";
                break;
            case 7:
                barcodeID=ID;
                barcodeName=@"DataMatrix";
                barcodeImageName=@"BTDatamatrix";
                barcodeType=@"org.iso.DataMatrix";
                break;
            case 8:
                barcodeID=ID;
                barcodeName=@"Aztec";
                barcodeType=@"org.iso.Aztec";
                barcodeImageName=@"BTAztec";
                break;
            case 9:
                barcodeID=ID;
                barcodeName=@"PDF417";
                barcodeType=@"org.iso.PDF417";
                barcodeImageName=@"BTPDF417";
                break;
                
            default:
                break;
        }
    }
    return self;
}
-(BarcodeType*)initWithBarcodeObj:(Barcode *)barcodeObj{
    self = [super init];
    if(self)
    {
        if ([barcodeObj.getBarcodeType isEqualToString:@"org.iso.Code128"]) {
            barcodeID=0;
            barcodeName=@"Code128";
            barcodeImageName=@"BTCode128";
            barcodeType=@"org.iso.Code128";
        }
        else if ([barcodeObj.getBarcodeType isEqualToString:@"org.iso.Code39"]) {
            barcodeID=1;
            barcodeName=@"Code39";
            barcodeType=@"org.iso.Code39";
            barcodeImageName=@"BTCode39";
        }
        else if ([barcodeObj.getBarcodeType isEqualToString:@"org.gs1.EAN-13"]) {
            barcodeID=2;
            barcodeName=@"Ean13";
            barcodeType=@"org.gs1.EAN-13";
            barcodeImageName=@"BTEan13";
        }
        else if ([barcodeObj.getBarcodeType isEqualToString:@"org.gs1.EAN-8"]){
            barcodeID=3;
            barcodeName=@"Ean8";
            barcodeType=@"org.gs1.EAN-8";
            barcodeImageName=@"BTEAN8";
        }
        else if ([barcodeObj.getBarcodeType isEqualToString:@"org.ansi.Interleaved2of5"]){
            barcodeID=4;
            barcodeName=@"Interleaved 2 of 5";
            barcodeImageName=@"BTInterleaved2of5";
            barcodeType=@"org.ansi.Interleaved2of5";
        }
        else if ([barcodeObj.getBarcodeType isEqualToString:@"com.intermec.Code93"]){                barcodeID=5;
            barcodeName=@"Code93";
            barcodeImageName=@"BTCode93";
            barcodeType=@"com.intermec.Code93";
        }
        else if ([barcodeObj.getBarcodeType isEqualToString:@"org.iso.QRCode"]){
            barcodeID=6;
            barcodeName=@"QRCode";
            barcodeType=@"org.iso.QRCode";
            barcodeImageName=@"BTQRCode";
        }
        else if ([barcodeObj.getBarcodeType isEqualToString:@"org.iso.DataMatrix"]){
            barcodeID=7;
            barcodeName=@"DataMatrix";
            barcodeImageName=@"BTDatamatrix";
            barcodeType=@"org.iso.DataMatrix";
        }
        else if ([barcodeObj.getBarcodeType isEqualToString:@"org.iso.Aztec"]){
            barcodeID=8;
            barcodeName=@"Aztec";
            barcodeType=@"org.iso.Aztec";
            barcodeImageName=@"BTAztec";
        }
        else if ([barcodeObj.getBarcodeType isEqualToString:@"org.iso.PDF417"]){
            barcodeID=9;
            barcodeName=@"PDF417";
            barcodeType=@"org.iso.PDF417";
            barcodeImageName=@"BTPDF417";
        }
    }
    return self;
   
}
@end
