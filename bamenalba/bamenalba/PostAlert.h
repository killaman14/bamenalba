//
//  PostAlert.h
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 5..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PostAlertDelegate <NSObject>

@optional
- (void) PostAlertClose;

@end

@interface PostAlert : UIView

@property (assign, nonatomic) id<PostAlertDelegate> delegate;


@property (weak, nonatomic) IBOutlet UITextView *ExampleTextView;

- (IBAction) Close:(id)sender;
@end
