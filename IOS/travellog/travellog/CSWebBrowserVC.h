//
//  CSWebBrowserVC.h
//  Testing
//
//  Created by Cullen Sun on 10/10/13.
//  Copyright (c) 2013 my.company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSWebBrowserVC : UIViewController<UIWebViewDelegate>{
}
- (id)initWith:(NSURL*) url andTitle:(NSString*)title;

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSURL *url;

@end
