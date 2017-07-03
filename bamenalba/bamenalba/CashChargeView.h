//
//  CashChargeView.h
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 6..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CashChargeView : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *CornerImg_1;
@property (weak, nonatomic) IBOutlet UIImageView *CornerImg_2;
@property (weak, nonatomic) IBOutlet UIImageView *CornerImg_3;

@property (weak, nonatomic) IBOutlet UIButton *Payment_1;
@property (weak, nonatomic) IBOutlet UIButton *Payment_2;
@property (weak, nonatomic) IBOutlet UIButton *Payment_3;
@property (weak, nonatomic) IBOutlet UIButton *Payment_4;
@property (weak, nonatomic) IBOutlet UIButton *Payment_5;
@property (weak, nonatomic) IBOutlet UIButton *CouponBtn;

@property (weak, nonatomic) IBOutlet UITextField *CouponTf;

- (IBAction) CouponAction:(id)sender;

- (IBAction) PaymentAction:(id)sender;

- (IBAction) Close:(id)sender;

@end
