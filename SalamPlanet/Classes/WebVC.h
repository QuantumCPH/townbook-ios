//
//  WebVC.h
//  SalamPlanet
//
//  Created by Globit on 05/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebVC : UIViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *bgImgV;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


- (IBAction)backBtnAction:(id)sender;

-(id)initWithUrl:(NSString*)link;
@end
