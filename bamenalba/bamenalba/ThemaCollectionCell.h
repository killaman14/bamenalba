//
//  ThemaCollectionCell.h
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 21..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemaCollectionCell : UICollectionViewCell
- (void) SetIconImageName:(NSString *) imagename;
- (void) SetTitleText:(NSString *) text;

- (void) IsThemaEnable:(bool)enable;
@end
