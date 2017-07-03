//
//  CashChargeView.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 6..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "CashChargeView.h"

@interface CashChargeView ()

@end

@implementation CashChargeView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.CornerImg_1.layer setCornerRadius:15];
    [self.CornerImg_2.layer setCornerRadius:15];
    [self.CornerImg_3.layer setCornerRadius:15];
    
    [self ButtonSetting:self.Payment_1];
    [self ButtonSetting:self.Payment_2];
    [self ButtonSetting:self.Payment_3];
    [self ButtonSetting:self.Payment_4];
    [self ButtonSetting:self.Payment_5];
    [self ButtonSetting:self.CouponBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction) CouponAction:(id)sender
{
    NSLog(@"Coupon OK : %@", self.CouponTf.text);
}

- (IBAction) PaymentAction:(id)sender
{
    switch ([sender tag]) {
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        case 5:
            
            break;
            
        default:
            break;
    }
    
    NSLog(@"Payment : %d", [sender tag]);
}

- (IBAction) Close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}



- (void) ButtonSetting:(UIButton *)btn {
    [btn.layer setCornerRadius:15];
    [btn setBackgroundColor:[UIColor colorWithRed:(237.0f/255.0f) green:(58.0f/255.0f) blue:(130.0f/255.0f) alpha:1]];
}

@end
