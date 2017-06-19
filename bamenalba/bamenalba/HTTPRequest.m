//
//  HttpRequest.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 19..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "HTTPRequest.h"
#import "AppDelegate.h"
#import <UIKit/UIKit.h>


@interface HTTPRequest() <NSURLSessionDelegate, NSURLSessionDataDelegate>
@property (strong, nonatomic) NSMutableData *RequestData;
@property (strong, nonatomic) UIActivityIndicatorView *IndicatorView;

@property (strong, nonatomic) UIView *FrontView;
@end

@implementation HTTPRequest

@synthesize RequestData;
@synthesize IndicatorView;

@synthesize FrontView;


- (id) init {
    self = [super init];
    if (self)
    {
        self.FrontView = nil;
        self.FrontView = [[[[AppDelegate sharedAppDelegate] window] rootViewController] view];
        
        self.RequestData = nil;
        self.RequestData = [[NSMutableData alloc] init];
    }
    return self;
}


- (void) SendUrl:(NSString *)url withData:(NSData *)data {
    
    if (self.RequestData == nil) {
        self.RequestData = [[NSMutableData alloc] init];
    }
    else {
        [self.RequestData setData:[NSData data]];
    }
    
    self.IndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:self.FrontView.frame];
    [self.IndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.IndicatorView setTintColor:[UIColor redColor]];
    [self.IndicatorView setTag:999];
    
    [self.FrontView addSubview:self.IndicatorView];
    [self.IndicatorView startAnimating];

    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject
                                                                 delegate:self
                                                            delegateQueue:[NSOperationQueue mainQueue]];

    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:DEFAULT_URL]];
    [urlRequest setHTTPMethod:@"POST"];
    
    NSString *convertBody = [NSString stringWithFormat:@"%@=%@", POST_KEY, [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
    [urlRequest setHTTPBody:[convertBody dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:urlRequest];
    [dataTask resume];
}

#pragma mark -

- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    
    NSLog(@"%sl", __PRETTY_FUNCTION__);
    completionHandler(NSURLSessionResponseAllow);
}

#pragma mark -

- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    
    [self.RequestData appendData:data];
    NSLog(@"%sl", __PRETTY_FUNCTION__);
}

#pragma mark -

- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
 willCacheResponse:(NSCachedURLResponse *)proposedResponse
 completionHandler:(void (^)(NSCachedURLResponse * _Nullable cachedResponse))completionHandler
{
    
//    [self.IndicatorView stopAnimating];
//    [self.FrontView willRemoveSubview:self.IndicatorView];
//    self.IndicatorView = nil;
    
    NSString *logStr = [[NSString alloc] initWithData:self.RequestData encoding:NSUTF8StringEncoding];
    NSLog(@"LogStr : %@", logStr);
    
    NSMutableDictionary *dic = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:self.RequestData options:NSJSONReadingMutableLeaves error:nil];
    
    for (NSString *key in [[dic objectForKey:@"result"] objectAtIndex:0]) {
        NSLog(@"Key : %@", key);
    }
    
    
    
    NSLog(@"%sl", __PRETTY_FUNCTION__);
}

#pragma mark -

- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
didBecomeDownloadTask:(NSURLSessionDownloadTask *)downloadTask {
    NSLog(@"%sl", __PRETTY_FUNCTION__);
}

@end
