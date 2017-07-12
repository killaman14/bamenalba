//
//  JobInfoCell.m
//  bamenalba
//
//  Created by GSMAC on 2017. 5. 26..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "JobInfoCell.h"

#import "SystemManager.h"
#import "UIImageView+Cache.h"

@interface JobInfoCell()
@property (assign, nonatomic) int Index;

@property (weak, nonatomic) IBOutlet UIView *DetailParent;
@property (weak, nonatomic) IBOutlet UIView *EditParent;
@property (weak, nonatomic) IBOutlet UIView *PostParent;
@property (weak, nonatomic) IBOutlet UIView *DeleteParent;


@property (weak, nonatomic) IBOutlet UIView *ParentView;

@property (weak, nonatomic) IBOutlet UIImageView *ArrowImage;


@property (assign) float ParentTransfromX;
@property (assign) BOOL IsSelected;

- (IBAction) EnableButtons:(id)sender;

@end



@implementation JobInfoCell

@synthesize Items;
@synthesize ItemDatas;

@synthesize CompanyName;

@synthesize scale;

@synthesize delegate;


@synthesize DetailParent;
@synthesize EditParent;
@synthesize PostParent;
@synthesize DeleteParent;

@synthesize ParentView;

@synthesize ArrowImage;

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
    
    _ParentTransfromX = -60;
    _IsSelected = false;
    
    
//    [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
}

- (void) drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self.TitleIMG.layer setCornerRadius:5];
    [self.TitleIMG.layer setMasksToBounds:YES];
}

- (void) SetData:(NSMutableDictionary *) dic Index:(NSInteger) index
{
    ItemDatas = dic;
    
    _Index = (int)index;
    
    for (UIView *subview in [self.ItemView subviews]) {
        [subview removeFromSuperview];
    }
    

    
    [CompanyName setText:[ItemDatas objectForKey:@"company_name"]];
    
    [_Name setText:[NSString stringWithFormat:@"%@ (%@세)",
                    [ItemDatas objectForKey:@"user_name"],
                    [ItemDatas objectForKey:@"user_age"]]];
    
    NSArray *Key = @[ @"company_sector", @"company_sex", @"company_pay", @"company_payvalue", @"company_address1", @"company_address2", @"distance" ];
    
    for (int k = 0; k < Key.count; k++)
    {
        [self ItemSetting:[ItemDatas objectForKey:[Key objectAtIndex:k]] ItemType:(ITEM_TYPE)k];
    }
    
    CGRect rc = self.ItemView.frame;
    
    [self.ItemView setFrame:CGRectMake(rc.origin.x, rc.origin.y, rc.size.width * scale, rc.size.height * scale)];
    
    NSArray *subviews = [self.ItemView subviews];
    
    for (id subview in subviews) {
        CGRect gc = [subview frame];
        [subview setFrame:CGRectMake(gc.origin.x * scale, gc.origin.y * scale, gc.size.width * scale, gc.size.height * scale)];
    }
    [Items removeAllObjects];
    
    if ([[NSString stringWithFormat:@"%@", [ItemDatas objectForKey:@"img"]] isEqualToString:@""]) {
        [self.TitleIMG setImage:[UIImage imageNamed:@"ex_img"]];
    }
    else {
        [[UIImageView_Cache getInstance] loadFromUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [ItemDatas objectForKey:@"img"]]] callback:^(UIImage *image) {
            [self.TitleIMG setImage:image];
        }];
    }
    
    
    [self ButtonChange:[[self.ItemDatas objectForKey:@"device_id"] isEqualToString:[[SystemManager sharedInstance] UUID]]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void) ItemSetting:(NSString *) content ItemType:(ITEM_TYPE) type
{
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    
    if (type == SEX) { [lb setText:[content isEqualToString:@"M"] ? @"남성" : @"여성"]; }
    else if (type == PAY) {
        int pay = [content integerValue];
        if (pay > 999) {
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
            NSNumber *myNumber = [NSNumber numberWithInteger:pay];
            NSString *formattedNumberString = [NSString stringWithFormat:@"%@ 원", [numberFormatter stringFromNumber:myNumber]];
            [lb setText:formattedNumberString];
        }
        else
        {
            if (pay > 1) {
                [lb setText:[NSString stringWithFormat:@"%d 원", pay]];
            }
            else {
                [lb setText:content];
            }
        }
    }
    else {
        [lb setText:content];
    }
    [lb setTextAlignment:NSTextAlignmentCenter];
    [lb setFont:[UIFont systemFontOfSize:12]];
    [lb setMinimumScaleFactor:4];
    [lb setAdjustsFontSizeToFitWidth:YES];
    [lb sizeToFit];
    
    [self ContentTextLabel:lb ColorChangeItemType:type];
    
    [self.ItemView addSubview:lb];
    
    CGRect rect = lb.frame;
    
    float rX = rect.size.width * 1.2f;
    float rY = rect.size.height * 1.2f;
    
    [lb setFrame:CGRectMake(rect.origin.x * 1.2f, rect.origin.y * 1.2f, rX, rY)];
 
    float x = [[Items lastObject] frame].size.width + [[Items lastObject] frame].origin.x + 4;
    float y = [[Items lastObject] frame].origin.y;
    
    if (type == PAY) {
        float w = self.ItemView.frame.size.width;
        float r = w/x;

        r = r > 1.0f ? 1.0f : r;
        scale = r;

        x = 4;
        y = [[Items lastObject] frame].size.height + [[Items lastObject] frame].origin.y + 6;
    }
    
    UIImageView *imgView = [self RoundImageSetting:type];
    [imgView setFrame:CGRectMake(x, y, lb.frame.size.width + 6, lb.frame.size.height + 4)];
    [self.ItemView addSubview:imgView];
    
    [lb setFrame:CGRectMake(x + 3, y + 2, lb.frame.size.width, lb.frame.size.height)];
    
    [Items addObject:imgView];
}


- (void) ButtonChange:(BOOL)isMy {
    [EditParent setHidden:!isMy];
    [DeleteParent setHidden:!isMy];
    [DetailParent setHidden:isMy];
    [PostParent setHidden:isMy];
}

- (IBAction) EnableButtons:(id)sender {
    
    _IsSelected = !_IsSelected;
    
    [UIView animateWithDuration:0.4f animations:^{
        [ParentView setTransform:CGAffineTransformTranslate(ParentView.transform, _IsSelected ? -66 : 66, 0)];
        [ArrowImage setTransform:CGAffineTransformRotate(ArrowImage.transform, M_PI * 180.0f / 180.0f)];
    } completion:^(BOOL finished) {
        
    }];
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
    if (delegate != nil && [delegate respondsToSelector:@selector(CallDetailButton:)]) {
        [delegate CallDetailButton:_Index];
    }
}

- (IBAction) CallPost {
    if (delegate != nil && [delegate respondsToSelector:@selector(CallPostButton:)]) {
        [delegate CallPostButton:_Index];
    }
}

- (IBAction) CallEdit {
    if (delegate != nil && [delegate respondsToSelector:@selector(CallEditButton:)]) {
        [delegate CallEditButton:_Index];
    }
}

- (IBAction) CallDelete {
    if (delegate != nil && [delegate respondsToSelector:@selector(CallDelete)]) {
        [delegate CallDeleteButton:_Index];
    }
}

@end
