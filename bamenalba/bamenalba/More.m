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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


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


- (void) Viewload:(NSString *)storyboardIdentity {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:storyboardIdentity];
    [self presentViewController:vc animated:YES completion:NULL];
}


@end
