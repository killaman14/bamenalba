//
//  UIImageView+Corner.h
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 26..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Corner)
- (void) Corner:(float) radius;
- (void) Border:(float) width;
- (void) Corner:(float)radius Color:(UIColor *)color;
@end
