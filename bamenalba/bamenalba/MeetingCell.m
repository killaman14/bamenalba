//
//  MeetingCell.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 14..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "MeetingCell.h"

@interface MeetingCell()
@property (weak, nonatomic) IBOutlet UIImageView *PostButtonBG;
@property (weak, nonatomic) IBOutlet UIImageView *DeleteButtonBG;
@end

@implementation MeetingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.PostButtonBG.layer setCornerRadius:5];
    [self.DeleteButtonBG.layer setCornerRadius:5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
