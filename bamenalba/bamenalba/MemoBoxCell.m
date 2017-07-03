//
//  MemoBoxCell.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 15..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "MemoBoxCell.h"

@interface MemoBoxCell()
@property (strong, nonatomic) NSDictionary *Data;
@end

@implementation MemoBoxCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.TitleIMG.layer setCornerRadius:25];
    
    [self.ContentView.layer setCornerRadius:10];
}

- (void) setCellData:(NSDictionary *) data
{
    self.Data = data;
    
    NSString *state = [NSString stringWithFormat:@"%@ (%@) %@", [self.Data objectForKey:@"nick"], [self.Data objectForKey:@"age"], [self.Data objectForKey:@"dis"]];
    
    NSDictionary *attribs = @{
                              NSForegroundColorAttributeName: [UIColor blackColor],
                              NSFontAttributeName: [UIFont systemFontOfSize:12]
                              };
    NSMutableAttributedString *attributedText =
    [[NSMutableAttributedString alloc] initWithString:state
                                           attributes:attribs];
    
    
    NSRange nameRange = [state rangeOfString:[self.Data objectForKey:@"nick"]];
    NSRange ageRange = [state rangeOfString:[self.Data objectForKey:@"age"]];
    
    [attributedText setAttributes:@{NSForegroundColorAttributeName:[UIColor magentaColor]}
                            range:NSMakeRange(nameRange.length, ageRange.location + 1)];
    
    NSRange disRange = [state rangeOfString:[self.Data objectForKey:@"dis"]];
    
    [attributedText setAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]}
                            range:disRange];
    
    [self.StateLb setAttributedText:attributedText];
    
    
    [self.TimeLb setText:[NSString stringWithFormat:@"%@", [self.Data objectForKey:@"time"]]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction) Photo:(id)sender {
    
}

@end
