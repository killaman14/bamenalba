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

#import "KEY.h"

@interface Intro ()

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
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:IS_SINGUP] == NO) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UITabBarController *vc = [sb instantiateViewControllerWithIdentifier:@"SignUp"];
            [self presentViewController:vc animated:YES completion:NULL];
        }
        else {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UITabBarController *vc = [sb instantiateViewControllerWithIdentifier:@"TabBar"];
            [self presentViewController:vc animated:YES completion:NULL];
        }
    }];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
