//
//  HumacResourcesCell.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 5..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "HumanResourcesCell.h"

@implementation HumanResourcesCell

@synthesize delegate;

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)CallDetail:(id)sender {
    if (delegate != nil) {
        [delegate CallDetailView];
    }
}

- (IBAction)CallPost:(id)sender {
    if (delegate != nil) {
        [delegate CallPost];
    }
}

@end
