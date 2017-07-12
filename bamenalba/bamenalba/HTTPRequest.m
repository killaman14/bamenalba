//
//  HttpRequest.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 19..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "HTTPRequest.h"
#import "AppDelegate.h"

#import "AlertManager.h"
#import <UIKit/UIKit.h>


@interface HTTPRequest() <NSURLSessionDelegate, NSURLSessionDataDelegate, AlertManagerDelegate>
@property (strong, nonatomic) NSMutableData *RequestData;
@property (strong, nonatomic) UIActivityIndicatorView *IndicatorView;

@property (strong, nonatomic) UIView *FrontView;

@property (assign) NSInteger Tag;
@end

@implementation HTTPRequest

@synthesize RequestData;
@synthesize IndicatorView;

@synthesize FrontView;

@synthesize Tag;


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

- (id) initWithTag:(NSInteger) tag {
    self = [self init];
    if (self) {
        self.Tag = tag;
    }
    return self;
}

- (void) SendUrl:(NSString *)url RequestTag:(int)tag withDictionary:(NSDictionary *)data {
    NSError *error = nil;
    NSData *jsonObj = [NSJSONSerialization dataWithJSONObject:data
                                                      options:0
                                                        error:&error];
    
    [self SendUrl:url withData:jsonObj];
}

- (void) SendUrl:(NSString *)url withDictionary:(NSDictionary *)data {
    NSError *error = nil;
    NSData *jsonObj = [NSJSONSerialization dataWithJSONObject:data
                                                      options:0
                                                        error:&error];
    
    [self SendUrl:url withData:jsonObj];
}

- (void) SendUrl:(NSString *)url withData:(NSData *)data {
    NSLog(@"-----\n\n\n ------ \n\n %@ \n\n ------ ", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
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

    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", DEFAULT_URL, url]]];
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
    completionHandler(NSURLSessionResponseAllow);
}

#pragma mark -

- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    
    [self.RequestData appendData:data];
}

#pragma mark -

- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
 willCacheResponse:(NSCachedURLResponse *)proposedResponse
 completionHandler:(void (^)(NSCachedURLResponse * _Nullable cachedResponse))completionHandler
{
    
    [self.IndicatorView stopAnimating];
    [self.FrontView willRemoveSubview:self.IndicatorView];
    self.IndicatorView = nil;
    
    NSString *logStr = [[NSString alloc] initWithData:self.RequestData encoding:NSUTF8StringEncoding];
    
//    NSString* newStr = [NSString stringWithUTF8String:[self.RequestData bytes]];
    
    NSLog(@"LogStr : %@", logStr);
    
    NSMutableDictionary *dic = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:self.RequestData options:NSJSONReadingMutableLeaves error:nil];

    HTTP_TAG tag = (HTTP_TAG) [[[dic objectForKey:@"result"] objectForKey:@"code"] intValue];
    
    if (tag == HTTP_FAIL) {
        [[AlertManager sharedInstance] showAlertTitle:@"잘못된 파라메터입니다." data:@[ @"닫기" ] tag:0 delegate:self showViewController:[[[AppDelegate sharedAppDelegate] window] rootViewController]];
    }
    else {
        if ([self.delegate respondsToSelector:@selector(HTTPRequestFinish:HttpTag:ReturnRequest:)]) {
            [self.delegate HTTPRequestFinish:dic HttpTag:tag ReturnRequest:self];
        }
        if ([self.delegate respondsToSelector:@selector(HTTPRequestFinish:RequestTag:HttpTag:ReturnRequest:)]) {
            [self.delegate HTTPRequestFinish:dic RequestTag:self.Tag HttpTag:tag ReturnRequest:self];
        }
    }
}

- (void) AlertManagerDidSelected:(NSInteger)tag withIndex:(NSInteger)index {
    
}

#pragma mark -

- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
didBecomeDownloadTask:(NSURLSessionDownloadTask *)downloadTask {
    
}



@end
