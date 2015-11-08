//
//  A3WebViewController.m
//  BSBDJ
//
//  Created by mac on 15/11/8.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "A3WebViewController.h"

@interface A3WebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;
@end

@implementation A3WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];

}

- (IBAction)back
{
    [self.webView goBack];
}

- (IBAction)forward
{
    [self.webView goForward];
}

#pragma mark - <UIWebViewDelegate>
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.backItem.enabled = webView.canGoBack;
    self.forwardItem.enabled = webView.canGoForward;
}
@end
