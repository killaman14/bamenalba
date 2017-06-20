//
//  MemoBoxCell.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 15..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "MemoBoxCell.h"

@interface MemoBoxCell()
@property (weak, nonatomic) IBOutlet UIImageView *TitleImage;
@end

@implementation MemoBoxCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.TitleImage.layer setCornerRadius:25];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
