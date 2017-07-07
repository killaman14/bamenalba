//
//  UIButton+Border.h
//  bamenalba
//
//  Created by Sejung Park on 2017. 7. 4..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Border)
- (void) Corner:(float) radius;
- (void) Border:(float) width Color:(UIColor *)color;
@end
