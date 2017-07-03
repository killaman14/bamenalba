//
//  MeetingWrite.h
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 13..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface MeetingWrite : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;

@property (weak, nonatomic) IBOutlet UIImageView *TitleImg;
@property (weak, nonatomic) IBOutlet UITextView *ContentTextView;
@property (weak, nonatomic) IBOutlet UILabel *NeedPointsLb;
@property (weak, nonatomic) IBOutlet UILabel *OwnedPointsLb;



- (IBAction) Close:(id)sender;

- (IBAction) TingSend:(id)sender;

- (IBAction) AlertShow:(id)sender;

@end
