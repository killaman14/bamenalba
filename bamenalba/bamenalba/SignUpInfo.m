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

#import "UIImageView+Corner.h"
#import "UIButton+Border.h"

#import "HTTPRequest.h"

#import "KEY.h"

typedef enum
{
    SUI_SECTOR = 1,
    SUI_AREA,
    SUI_PROVINCE,
    SUI_AGE,
    SUI_SEX,
    SUI_COMMENT,
    
    SUI_CLAUSE = 10,
    SUI_LOCATION = 11,
    
    SUI_EXCEPTION = 999
} SUI_TAG;

@interface SignUpInfo () <AlertManagerDelegate, HTTPRequestDelegate>

@property (assign) BOOL IsCompany;

@property (assign) BOOL IsClause;
@property (assign) BOOL IsLocation;

@property (weak, nonatomic) NSString *CommentKey;

@end

@implementation SignUpInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.IsClause = false;
    self.IsLocation = false;

    
    [self ExampleLbAnimation];
    
    
    [self ArrowView];
    [self UnderLine];
    
    [self.NicknameTf setDelegate:self];
    [self.SecretKeyTf setDelegate:self];
    
    [self.ClauseBtn Corner:5];
    [self.ClauseBtn Border:1 Color:[UIColor colorWithRed:(230.0f/255.0f) green:(28.0f/255.0f) blue:(112.0f/255.0f) alpha:1]];
    
    [self.LocationBtn Corner:5];
    [self.LocationBtn Border:1 Color:[UIColor colorWithRed:(230.0f/255.0f) green:(28.0f/255.0f) blue:(112.0f/255.0f) alpha:1]];
}

#pragma mark - [ ACTION ]

- (IBAction) HideKeyboard:(id)sender {
    
    [self.NicknameTf resignFirstResponder];
    [self.SecretKeyTf resignFirstResponder];
    
    [self.view endEditing:YES];
    
    [self.HideKeyboardButton setHidden:YES];
}

- (IBAction) Close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.NicknameTf setText:@""];
        [self InitSelectedLb:self.SectorLb];
        [self InitSelectedLb:self.AreaLb];
        [self InitSelectedLb:self.ProvinceLb];
        [self InitSelectedLb:self.AgeLb];
        [self InitSelectedLb:self.SexLb];
        [self.CommentLb setText:@"한마디를 선택하세요."];
        [self.CommentLb setTextColor:[UIColor darkGrayColor]];
        [self.SecretKeyTf setText:@""];
        
        self.IsClause = false;
        self.IsLocation = false;
        
        [self ClauseChange];
        [self LocationChange];
        
        [self.ScrollView setContentOffset:CGPointZero];
    }];
}

- (IBAction) ClauseCheck:(id)sender {
    switch ([sender tag]) {
        case SUI_CLAUSE:
            self.IsClause = !self.IsClause;
            [self ClauseChange];
            break;
        case SUI_LOCATION:
            self.IsLocation = !self.IsLocation;
            [self LocationChange];
            break;
        default:
            break;
    }
}

- (IBAction) Clause:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Clause"];
    [self presentViewController:vc animated:YES completion:NULL];
}

- (IBAction) AlertShow:(id)sender {
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
            if ([self IsLabelData:self.AreaLb])
            {
                [[AlertManager sharedInstance] showAlertTitle:@"군구"
                                                         data:[SystemManager AlertDataKey:[SystemManager ProvinceKey:self.AreaLb.text]]
                                                          tag:SUI_PROVINCE
                                                     delegate:self showViewController:self];
            }
            else {
                [[AlertManager sharedInstance] showAlertTitle:@"시도를 먼저 선택해주세요."
                                                         data:@[ @"닫기" ]
                                                          tag:SUI_EXCEPTION
                                                     delegate:self showViewController:self];
            }
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

- (IBAction) Signup:(id)sender {
    if ([self IsTextFieldData:self.NicknameTf] == false ||
        [self IsLabelData:self.SectorLb] == false ||
        [self IsLabelData:self.AreaLb] == false ||
        [self IsLabelData:self.ProvinceLb] == false ||
        [self IsLabelData:self.AgeLb] == false ||
        [self IsLabelData:self.SexLb] == false ||
        [self IsLabelData:self.CommentLb] == false ||
        [self IsTextFieldData:self.SecretKeyTf] == false) {
        
        [[AlertManager sharedInstance] showAlertTitle:@"해당항목을 꼼꼼히 작성해주세요."
                                                 data:@[ @"닫기" ]
                                                  tag:SUI_EXCEPTION
                                             delegate:nil showViewController:self];

        return;
    }
    else if (!self.IsClause || !self.IsLocation) {
        [[AlertManager sharedInstance] showAlertTitle:@"약관에 모두 동의해 주시기 바랍니다."
                                                 data:@[ @"닫기" ]
                                                  tag:SUI_EXCEPTION
                                             delegate:nil showViewController:self];
    }
    else {

        NSMutableDictionary *data = [NSMutableDictionary dictionary];
        [data setObject:[[SystemManager sharedInstance] UUID]  forKey:KEY_DEVICE_ID];
        [data setObject:@""                     forKey:KEY_PUSH_ID];
        
        NSString *memType = [NSString stringWithFormat:@"%d", ([[NSNumber numberWithBool:self.IsCompany] intValue] + 1)];
        [data setObject:memType                 forKey:KEY_MEMBER_TYPE];
        
        [data setObject:self.NicknameTf.text    forKey:KEY_USER_NICKNAME];
        [data setObject:self.AgeLb.text         forKey:KEY_USER_AGE];
        [data setObject:self.SexLb.text         forKey:KEY_USER_SEX];
        [data setObject:self.AreaLb.text        forKey:KEY_USER_AREA];
        [data setObject:self.ProvinceLb.text    forKey:KEY_USER_PROVINCE];
        [data setObject:self.SectorLb.text      forKey:KEY_USER_SECTOR];
        [data setObject:self.CommentLb.text     forKey:KEY_USER_MENT];
        [data setObject:@""                     forKey:KEY_USER_LAT];
        [data setObject:@""                     forKey:KEY_USER_LNG];
        [data setObject:self.SecretKeyTf.text   forKey:KEY_ACOUNTKEY];
        [data setObject:@"false"                forKey:KEY_STATE];
        [data setObject:@"ios"                  forKey:KEY_OS_TYPE];

        HTTPRequest *request = [[HTTPRequest alloc] init];
        [request setDelegate:self];
        [request SendUrl:URL_SIGNUP withDictionary:data];
    }
}



#pragma mark - [ ALERTMANAGER DELEGATE ]

- (void) AlertManagerSelected:(NSString *)selectedString withTag:(NSInteger)tag {
    switch ((SUI_TAG)tag) {
        case SUI_SECTOR:
            [self.SectorLb setTextColor:[UIColor blackColor]];
            [self.SectorLb setText:selectedString];
            break;
        case SUI_AREA:
            [self.AreaLb setTextColor:[UIColor blackColor]];
            [self.AreaLb setText:selectedString];
            break;
        case SUI_PROVINCE:
            [self.ProvinceLb setTextColor:[UIColor blackColor]];
            [self.ProvinceLb setText:selectedString];
            break;
        case SUI_AGE:
            [self.AgeLb setTextColor:[UIColor blackColor]];
            [self.AgeLb setText:selectedString];
            break;
        case SUI_SEX:
            [self.SexLb setTextColor:[UIColor blackColor]];
            [self.SexLb setText:selectedString];
            break;
        case SUI_COMMENT:
            [self.CommentLb setTextColor:[UIColor blackColor]];
            [self.CommentLb setText:selectedString];
            break;
        default:
            break;
    }
}

#pragma mark - [ PROCESS ]

- (void) ArrowView {
    [self ArrowViewSetting:self.SectorArrowView];
    [self ArrowViewSetting:self.AreaArrowView];
    [self ArrowViewSetting:self.ProvinceArrowView];
    [self ArrowViewSetting:self.AgeArrowView];
    [self ArrowViewSetting:self.SexArrowView];
    [self ArrowViewSetting:self.CommentArrowView];
}

- (void) ArrowViewSetting:(UIView *)arrowView {
    [arrowView.layer setCornerRadius:5];
    [arrowView.layer setBorderWidth:1];
    [arrowView.layer setBorderColor:[UIColor colorWithRed:(230.0f/255.0f) green:(28.0f/255.0f) blue:(112.0f/255.0f) alpha:1].CGColor];
}

- (void) UnderLine {
    [self UnderLineSetting:self.NickUnderLine];
    [self UnderLineSetting:self.SectorUnderLine];
    [self UnderLineSetting:self.AreaUnderLine];
    [self UnderLineSetting:self.ProvinceUnderLine];
    [self UnderLineSetting:self.AgeUnderLine];
    [self UnderLineSetting:self.SexUnderLine];
    [self UnderLineSetting:self.CommentUnderLine];
    [self UnderLineSetting:self.SecretKeyUnderLine];
}

- (void) UnderLineSetting:(UIImageView *)underline {
    [underline Corner:5 Color:[UIColor colorWithRed:(171.0f/255.0f) green:(171.0f/255.0f) blue:(171.0f/255.0f) alpha:0.6f]];
}

- (BOOL) IsLabelData:(UILabel *)lb {
    if ([lb.text isEqualToString:@"선택"] || [lb.text isEqualToString:@"닫기"] || [lb.text isEqualToString:@"한마디를 선택하세요."]) {
        return false;
    }
    else return true;
}

- (BOOL) IsTextFieldData:(UITextField *)tf {
    if ([tf.text length] < 1 || [tf.text length] > [tf tag]) {
        return false;
    }
    return true;
}

- (void) InitSelectedLb:(UILabel *)lb {
    [lb setText:@"선택"];
    [lb setTextColor:[UIColor darkGrayColor]];
}

- (void) ViewLoad {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *vc = [sb instantiateViewControllerWithIdentifier:@"TabBar"];
    [self presentViewController:vc animated:YES completion:NULL];
}


- (void) ClauseChange {
    if (self.IsClause) {
        [self.ClauseBtn setImage:[UIImage imageNamed:@"icon_chack"] forState:UIControlStateNormal];
    }
    else {
        [self.ClauseBtn setImage:nil forState:UIControlStateNormal];
    }
}

- (void) LocationChange {
    if (self.IsLocation) {
        [self.LocationBtn setImage:[UIImage imageNamed:@"icon_chack"] forState:UIControlStateNormal];
    }
    else {
        [self.LocationBtn setImage:nil forState:UIControlStateNormal];
    }
}

- (void) SignUpIsCompany:(BOOL) isCompany {
    self.IsCompany = isCompany;
    if (self.IsCompany) {
        [self CompanySetting];
    }
    else {
        [self UserSetting];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) ExampleLbAnimation {
    
    CGRect dRect = self.ExampleLb.frame;
    
    [self.ExampleLb setFrame:CGRectMake(self.view.frame.size.width, dRect.origin.y, dRect.size.width, dRect.size.height)];
    
    [UIView animateWithDuration:10.0f delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
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

#pragma mark - [ HTTPREQUEST DELEGATE ]

- (void) HTTPRequestFinish:(NSDictionary *)data HttpTag:(HTTP_TAG)httpTag ReturnRequest:(id)request {
    switch (httpTag) {
        case HTTP_SUCCESS:
            [[SystemManager sharedInstance] setUserData:data];
            [self ViewLoad];
            break;
        case HTTP_FAIL:
            
            break;
        default:
            break;
    }
}

- (void) HTTPRequestFinish:(NSDictionary *)data RequestTag:(int)tag HttpTag:(HTTP_TAG)httpTag ReturnRequest:(id)request {
    
}

#pragma mark - [ TEXTFIELD DELEGATE ]

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [self.HideKeyboardButton setHidden:YES];
    return [textField resignFirstResponder];
}

- (void) textFieldDidBeginEditing:(UITextField *)textField {
    [self.HideKeyboardButton setHidden:NO];
}


@end
