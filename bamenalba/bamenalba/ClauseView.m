//
//  ClauseView.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 6..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "ClauseView.h"

@interface ClauseView ()
@property (nonatomic) NSString *CALUSEText;
@property (nonatomic) NSString *PIHText;

@property (nonatomic) BOOL isSwitch;
@end

@implementation ClauseView


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.CALUSEText = @"[밤엔알바 이용안내]\n\n 밤앤알바(구직자) 이용안내";
    
    self.PIHText = @"위치기반서비스 이용약관\n\n 제1조 [목작]";
    
    self.isSwitch = true;
    
    [self ClauseSwitchAction:self.ClauseSwitch];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - [ ACTION ]

- (IBAction) ClauseSwitchAction:(id)sender {
    self.isSwitch = !self.isSwitch;

    [self.ClauseSwitch setSelectedSegmentIndex:(int)self.isSwitch];
    
    switch (self.isSwitch) {
        case true:
            [self.ClauseTv setText:self.PIHText];
            break;
        case false:
            [self.ClauseTv setText:self.CALUSEText];
            break;
        default:
            break;
    }
    
}

- (IBAction) Close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
