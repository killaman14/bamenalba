//
//  MeetingCell.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 14..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "MeetingCell.h"

#import "SystemManager.h"

#import "UIImageView+Cache.h"

@interface MeetingCell()
@property (strong, nonatomic) NSDictionary *Data;
@end

@implementation MeetingCell

- (void) setCellData:(NSDictionary *) data
{
    self.Data = data;
    
    /*
     "num":"3",
     "img":"",
     "content”:”.”,
     ”state_date":"2017-06-29 14:10:59",
     "now_time":"2017-07-06 14:31:49",
     "distance":"13278",
     "prim_code":"CA178499",
     "device_id":"353582070333364",
     "user_name":"\ubb38\ub625\ud3f0",
     "user_age":"33",
     "user_sex":"M",
     "member_type":"2"
     */
    @try {
        NSString *nTimeStr = [self.Data objectForKey:@"now_time"];
        NSString *cTimeStr = [self.Data objectForKey:@"state_date"];
        
        NSString *time = [[SystemManager sharedInstance] TimeSpace_WriteTime:[self ConvertTime:cTimeStr]
                                                                 CurrentTime:[self ConvertTime:nTimeStr]];
        
        
        NSString *state = [NSString stringWithFormat:@"%@ %@(%@세) %@",
                           time,
                           [self.Data objectForKey:@"user_name"],
                           [self.Data objectForKey:@"user_age"],
                           [self.Data objectForKey:@"distance"]];
        
        
        NSDictionary *attribs = @{ NSForegroundColorAttributeName: [UIColor blackColor],
                                   NSFontAttributeName: [UIFont systemFontOfSize:12] };
        
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:state
                                                                                           attributes:attribs];
        
        NSRange timeRange = [state rangeOfString:time];
        [attributedText setAttributes:@{ NSForegroundColorAttributeName:[UIColor blackColor] }
                                range:NSMakeRange(0, timeRange.length) ];
        
        
        UIColor *sexColor;
        if ([[self.Data objectForKey:@"user_sex"] isEqualToString:@"M"]) {
            sexColor = [UIColor blueColor];
        }
        else sexColor = [UIColor magentaColor];
        
        NSString *nameageStr = [NSString stringWithFormat:@"%@(%@세)", [self.Data objectForKey:@"user_name"], [self.Data objectForKey:@"user_age"]];
        NSRange nameageRange = [state rangeOfString:nameageStr];
        
        [attributedText setAttributes:@{ NSForegroundColorAttributeName:sexColor }
                                range:NSMakeRange(timeRange.length + 1, nameageRange.length)];
        
        NSRange disRange = [state rangeOfString:[self.Data objectForKey:@"distance"]];
        
        [attributedText setAttributes:@{ NSForegroundColorAttributeName:[UIColor greenColor] }
                                range:disRange];
        
        [self.StateLb setAttributedText:attributedText];
        
        [self.ContentLb setText:[self.Data objectForKey:@"content"]];
        
        if ([[self.Data objectForKey:@"img"] isEqualToString:@""]) {
            [self.TitleIMG setImage:[UIImage imageNamed:@"ex_img.png"]];
        }
        else {
            [[UIImageView_Cache getInstance] loadFromUrl:[NSURL URLWithString:[self.Data objectForKey:@"img"]] callback:^(UIImage *image) {
                [self.TitleIMG setImage:image];
            }];
        }

    } @catch (NSException *exception) {
        NSLog(@"Exception : %@", exception);
    } @finally {
        
    }
}

- (NSDate *) ConvertTime:(NSString *)strTime {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormat dateFromString:strTime];
}

- (NSInteger)formattedDateCompareToNow:(NSDate *)date
{
    NSDateFormatter *mdf = [[NSDateFormatter alloc] init];
    [mdf setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate *midnight = [mdf dateFromString:[mdf stringFromDate:date]];
    NSInteger dayDiff = (int)[midnight timeIntervalSinceNow] / (60*60*24);
    return dayDiff;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.PostButtonBG.layer setCornerRadius:5];
    [self.DeleteButtonBG.layer setCornerRadius:5];
    
    [self.TitleIMG.layer setCornerRadius:5];
    [self.TitleIMG.layer setMasksToBounds:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
