//
//  SettingView.h
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 6..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingView : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *AlarmBG;
@property (weak, nonatomic) IBOutlet UIImageView *AlarmCK;
@property (weak, nonatomic) IBOutlet UIImageView *AlarmCKBG;


- (IBAction) Close:(id)sender;

@end
