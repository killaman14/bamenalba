//
//  More.m
//  bamenalba
//
//  Created by GSMAC on 2017. 5. 26..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "More.h"


#import "SettingView.h"
#import "ClauseView.h"
#import "CashChargeView.h"

@interface More ()

@end

@implementation More

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - [ ACTION ]


- (IBAction) SettingViewLoad:(id)sender {
    [self Viewload:@"Setting"];
}

- (IBAction) ClauseViewLoad:(id)sender {
    [self Viewload:@"Clause"];
}

- (IBAction) MyInfo:(id)sender {
    [self Viewload:@"MyInfo"];
}

- (IBAction) CashChargeViewLoad:(id)sender {
    [self Viewload:@"CashCharge"];
}


- (IBAction) PackageViewLoad:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.naver.com"]];
}

- (IBAction) Hardships:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"www.naver.com"]];
}

- (IBAction) Enquiry:(id)sender {
    
}

- (IBAction) Store:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"www.naver.com"]];
}


- (void) Viewload:(NSString *)storyboardIdentity {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:storyboardIdentity];
    [self presentViewController:vc animated:YES completion:NULL];
}


@end
