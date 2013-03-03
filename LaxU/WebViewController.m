//
//  WebViewController.m
//  LaxU
//
//  Created by Quintin Smith on 1/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WebViewController.h"

@implementation WebViewController

-(void) loadView
{
    //create an instance  of UIWEbView as large as the screen
    CGRect screenFrame = [[UIScreen mainScreen] applicationFrame];
    UIWebView *wv = [[UIWebView alloc] initWithFrame:screenFrame];
    //tell web view to scale web content to fit within bounds of webview
    [wv setScalesPageToFit:YES];
    
    [self setView:wv];
    
}

-(UIWebView *) webView
{
    return (UIWebView *) [self view];
}

@end
