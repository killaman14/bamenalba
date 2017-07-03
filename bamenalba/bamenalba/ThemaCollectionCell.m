//
//  ThemaCollectionCell.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 21..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "ThemaCollectionCell.h"

@interface ThemaCollectionCell()
@property (weak, nonatomic) IBOutlet UIImageView *ThemaIcon;
@property (weak, nonatomic) IBOutlet UILabel *ThemaLabel;
@end

@implementation ThemaCollectionCell
@synthesize ThemaIcon;
@synthesize ThemaLabel;


- (void) SetIconImageName:(NSString *) imagename {
    [ThemaIcon setImage:[UIImage imageNamed:imagename]];
}

- (void) SetTitleText:(NSString *) text {
    [ThemaLabel setText:text];
}

- (void) IsThemaEnable:(bool)enable {
    if (enable) {
//        [ThemaIcon setTintColor:[UIColor magentaColor]];
        [ThemaIcon.layer setCornerRadius:20];
        [ThemaIcon.layer setBorderWidth:1];
    }
    else {
        [ThemaIcon setTintColor:[UIColor clearColor]];
        [ThemaIcon.layer setCornerRadius:0];
        [ThemaIcon.layer setBorderWidth:0];
    }
}

- (void) drawRect:(CGRect)rect
{
    [super drawRect:rect];
}
@end
