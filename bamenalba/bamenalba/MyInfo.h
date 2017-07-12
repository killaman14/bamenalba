//
//  MyInfo.h
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 9..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Photos/Photos.h>

@interface MyInfo : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (weak, nonatomic) IBOutlet UIView *ContentView;

@property (weak, nonatomic) IBOutlet UIImageView *MyImage;

@property (weak, nonatomic) IBOutlet UITextField *NickTf;
@property (weak, nonatomic) IBOutlet UILabel *AgeLb;
@property (weak, nonatomic) IBOutlet UISegmentedControl *SexSc;
@property (weak, nonatomic) IBOutlet UILabel *AreaLb;
@property (weak, nonatomic) IBOutlet UILabel *ProvinceLb;
@property (weak, nonatomic) IBOutlet UILabel *SectorLb;
@property (weak, nonatomic) IBOutlet UILabel *CommentLb;
@property (weak, nonatomic) IBOutlet UITextField *SecretKeyTf;

@property (weak, nonatomic) IBOutlet UIButton *EditButton;


- (IBAction) AlertShow:(id)sender;

- (IBAction) SegmentChangeValue:(id)sender;

- (IBAction) KeyExample:(id)sender;

- (IBAction) SaveSend:(id)sender;

- (IBAction) Close:(id)sender;

@end
