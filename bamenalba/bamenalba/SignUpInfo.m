//
//  SignUpInfo.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 16..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "SignUpInfo.h"

#import "AlertManager.h"
#import "SystemManager.h"

typedef enum
{
    SUI_SECTOR = 1,
    SUI_AREA,
    SUI_PROVINCE,
    SUI_AGE,
    SUI_SEX,
    SUI_COMMENT
} SUI_TAG;

@interface SignUpInfo () <AlertManagerDelegate>

@property (assign) BOOL IsCompany;

@property (weak, nonatomic) NSString *CommentKey;
@end

@implementation SignUpInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self ExampleLbAnimation];
}

- (void) SignUpIsCompany:(BOOL) isCompany {
    self.IsCompany = isCompany;
    
    switch (self.IsCompany) {
        case YES:
            [self CompanySetting];
            break;
        case NO:
            [self UserSetting];
            break;
        default:
            break;
    }
}

- (IBAction) AlertShow:(id)sender
{
    switch ((SUI_TAG)[sender tag]) {
        case SUI_SECTOR:
            [[AlertManager sharedInstance] showAlertTitle:@"업종"
                                                     data:[SystemManager AlertDataKey:CSV_KEY_SECTOR]
                                                      tag:SUI_SECTOR
                                                 delegate:self showViewController:self];
            break;
        case SUI_AREA:
            [[AlertManager sharedInstance] showAlertTitle:@"시도"
                                                     data:[SystemManager AlertDataKey:CSV_KEY_AREA]
                                                      tag:SUI_AREA
                                                 delegate:self showViewController:self];
            break;
            
        case SUI_PROVINCE:
            [[AlertManager sharedInstance] showAlertTitle:@"업종"
                                                     data:[SystemManager AlertDataKey:CSV_KEY_SECTOR]
                                                      tag:SUI_SECTOR
                                                 delegate:self showViewController:self];
            break;
            
        case SUI_AGE:
            [[AlertManager sharedInstance] showAlertTitle:@"나이"
                                                     data:[SystemManager AlertDataKey:CSV_KEY_AGE]
                                                      tag:SUI_AGE
                                                 delegate:self showViewController:self];
            break;
            
        case SUI_SEX:
            [[AlertManager sharedInstance] showAlertTitle:@"성별"
                                                     data:@[ @"남성", @"여성" ]
                                                      tag:SUI_SEX
                                                 delegate:self showViewController:self];
            break;
            
        case SUI_COMMENT:
            [[AlertManager sharedInstance] showAlertTitle:@"한마디"
                                                     data:[SystemManager AlertDataKey:self.CommentKey]
                                                      tag:SUI_COMMENT
                                                 delegate:self showViewController:self];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) ExampleLbAnimation {
    
    CGRect dRect = self.ExampleLb.frame;
    
    [self.ExampleLb setFrame:CGRectMake(self.view.frame.size.width, dRect.origin.y, dRect.size.width, dRect.size.height)];

    [UIView animateWithDuration:10.0f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        [self.ExampleLb setFrame:CGRectMake(-([UIScreen mainScreen].bounds.size.width + dRect.size.width), dRect.origin.y, dRect.size.width, dRect.size.height)];
    } completion:^(BOOL finished) {
        
        [self ExampleLbAnimation];
    }];
}


- (void) UserSetting {
    [self.NicknameTf setPlaceholder:@"닉네임을 입력 (최대 8글자)"];
    
    self.CommentKey = CSV_KEY_MENT;
}

- (void) CompanySetting {
    [self.NicknameTf setPlaceholder:@"담당자 닉네임을 입력 (최대 8글자)"];
    
    self.CommentKey = CSV_KEY_COMPANYMENT;
}



- (void) AlertManagerSelected:(NSString *)selectedString withTag:(NSInteger)tag {
    NSLog(@"Selected Str : %@", selectedString);
}

@end
