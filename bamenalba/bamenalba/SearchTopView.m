//
//  JobInfoTopView.m
//  bamenalba
//
//  Created by GSMAC on 2017. 5. 26..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "SearchTopView.h"


@interface SearchTopView()
@end

@implementation SearchTopView

@synthesize LEFT_ONE_BUTTON;
@synthesize LEFT_TWO_BUTTON;
@synthesize LEFT_THREE_BUTTON;
@synthesize RIGHT_BUTTON;


@synthesize delegate;

- (id) initWithFrame:(CGRect)frame addView:(UIView *)view
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"initWithFrame");
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    
    [self.LEFT_ONE_BUTTON addTarget:self
                        action:@selector(Call:)
              forControlEvents:UIControlEventTouchUpInside];
    [self settingButtonLabel:self.LEFT_ONE_BUTTON.titleLabel];
    
    
    [self.LEFT_TWO_BUTTON addTarget:self
                            action:@selector(Call:)
                  forControlEvents:UIControlEventTouchUpInside];
    [self settingButtonLabel:self.LEFT_TWO_BUTTON.titleLabel];
    
    [[self.LEFT_TWO_BUTTON titleLabel] setAdjustsFontSizeToFitWidth:YES];
    [[self.LEFT_TWO_BUTTON titleLabel] setMinimumScaleFactor:0.5f];
    
    
    [self.LEFT_THREE_BUTTON addTarget:self
                           action:@selector(Call:)
                 forControlEvents:UIControlEventTouchUpInside];
    [self settingButtonLabel:self.LEFT_THREE_BUTTON.titleLabel];
    
    
    [self.RIGHT_BUTTON addTarget:self
                            action:@selector(Call:)
                  forControlEvents:UIControlEventTouchUpInside];
    [self settingButtonLabel:self.RIGHT_BUTTON.titleLabel];
    
    NSDictionary *titles = [delegate searchbarTitles];
    for (NSString *key in [titles allKeys]) {
        [self setText:[titles objectForKey:key] ButtonType:(TOPVIEW_BUTTON)[key integerValue]];
    }
}


#pragma mark - [ Event ]

- (IBAction) Call:(id)sender {
    UIButton *btn = (UIButton *) sender;

    if (delegate != nil) {
//    if ([delegate respondsToSelector:@selector(requestButton:)]) {
        [delegate requestButton:(TOPVIEW_BUTTON)btn.tag];
    }
}

- (void) setHidden:(BOOL)hidden ButtonType:(TOPVIEW_BUTTON) buttontype
{

    [[self getButtonTypeObject:buttontype] setHidden:hidden];
}

- (void) setText:(NSString *)text ButtonType:(TOPVIEW_BUTTON) buttontype
{
    UIButton *btn = [self getButtonTypeObject:buttontype];
    
    if (btn != nil) {
        if (btn.hidden == YES || [text isEqualToString:@""]) {
            [btn setHidden:NO];
            [btn setEnabled:YES];
        }
        
        [btn setTitle:text forState:UIControlStateNormal];
//        [[btn titleLabel] setText:text];
    }
    
}

- (UIButton *) getButtonTypeObject:(TOPVIEW_BUTTON) buttontype {
    switch (buttontype)
    {
        case TOPVIEW_LEFT_BUTTON_ONE:
            return LEFT_ONE_BUTTON;
            
        case TOPVIEW_LEFT_BUTTON_TWO:
            return LEFT_TWO_BUTTON;
            
        case TOPVIEW_LEFT_BUTTON_THREE:
            return LEFT_THREE_BUTTON;
            
        case TOPVIEW_RIGHT_BUTTON:
            return RIGHT_BUTTON;
            
        default:
            return nil;
    }
}

- (void) settingButtonLabel:(UILabel *)lb {
    lb.numberOfLines = 1;
    lb.adjustsFontSizeToFitWidth = YES;
    lb.lineBreakMode = NSLineBreakByClipping;
    [lb setFont:[UIFont systemFontOfSize:14]];
    [lb setMinimumScaleFactor:0.6];
}

@end
