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
    
    [self.CityButton addTarget:self
                        action:@selector(CallCity:)
              forControlEvents:UIControlEventTouchUpInside];
    
    [self.ProvinceButton addTarget:self
                            action:@selector(CallProvinceButton:)
                  forControlEvents:UIControlEventTouchUpInside];
    
    [[self.ProvinceButton titleLabel] setAdjustsFontSizeToFitWidth:YES];
    [[self.ProvinceButton titleLabel] setMinimumScaleFactor:0.5f];
    
    [self.PremiumButton addTarget:self
                           action:@selector(CallPremium:)
                 forControlEvents:UIControlEventTouchUpInside];
    
    [self.DistanceButton addTarget:self
                            action:@selector(CallDistance:)
                  forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - [ Event ]

- (void) SetCityLabelText:(NSString *)text {
    if (!([text isEqualToString:@""] || [text isEqualToString:@"전체"])) {
        [self.ProvinceButton setHidden:NO];
        [self.ProvinceButton setEnabled:YES];
    }
    [self.CityButton setTitle:[NSString stringWithFormat:@"▼ %@", text] forState:UIControlStateNormal];
}

- (void) SetProvinceLabelText:(NSString *)text {
    [self.ProvinceButton setTitle:[NSString stringWithFormat:@"▼ %@", text] forState:UIControlStateNormal];
}

- (void) SetPremiumLabelText:(NSString *)text {
    [self.PremiumButton setTitle:text forState:UIControlStateNormal];
}

- (void) SetDistanceLabelText:(NSString *)text {
    [self.DistanceButton setTitle:text forState:UIControlStateNormal];
}


#pragma mark - [ JobInfoTopView Delegate Methods ]

- (void)CallCity:(id)sender {
    if (delegate != nil) {
        [delegate CallCityButton];
    }
}

- (void)CallProvinceButton:(id)sender {
    if (delegate != nil) {
        [delegate CallProvinceButton];
    }
}

- (void)CallPremium:(id)sender {
    if (delegate != nil) {
        [delegate CallPremiumButton];
    }
}

- (void)CallDistance:(id)sender {
    if (delegate != nil) {
        [delegate CallDistanceButton];
    }
}

@end
