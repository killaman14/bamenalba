//
//  PostAlert.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 5..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "PostAlert.h"

@implementation PostAlert

@synthesize delegate;

@synthesize ExampleTextView;


- (void) drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [ExampleTextView setText:@"- 부적절한 쪽지 전송시 이용에 제한될 수 있습니다.\n- 금품거래 및 사칭은 금지되어 있습니다. 이용약관을 준수해 주세요."];
}

- (IBAction) Close:(id)sender {
    if (delegate != nil) {
        [delegate PostAlertClose];
    }
}

@end
