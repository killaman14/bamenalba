//
//  PostAlert.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 5..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "PostAlert.h"

#import "HTTPRequest.h"
#import "SystemManager.h"

@interface PostAlert() <HTTPRequestDelegate>
@property (strong, nonatomic) NSDictionary *Data;
@end


@implementation PostAlert

@synthesize delegate;

@synthesize Data;

@synthesize ContentTf;

- (void) Init {
    [self.ScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    
    [self.ContentTf setText:@""];
    [self.ContentTf resignFirstResponder];
}

- (void) drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self Init];
    
    [self.ContentTf setDelegate:self];

    [self.ParentView.layer setMasksToBounds:YES];
    [self.ParentView.layer setCornerRadius:10];

    [_ExampleLb setText:@"- 부적절한 쪽지 전송시 이용에 제한될 수 있습니다.\n- 금품거래 및 사칭은 금지되어 있습니다. 이용약관을 준수해 주세요."];
}


- (void) SetData:(NSDictionary *)data {
    self.Data = data;
    
    NSString *StateString = [NSString stringWithFormat:@"%@ (%@세) %@",
                             [self.Data objectForKey:@"user_name"],
                             [self.Data objectForKey:@"user_age"],
                             [self.Data objectForKey:@"distance"]];
    
    NSDictionary *attribute = @{
                                NSForegroundColorAttributeName: [UIColor blackColor],
                                NSFontAttributeName: [UIFont systemFontOfSize:12]
                                };
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:StateString attributes:attribute];
    
    UIColor *stateColor = [[self.Data objectForKey:@"user_sex"] isEqualToString:@"F"] == true ? [UIColor magentaColor] : [UIColor blueColor];
    
    NSRange stateRange = [StateString rangeOfString:[NSString stringWithFormat:@"%@ (%@세)",[self.Data objectForKey:@"user_name"], [self.Data objectForKey:@"user_age"]]];
    
    [attributedText setAttributes:@{
                                    NSForegroundColorAttributeName: stateColor,
                                    NSFontAttributeName: [UIFont systemFontOfSize:12]
                                    }
                            range:NSMakeRange(0, stateRange.length) ];
    
    
    NSRange disRange = [StateString rangeOfString:[self.Data objectForKey:@"distance"]];
    
    [attributedText setAttributes:@{
                                    NSForegroundColorAttributeName: [UIColor greenColor],
                                    NSFontAttributeName: [UIFont systemFontOfSize:12]
                                    }
                            range:NSMakeRange(disRange.location, disRange.length)];
    
    [self.StateLb setAttributedText:attributedText];
    
    
    NSString *strPoint = @"100000000"; // [self.Data objectForKey:@""];
    NSNumber *nPoint = [NSNumber numberWithInteger:[strPoint integerValue]];
    
    NSString *pointString = [NSString stringWithFormat:@"보유포인트 : %@p", [NSNumberFormatter localizedStringFromNumber:nPoint numberStyle:NSNumberFormatterDecimalStyle]];
    
    [self.OwnedPointsLb setText:pointString];
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
    
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    
    [data setObject:[[SystemManager sharedInstance] UUID] forKey:@"a_device_id"];
    [data setObject:self.ContentTf.text forKey:@"a_content"];
    [data setObject:@"352722070234532" forKey:@"b_device_id"];
    
    HTTPRequest *request = [[HTTPRequest alloc] initWithTag:0];
    [request setDelegate:self];
    [request SendUrl:URL_POST_SEND withDictionary:data];
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
                             [self Init];
                             [delegate PostAlertClose];
                         }];
        
        
    }
}


#pragma mark - [ TEXTFIELD DELEGATE ]

- (void) textFieldDidBeginEditing:(UITextField *)textField {
    [self.ScrollView setContentOffset:CGPointMake(0, 40) animated:YES];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [self.ScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [textField resignFirstResponder];
    return YES;
}



#pragma mark - [ HTTPREQUEST DELEGATE ] 

- (void) HTTPRequestFinish:(NSDictionary *)data HttpTag:(HTTP_TAG)httpTag ReturnRequest:(id)request {
    [self Init];
    [self Close:nil];
}


@end
