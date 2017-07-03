//
//  HumacResourcesCell.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 5..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "HumanResourcesCell.h"

@interface HumanResourcesCell()
@property (strong, nonatomic) NSDictionary *data;
@end

@implementation HumanResourcesCell

@synthesize delegate;

- (void) SetCellData:(NSDictionary *)data {
    self.data = data;
    
    if (self.data != nil)
    {
        NSString *state = [NSString stringWithFormat:@"%@(%@) %@", [self.data objectForKey:@"name"], [self.data objectForKey:@"age"], [self.data objectForKey:@"dis"] ];
        
        NSDictionary *attribs = @{
                                  NSForegroundColorAttributeName: [UIColor blackColor],
                                  NSFontAttributeName: [UIFont systemFontOfSize:12]
                                  };
        NSMutableAttributedString *attributedText =
        [[NSMutableAttributedString alloc] initWithString:state
                                               attributes:attribs];
        
        NSRange nameRange = [state rangeOfString:[self.data objectForKey:@"name"]];
        NSRange ageRange = [state rangeOfString:[self.data objectForKey:@"age"]];
        
        [attributedText setAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor],
                                        NSFontAttributeName: [UIFont systemFontOfSize:12]}
                                range:NSMakeRange(0, nameRange.length + ageRange.location + 1)];

        NSRange disRange = [state rangeOfString:[self.data objectForKey:@"dis"]];
        
        [attributedText setAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor],
                                        NSFontAttributeName: [UIFont systemFontOfSize:12]}
                                range:disRange];
        
        
        [self.StateLb setAttributedText:attributedText];
        
        [self.ComentLb setText:[self.data objectForKey:@"coment"]];
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
