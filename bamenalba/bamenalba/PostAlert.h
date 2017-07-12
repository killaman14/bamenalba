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

@interface PostAlert : UIView <UITextFieldDelegate>

@property (assign, nonatomic) id<PostAlertDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;

@property (weak, nonatomic) IBOutlet UIView *ParentView;
@property (weak, nonatomic) IBOutlet UILabel *StateLb;
@property (weak, nonatomic) IBOutlet UITextField *ContentTf;
@property (weak, nonatomic) IBOutlet UILabel *OwnedPointsLb;
@property (weak, nonatomic) IBOutlet UILabel *ExampleLb;


- (void) SetData:(NSDictionary *)data;

- (void) Show:(UIView *)view;

- (IBAction) PostSend:(id)sender;

- (IBAction) Close:(id)sender;
@end
