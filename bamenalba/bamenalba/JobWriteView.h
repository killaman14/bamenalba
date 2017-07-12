//
//  JobWrite.h
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 9..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface JobWriteView : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *ThemaCollectionView;

@property (weak, nonatomic) IBOutlet UIImageView *JobTitleImg;
@property (weak, nonatomic) IBOutlet UITextField *JobNameLb;
@property (weak, nonatomic) IBOutlet UILabel *SectorLb;
@property (weak, nonatomic) IBOutlet UILabel *AreaLb;
@property (weak, nonatomic) IBOutlet UILabel *ProvinceLb;
@property (weak, nonatomic) IBOutlet UITextField *AgeMinTf;
@property (weak, nonatomic) IBOutlet UITextField *AgeMaxTf;
@property (weak, nonatomic) IBOutlet UITextField *PayTf;
@property (weak, nonatomic) IBOutlet UILabel *PayTypeLb;
@property (weak, nonatomic) IBOutlet UILabel *SexLb;
@property (weak, nonatomic) IBOutlet UITextField *PhoneNumTf;
@property (weak, nonatomic) IBOutlet UITextView *IntroductionTextView;
@property (weak, nonatomic) IBOutlet UILabel *TermLb;
@property (weak, nonatomic) IBOutlet UILabel *NeedPointsLb;
@property (weak, nonatomic) IBOutlet UILabel *OwnedPointsLb;


- (void) SetEditData:(NSDictionary *)data;

- (IBAction) IntroductionMacro:(id)sender;

- (IBAction) AlertShow:(id)sender;

- (IBAction) Close:(id)sender;

@end
