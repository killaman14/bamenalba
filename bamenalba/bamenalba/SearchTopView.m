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

- (id) initWithFrame:(CGRect)frame {
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
    
    [self setBackgroundColor:[UIColor blueColor]];
    
    [self.LEFT_ONE_BUTTON addTarget:self
                        action:@selector(Call:)
              forControlEvents:UIControlEventTouchUpInside];
    
    [self.LEFT_TWO_BUTTON addTarget:self
                            action:@selector(Call:)
                  forControlEvents:UIControlEventTouchUpInside];
    
    [[self.LEFT_TWO_BUTTON titleLabel] setAdjustsFontSizeToFitWidth:YES];
    [[self.LEFT_TWO_BUTTON titleLabel] setMinimumScaleFactor:0.5f];
    
    [self.LEFT_THREE_BUTTON addTarget:self
                           action:@selector(Call:)
                 forControlEvents:UIControlEventTouchUpInside];
    
    [self.RIGHT_BUTTON addTarget:self
                            action:@selector(Call:)
                  forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - [ Event ]

- (IBAction) Call:(id)sender {
    UIButton *btn = (UIButton *) sender;
    if (delegate != nil) {
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
        if (btn.hidden == YES) {
            [btn setHidden:NO];
        }
        [[btn titleLabel] setText:text];
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

@end
