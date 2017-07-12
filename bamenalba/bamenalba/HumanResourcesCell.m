//
//  HumacResourcesCell.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 5..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "HumanResourcesCell.h"

@interface HumanResourcesCell()
@property (strong, nonatomic) NSDictionary *Data;
@end

@implementation HumanResourcesCell

@synthesize delegate;

- (void) SetCellData:(NSDictionary *)data {
    self.Data = data;
    
    if (self.Data != nil)
    {
        NSString *state = [NSString stringWithFormat:@"%@(%@) %@", [self.Data objectForKey:@"user_nickname"], [self.Data objectForKey:@"user_age"], [self.Data objectForKey:@"distance"]];
        
        NSDictionary *attribs = @{
                                  NSForegroundColorAttributeName: [UIColor blackColor],
                                  NSFontAttributeName: [UIFont systemFontOfSize:12]
                                  };
        NSMutableAttributedString *attributedText =
        [[NSMutableAttributedString alloc] initWithString:state
                                               attributes:attribs];
        
        NSRange nameRange = [state rangeOfString:[self.Data objectForKey:@"user_nickname"]];
        NSRange ageRange = [state rangeOfString:[self.Data objectForKey:@"user_age"]];
        
        [attributedText setAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor],
                                        NSFontAttributeName: [UIFont systemFontOfSize:12]}
                                range:NSMakeRange(0, nameRange.length + ageRange.location + 1)];

        NSRange disRange = [state rangeOfString:[self.Data objectForKey:@"distance"]];
        
        [attributedText setAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor],
                                        NSFontAttributeName: [UIFont systemFontOfSize:12]}
                                range:disRange];
        
        
        [self.StateLb setAttributedText:attributedText];
        
        [self.ComentLb setText:[self.Data objectForKey:@"user_ment"]];
    }
}


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
    if (delegate != nil && [delegate respondsToSelector:@selector(CallDetailView:)]) {
        [delegate CallDetailView:self.Data];
    }
}

- (IBAction)CallPost:(id)sender {
    if (delegate != nil) {
        [delegate CallPost];
    }
}

@end
