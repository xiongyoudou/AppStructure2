//
//  UIWebView+Blocks.m
//
//  Created by Shai Mishali on 1/1/13.
//  Copyright (c) 2013 Shai Mishali. All rights reserved.
//

#import "UIWebView+XYDBlocks.h"

static void (^__xyd_loadedBlock)(UIWebView *webView);
static void (^__xyd_failureBlock)(UIWebView *webView, NSError *error);
static void (^__xyd_loadStartedBlock)(UIWebView *webView);
static BOOL (^__xyd_shouldLoadBlock)(UIWebView *webView, NSURLRequest *request, UIWebViewNavigationType navigationType);

static uint __xyd_loadedWebItems;

@implementation UIWebView (XYDBlock)

#pragma mark - UIWebView+Blocks

+(UIWebView *)xyd_loadRequest:(NSURLRequest *)request
                   loaded:(void (^)(UIWebView *webView))loadedBlock
                   failed:(void (^)(UIWebView *webView, NSError *error))failureBlock{

    return [self xyd_loadRequest:request loaded:loadedBlock failed:failureBlock loadStarted:nil shouldLoad:nil];
}

+(UIWebView *)xyd_loadHTMLString:(NSString *)htmlString
                      loaded:(void (^)(UIWebView *webView))loadedBlock
                      failed:(void (^)(UIWebView *webView, NSError *error))failureBlock{
    
    return [self xyd_loadHTMLString:htmlString loaded:loadedBlock failed:failureBlock loadStarted:nil shouldLoad:nil];
}

+(UIWebView *)xyd_loadHTMLString:(NSString *)htmlString
                      loaded:(void (^)(UIWebView *))loadedBlock
                      failed:(void (^)(UIWebView *, NSError *))failureBlock
                 loadStarted:(void (^)(UIWebView *webView))loadStartedBlock
                  shouldLoad:(BOOL (^)(UIWebView *webView, NSURLRequest *request, UIWebViewNavigationType navigationType))shouldLoadBlock{
    __xyd_loadedWebItems = 0;
    __xyd_loadedBlock = loadedBlock;
    __xyd_failureBlock = failureBlock;
    __xyd_loadStartedBlock = loadStartedBlock;
    __xyd_shouldLoadBlock = shouldLoadBlock;
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.delegate = (id)[self class];
    [webView loadHTMLString:htmlString baseURL:nil];
    
    return webView;
}

+(UIWebView *)xyd_loadRequest:(NSURLRequest *)request
                   loaded:(void (^)(UIWebView *webView))loadedBlock
                   failed:(void (^)(UIWebView *webView, NSError *error))failureBlock
              loadStarted:(void (^)(UIWebView *webView))loadStartedBlock
               shouldLoad:(BOOL (^)(UIWebView *webView, NSURLRequest *request, UIWebViewNavigationType navigationType))shouldLoadBlock{
    __xyd_loadedWebItems    = 0;
    
    __xyd_loadedBlock       = loadedBlock;
    __xyd_failureBlock      = failureBlock;
    __xyd_loadStartedBlock  = loadStartedBlock;
    __xyd_shouldLoadBlock   = shouldLoadBlock;
    
    UIWebView *webView  = [[UIWebView alloc] init];
    webView.delegate    = (id) [self class];
    
    [webView loadRequest: request];
    
    return webView;
}

#pragma mark - Private Static delegate
+(void)webViewDidFinishLoad:(UIWebView *)webView{
    __xyd_loadedWebItems--;
    
    if(__xyd_loadedBlock && (!TRUE_END_REPORT || __xyd_loadedWebItems == 0)){
        __xyd_loadedWebItems = 0;
        __xyd_loadedBlock(webView);
    }
}

+(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{    
    __xyd_loadedWebItems--;
    
    if(__xyd_failureBlock)
        __xyd_failureBlock(webView, error);
}

+(void)webViewDidStartLoad:(UIWebView *)webView{    
    __xyd_loadedWebItems++;
    
    if(__xyd_loadStartedBlock && (!TRUE_END_REPORT || __xyd_loadedWebItems > 0))
        __xyd_loadStartedBlock(webView);
}

+(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if(__xyd_shouldLoadBlock)
        return __xyd_shouldLoadBlock(webView, request, navigationType);
    
    return YES;
}

@end
