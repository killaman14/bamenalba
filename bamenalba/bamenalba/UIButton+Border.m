//
//  UIButton+Border.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 7. 4..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "UIButton+Border.h"

@implementation UIButton (Border)
- (void) Corner:(float) radius {
    [self.layer setCornerRadius:radius];
}
- (void) Border:(float) width Color:(UIColor *)color {
    [self.layer setBorderWidth:width];
    [self.layer setBorderColor:color.CGColor];
}
@end
