//
//  JobInfoTopView.m
//  bamenalba
//
//  Created by GSMAC on 2017. 5. 26..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "SearchTopView.h"


@interface SearchTopView()
@property (assign, nonatomic) BOOL IsEnableButtonActivity;
@property (strong, nonatomic) NSMutableArray *Buttons;
@end

@implementation SearchTopView

@synthesize LEFT_ONE_BUTTON;
@synthesize LEFT_TWO_BUTTON;
@synthesize LEFT_THREE_BUTTON;
@synthesize RIGHT_BUTTON;

@synthesize delegate;

@synthesize IsEnableButtonActivity;


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

- (void) Init {
    
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    self.Buttons = [NSMutableArray array];
    
    [self.Buttons addObject:self.LEFT_ONE_BUTTON];
    [self.Buttons addObject:self.LEFT_TWO_BUTTON];
    [self.Buttons addObject:self.LEFT_THREE_BUTTON];
    [self.Buttons addObject:self.RIGHT_BUTTON];

    self.IsEnableButtonActivity = false;
    if (delegate != nil && [self.delegate respondsToSelector:@selector(searchButtonActivity)]) {
        self.IsEnableButtonActivity = [self.delegate searchButtonActivity];
    }
    
    
    [self settingButtonLabel:self.LEFT_ONE_BUTTON.titleLabel];
    [self settingButton:self.LEFT_ONE_BUTTON];
    
    
    [self settingButtonLabel:self.LEFT_TWO_BUTTON.titleLabel];
    [self settingButton:self.LEFT_TWO_BUTTON];
    
    
    [[self.LEFT_TWO_BUTTON titleLabel] setAdjustsFontSizeToFitWidth:YES];
    [[self.LEFT_TWO_BUTTON titleLabel] setMinimumScaleFactor:0.5f];
    

    [self settingButtonLabel:self.LEFT_THREE_BUTTON.titleLabel];
    [self settingButton:self.LEFT_THREE_BUTTON];
    
    
    [self settingButtonLabel:self.RIGHT_BUTTON.titleLabel];
    [self settingButton:self.RIGHT_BUTTON];
    
    NSDictionary *titles = [delegate searchbarTitles];
    for (NSString *key in [titles allKeys]) {
        [self setText:[titles objectForKey:key] ButtonType:(TOPVIEW_BUTTON)[key integerValue]];
    }
}


#pragma mark - [ Event ]

- (IBAction) Call:(id)sender {
    UIButton *btn = (UIButton *) sender;

    for (UIButton *abtn in self.Buttons) {
        [abtn setBackgroundColor:[UIColor clearColor]];
    }

    if (self.IsEnableButtonActivity) {
        [btn setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5f]];
    }
    
    if (delegate != nil && [self.delegate respondsToSelector:@selector(requestButton:)]) {
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

- (void) settingButton:(UIButton *)btn {
    [btn addTarget:self
            action:@selector(Call:)
     forControlEvents:UIControlEventTouchUpInside];
    [btn.layer setCornerRadius:5];
}

@end
