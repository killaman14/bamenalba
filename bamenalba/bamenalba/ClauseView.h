//
//  ClauseView.h
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 6..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClauseView : UIViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *ClauseSwitch;
@property (weak, nonatomic) IBOutlet UITextView *ClauseTv;


- (IBAction) ClauseSwitchAction:(id)sender;

- (IBAction) Close:(id)sender;

@end
