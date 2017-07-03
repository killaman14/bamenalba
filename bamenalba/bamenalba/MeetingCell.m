//
//  MeetingCell.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 14..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "MeetingCell.h"

@interface MeetingCell()
@property (strong, nonatomic) NSDictionary *Data;
@end

@implementation MeetingCell

- (void) setCellData:(NSDictionary *) data
{
    self.Data = data;
    
    NSString *state = [NSString stringWithFormat:@"%@ %@(%@) %@", [self.Data objectForKey:@"time"], [self.Data objectForKey:@"name"], [self.Data objectForKey:@"age"], [self.Data objectForKey:@"dis"]];
    
    NSDictionary *attribs = @{
                              NSForegroundColorAttributeName: [UIColor blackColor],
                              NSFontAttributeName: [UIFont systemFontOfSize:12]
                              };
    NSMutableAttributedString *attributedText =
    [[NSMutableAttributedString alloc] initWithString:state
                                           attributes:attribs];

    NSRange timeRange = [state rangeOfString:[self.Data objectForKey:@"time"]];
    [attributedText setAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}
                            range:timeRange];
    
    
    
    UIColor *sexColor;
    if ([[self.Data objectForKey:@"sex"] isEqualToString:@"남자"]) {
        sexColor = [UIColor blueColor];
    }
    else sexColor = [UIColor magentaColor];
    
    
    
    NSRange nameRange = [state rangeOfString:[self.Data objectForKey:@"name"]];
    NSRange ageRange = [state rangeOfString:[self.Data objectForKey:@"age"]];
    
    [attributedText setAttributes:@{NSForegroundColorAttributeName:sexColor}
                            range:NSMakeRange(nameRange.length, ageRange.location + 1)];
    
    NSRange disRange = [state rangeOfString:[self.Data objectForKey:@"dis"]];
    
    [attributedText setAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]}
                            range:disRange];
    
    [self.StateLb setAttributedText:attributedText];
    
    [self.ContentLb setText:[self.Data objectForKey:@"content"]];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.PostButtonBG.layer setCornerRadius:5];
    [self.DeleteButtonBG.layer setCornerRadius:5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
