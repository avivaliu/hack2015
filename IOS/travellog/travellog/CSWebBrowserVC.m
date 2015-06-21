//
//  CSWebBrowserVC.m
//  Testing
//
//  Created by Cullen Sun on 10/10/13.
//  Copyright (c) 2013 my.company. All rights reserved.
//

#import "CSWebBrowserVC.h"

@interface CSWebBrowserVC ()

@property (nonatomic) BOOL initialLoaded;

@end

@implementation CSWebBrowserVC

- (id)initWith:(NSURL *)url andTitle:(NSString*)title {
    self = [super init];
    if (self) {
        self.title = title;
        self.url = url;
    }
    
    return self;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.webView = [[UIWebView alloc] init];
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    [self.view addSubview:self.webView];

    // add autolayout constraints
    self.webView.frame = self.view.bounds;
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share:)];
}

- (void)share:(id)sender {
    NSArray * activityItems = @[self.title, self.url];
    NSArray * applicationActivities = nil;
    NSArray * excludeActivities = @[UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypePostToWeibo, UIActivityTypePrint, UIActivityTypeMessage];
    
    UIActivityViewController * activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:applicationActivities];
    activityController.excludedActivityTypes = excludeActivities;
    
    [self presentViewController:activityController animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (!self.initialLoaded) {
        self.initialLoaded = YES;
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
    }
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

#pragma mark - Web view delegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
  
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)),     dispatch_get_main_queue(), ^{
        UIScrollView *scrollView = self.webView.scrollView;
        CGFloat top = -scrollView.contentInset.top;
        [scrollView setContentOffset:CGPointMake(0, top) animated:YES];
    });
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

@end
