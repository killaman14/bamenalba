//
//  JobWrite.h
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 9..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobWriteView : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *ThemaCollectionView;

- (IBAction) Close:(id)sender;

@end
