//
//  HumacResourcesCell.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 5..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "HumanResourcesCell.h"

@interface HumanResourcesCell()
@property (weak, nonatomic) IBOutlet UIImageView *TitleImage;

@property (weak, nonatomic) IBOutlet UIView *DetailButton;
@property (weak, nonatomic) IBOutlet UIView *PostButton;
@end

@implementation HumanResourcesCell

@synthesize delegate;

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.TitleImage.layer setCornerRadius:25];
    
    [self.DetailButton.layer setCornerRadius:5];
    [self.PostButton.layer setCornerRadius:5];
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
