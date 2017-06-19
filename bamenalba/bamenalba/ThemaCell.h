//
//  ThemaCell.h
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 10..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ThemaCellDelegate <NSObject>

@end

@interface ThemaCell : UICollectionViewCell

- (void) stretchToSuperView:(UIView*) view;

@property (weak, nonatomic) IBOutlet UIImageView *chkImg;
@property (weak, nonatomic) IBOutlet UILabel *themaText;

@end
