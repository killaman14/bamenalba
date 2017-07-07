//
//  Intro.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 16..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "Intro.h"

#import "AppDelegate.h"

#import "HTTPRequest.h"
#import "SystemManager.h"

#import "KEY.h"



typedef enum {
    LOGIN_CHECK = 1,
    LOGIN = 2
} REQUEST_TAG;


@interface Intro () <HTTPRequestDelegate>

@end

@implementation Intro

@synthesize IntroImg;
@synthesize requestData;

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [UIView animateWithDuration:2.0f animations:^{
        [IntroImg setAlpha:1.0f];
        [IntroImg setTransform:CGAffineTransformTranslate(IntroImg.transform, 0, 30)];
    } completion:^(BOOL finished) {
        [self LoginCheck];
    }];
}


- (void) LoginCheck
{
//
    
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setObject:@"ios"      forKey:KEY_OS];
    [data setObject:SECRET_KEY  forKey:KEY_SECRET_KEY];
    [data setObject:[[SystemManager sharedInstance] UUID]  forKey:KEY_DEVICE_ID];
    [data setObject:@""         forKey:KEY_USER_LAT];
    [data setObject:@""         forKey:KEY_USER_LNG];
    [data setObject:@"false"    forKey:KEY_STATE];
    
    NSError *error = nil;
    NSData *jsonObj = [NSJSONSerialization dataWithJSONObject:data
                                                      options:0
                                                        error:&error];
    
    HTTPRequest *request = [[HTTPRequest alloc] initWithTag:LOGIN_CHECK];
    [request setDelegate:self];
    [request SendUrl:URL_LOGIN_CHECK withData:jsonObj];
}

- (void) HTTPRequestFinish:(NSDictionary *)data HttpTag:(HTTP_TAG)httpTag ReturnRequest:(id)request
{
    if (httpTag == HTTP_SUCCESS)
    {
        [[SystemManager sharedInstance] setUserData:[data objectForKey:@"result_user_info"]];
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UITabBarController *vc = [sb instantiateViewControllerWithIdentifier:@"TabBar"];
        [self presentViewController:vc animated:YES completion:NULL];
    }
    else if (httpTag == HTTP_EMPLY_USER) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UITabBarController *vc = [sb instantiateViewControllerWithIdentifier:@"SignUp"];
        [self presentViewController:vc animated:YES completion:NULL];
    }
    
    request = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
