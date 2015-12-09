//
//  WebVC.m
//  SalamPlanet
//
//  Created by Globit on 05/11/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import "WebVC.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"

@interface WebVC ()
{
    NSString * urlString;
    AppDelegate * appDelegate;
}
@end

@implementation WebVC
-(id)initWithUrl:(NSString*)link{
    self = [super initWithNibName:@"WebVC" bundle:nil];
    if (self) {
        urlString=[[NSString alloc]initWithString:link];
        appDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.bgImgV setImage:[UIImage imageNamed:[appDelegate getBackgroundImageName]]];
    self.titleLabel.text = NSLocalizedString(@"Website", nil);
    if (urlString) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
        self.webView.delegate=self;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark:UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    ShowMessage(@"Failure", error.description);
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
}

- (IBAction)backBtnAction:(id)sender {
    [self.backBtn setSelected:YES];    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
