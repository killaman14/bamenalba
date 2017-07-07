//
//  PostAlert.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 5..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "PostAlert.h"



@interface PostAlert()
@property (strong, nonatomic) NSDictionary *data;
@end


@implementation PostAlert

@synthesize delegate;

@synthesize data;

@synthesize ExampleTextView;



- (void) drawRect:(CGRect)rect {
    [super drawRect:rect];

    self.data = @{ @"name":@"도봉순", @"age":@"22세", @"dis":@"5km", @"point":@"30000" };
    
    
    NSString *state = [NSString stringWithFormat:@"%@(%@) %@", [self.data objectForKey:@"name"], [self.data objectForKey:@"age"], [self.data objectForKey:@"dis"] ];
    
    NSDictionary *attribs = @{
                              NSForegroundColorAttributeName: [UIColor blackColor],
                              NSFontAttributeName: [UIFont systemFontOfSize:12]
                              };
    NSMutableAttributedString *attributedText =
    [[NSMutableAttributedString alloc] initWithString:state
                                           attributes:attribs];
    
    NSRange nameRange = [state rangeOfString:[self.data objectForKey:@"name"]];
    NSRange ageRange = [state rangeOfString:[self.data objectForKey:@"age"]];
    
    [attributedText setAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor],
                                    NSFontAttributeName: [UIFont systemFontOfSize:12]}
                            range:NSMakeRange(0, nameRange.length + ageRange.location + 1)];
    
    NSRange disRange = [state rangeOfString:[self.data objectForKey:@"dis"]];
    
    [attributedText setAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor],
                                    NSFontAttributeName: [UIFont systemFontOfSize:12]}
                            range:disRange];
    
    
    [self.StateLb setAttributedText:attributedText];
    
    [self.ContentTf setDelegate:self];
    
    
    
    
    NSString *strPoint = [self.data objectForKey:@"point"];
    NSNumber *nPoint = [NSNumber numberWithInteger:[strPoint integerValue]];
    NSString *point = [NSString stringWithFormat:@"보유포인트 : %@p",  nPoint];
    
    NSMutableAttributedString *attPointText = [[NSMutableAttributedString alloc] initWithString:point attributes:attribs];
    
    NSRange pointRange = [point rangeOfString:[NSString stringWithFormat:@"%@p", nPoint]];
    
    [attPointText setAttributes:@{ NSForegroundColorAttributeName:[UIColor magentaColor],
                                   NSFontAttributeName: [UIFont systemFontOfSize:12]}
                          range:pointRange];
    
    [self.OwnedPointsLb setAttributedText:attPointText];
    
    [self.ParentView.layer setMasksToBounds:YES];
    [self.ParentView.layer setCornerRadius:10];

    [_ExampleLb setText:@"- 부적절한 쪽지 전송시 이용에 제한될 수 있습니다.\n- 금품거래 및 사칭은 금지되어 있습니다. 이용약관을 준수해 주세요."];
}


- (void) SetData:(NSDictionary *)data {
    
}


- (void) Show:(UIView *)view {
    self.frame = view.bounds;
    
    self.alpha = 0.0f;
    
    [self setUserInteractionEnabled:NO];
    
    [view addSubview:self];
    
    
    
    [UIView animateWithDuration:0.25f
                          delay:0.0f
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.alpha = 1.0;
                     }
                     completion:^(BOOL finished){
                         [self setUserInteractionEnabled:YES];
                     }];
}

#pragma mark - [ ACTION ]

- (IBAction) PostSend:(id)sender {
    
}

- (IBAction) Close:(id)sender {
    if (delegate != nil) {
        self.alpha = 1;

        [UIView animateWithDuration:0.25f
                              delay:0.0f
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             self.alpha = 0.0;
                         }
                         completion:^(BOOL finished){
                             [delegate PostAlertClose];
                         }];
        
        
    }
}


#pragma mark - [ TEXTFIELD DELEGATE ]

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}





@end
