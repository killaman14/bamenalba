//
//  JobInfoCell.m
//  bamenalba
//
//  Created by GSMAC on 2017. 5. 26..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "JobInfoCell.h"


@interface JobInfoCell()
@property (assign, nonatomic) int Index;
@end



@implementation JobInfoCell

@synthesize DetailButton;
@synthesize PostButton;

@synthesize Items;
@synthesize ItemDatas;

@synthesize delegate;


- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        Items = [NSMutableArray array];
        
        ItemDatas = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void) drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [_Address setText:[ItemDatas objectForKey:@"ADDRESS"]];
    
    [_Name setText:[NSString stringWithFormat:@"%@(%@)",
                    [ItemDatas objectForKey:@"NAME"],
                    [ItemDatas objectForKey:@"AGE"]]];
    
    NSArray *Key = @[ @"CATEGORY", @"SEX", @"PAY_TYPE", @"PAY", @"CITY", @"PROVINCE", @"DISTANCE" ];
    
    for (int k = 0; k < Key.count; k++)
    {
        [self ItemSetting:[ItemDatas objectForKey:[Key objectAtIndex:k]] ItemType:(ITEM_TYPE)k];
    }
    
    [Items removeAllObjects];
}

- (void) SetData:(NSMutableDictionary *) dic Index:(NSInteger) index
{
    ItemDatas = dic;
    
    _Index = (int)index;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void) ItemSetting:(NSString *) content ItemType:(ITEM_TYPE) type
{
    UILabel *lb = [[UILabel alloc] init];
    [lb setText:content];
    [lb setFont:[UIFont systemFontOfSize:14]];
    [lb setMinimumScaleFactor:6];
    [lb sizeToFit];
    [self ContentTextLabel:lb ColorChangeItemType:type];
    [self.ItemView addSubview:lb];
    
 
    float x = [[Items lastObject] frame].size.width + [[Items lastObject] frame].origin.x + 4;
    float y = [[Items lastObject] frame].origin.y;
    if (type == CITY) {
        x = 4;
        y = [[Items lastObject] frame].size.height + [[Items lastObject] frame].origin.y + 2;
    }
    
    UIImageView *imgView = [self RoundImageSetting:type];
    [imgView setFrame:CGRectMake(x, y, lb.frame.size.width + 6, lb.frame.size.height + 4)];
    [self.ItemView addSubview:imgView];
     
    [lb setFrame:CGRectMake(x + 3, y + 2, lb.frame.size.width, lb.frame.size.height)];
    
    [Items addObject:imgView];
}


#pragma mark - [ Content Color Setting ]

- (void) ContentTextLabel:(UILabel *)lb ColorChangeItemType:(ITEM_TYPE) type {
    switch (type) {
        case DISTANCE:
            [lb setTextColor:[UIColor colorWithRed:0 green:1 blue:0.25f alpha:1]];
            break;
            
        case PAY:
            [lb setTextColor:[UIColor colorWithRed:1 green:0.45f blue:0.15f alpha:1]];
            break;
            
        case SEX:
            [lb setTextColor:[UIColor colorWithRed:0.9f green:0.1f blue:0.25f alpha:1]];
            break;
            
        default:
            break;
    }
}

#pragma mark - [ RoundImageSetting ]

- (UIImageView *) RoundImageSetting:(ITEM_TYPE) type {
    UIImageView *imgView = [[UIImageView alloc] init];
    [[imgView layer] setBorderWidth:1];
    [[imgView layer] setCornerRadius:6];
    [[imgView layer] setBackgroundColor:[[UIColor clearColor] CGColor]];
    
    switch (type) {
        case DISTANCE:
            [[imgView layer] setBorderColor:[[UIColor colorWithRed:0.9f green:0.1f blue:0.25f alpha:1] CGColor]];
            break;
            
        default:
            [[imgView layer] setBorderColor:[[UIColor blackColor] CGColor]];
            break;
    }
    
    return imgView;
}


#pragma mark - [ JobInfoCell Delegate ]

- (IBAction) CallDetail {
    if (delegate != nil) {
        [delegate CallDetailButton:_Index];
    }
}

- (IBAction) CallPost {
    if (delegate != nil) {
        [delegate CallPostButton:_Index];
    }
}

@end
