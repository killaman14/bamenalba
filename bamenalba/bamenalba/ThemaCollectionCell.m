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
        [ThemaIcon setTintColor:[UIColor colorWithRed:(238.0f/255.0f) green:(44.0f/255.0f) blue:(35.0f/255.0f) alpha:1]];
        [ThemaLabel setTextColor:[UIColor colorWithRed:(238.0f/255.0f) green:(44.0f/255.0f) blue:(35.0f/255.0f) alpha:1]];
    }
    else {
        [ThemaIcon setTintColor:[UIColor darkGrayColor]];
        [ThemaLabel setTextColor:[UIColor darkGrayColor]];
    }
}

- (void) drawRect:(CGRect)rect
{
    [super drawRect:rect];
}

@end
