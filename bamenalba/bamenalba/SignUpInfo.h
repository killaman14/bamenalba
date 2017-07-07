//
//  SignUpInfo.h
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 16..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpInfo : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *HideKeyboardButton;

@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;

@property (weak, nonatomic) IBOutlet UILabel* ExampleLb;

@property (weak, nonatomic) IBOutlet UITextField *NicknameTf;
@property (weak, nonatomic) IBOutlet UILabel *SectorLb;
@property (weak, nonatomic) IBOutlet UILabel *AreaLb;
@property (weak, nonatomic) IBOutlet UILabel *ProvinceLb;
@property (weak, nonatomic) IBOutlet UILabel *AgeLb;
@property (weak, nonatomic) IBOutlet UILabel *SexLb;
@property (weak, nonatomic) IBOutlet UILabel *CommentLb;
@property (weak, nonatomic) IBOutlet UITextField *SecretKeyTf;

@property (weak, nonatomic) IBOutlet UIButton *ClauseBtn;
@property (weak, nonatomic) IBOutlet UIButton *LocationBtn;


@property (weak, nonatomic) IBOutlet UIView *SectorArrowView;
@property (weak, nonatomic) IBOutlet UIView *AreaArrowView;
@property (weak, nonatomic) IBOutlet UIView *ProvinceArrowView;
@property (weak, nonatomic) IBOutlet UIView *AgeArrowView;
@property (weak, nonatomic) IBOutlet UIView *SexArrowView;
@property (weak, nonatomic) IBOutlet UIView *CommentArrowView;


@property (weak, nonatomic) IBOutlet UIImageView *NickUnderLine;
@property (weak, nonatomic) IBOutlet UIImageView *SectorUnderLine;
@property (weak, nonatomic) IBOutlet UIImageView *AreaUnderLine;
@property (weak, nonatomic) IBOutlet UIImageView *ProvinceUnderLine;
@property (weak, nonatomic) IBOutlet UIImageView *AgeUnderLine;
@property (weak, nonatomic) IBOutlet UIImageView *SexUnderLine;
@property (weak, nonatomic) IBOutlet UIImageView *CommentUnderLine;
@property (weak, nonatomic) IBOutlet UIImageView *SecretKeyUnderLine;


- (IBAction) Close:(id)sender;
- (IBAction) Clause:(id)sender;
- (IBAction) AlertShow:(id)sender;
- (IBAction) Signup:(id)sender;

- (void) SignUpIsCompany:(BOOL) isCompany;

@property (weak, nonatomic) IBOutlet UIView *ggg;
@end
