//
//  ThemaCell.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 10..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "ThemaCell.h"




@interface ThemaCell()
@property (assign) BOOL IS_CHECK;
@end


@implementation ThemaCell


- (void) stretchToSuperView:(UIView*) view {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *bindings = NSDictionaryOfVariableBindings(view);
    NSString *formatTemplate = @"%@:|[view]|";
    for (NSString * axis in @[@"H",@"V"]) {
        NSString * format = [NSString stringWithFormat:formatTemplate,axis];
        NSArray * constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:bindings];
        [view.superview addConstraints:constraints];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.IS_CHECK = false;
}


- (void) setItemThema:(NSString*) thema {
    [self.themaText setText:thema];
}

- (void) setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    self.IS_CHECK = !self.IS_CHECK;
    if (self.IS_CHECK) {
//        NSLog(@"해제");
    }
    else {
//        NSLog(@"선택");
    }
}

@end
