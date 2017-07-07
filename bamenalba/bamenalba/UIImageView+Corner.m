//
//  UIImageView+Corner.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 26..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "UIImageView+Corner.h"

@implementation UIImageView(Corner)

- (void) Corner:(float) radius {
    [[self layer] setMasksToBounds:YES];
    [[self layer] setCornerRadius:radius];
}

- (void) Border:(float) width {
    [[self layer] setBorderWidth:width];
    [[self layer] setBorderColor:[UIColor colorWithRed:(237.0f/255.0f) green:(58.0f/255.0f) blue:(130.0f/255.0f) alpha:1].CGColor];
}

- (void) Corner:(float)radius Color:(UIColor *)color {
    [self Corner:radius];
    [self setBackgroundColor:color];
}

@end
