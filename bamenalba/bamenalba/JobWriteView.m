//
//  JobWrite.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 9..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "JobWriteView.h"

#import "SystemManager.h"
#import "AlertManager.h"
#import "ThemaCollectionCell.h"

#import "HTTPRequest.h"


#define DEFAILT_COLLECTIONVIEW_WIDTH 398
#define DEFAILT_COLLECTIONVIEW_HEIGHT 209.67

#define DEFAILT_COLLECTIONCELL_WIDTH 100.0f
#define DEFAILT_COLLECTIONCELL_HEIGHT 60.0f


typedef enum {
    JW_SECTORS      = 1,
    JW_AREA         = 2,
    JW_PROVINCE     = 3,
    JW_PAYTYPE      = 4,
    JW_AGE          = 5,
    JW_SEX          = 6,
    JW_TERM         = 7,
    
    JW_IMAGE        = 8,
    
    
    JW_HTTP_WRITE   = 100,
    JW_HTTP_FIX     = 101,
    JW_HTTP_DETAIL  = 102,
} JW_TAG;



@interface JobWriteView () <AlertManagerDelegate, HTTPRequestDelegate>


// [ THEMA ] ----------- >
@property (strong, nonatomic) NSArray *ThemaTitles;
@property (strong, nonatomic) NSArray *ThemaImageNames;
@property (strong, nonatomic) NSMutableArray *EnableThema;
// [ -------------------- ]
@property (assign) int TermIndex;
@property (strong, nonatomic) NSArray *TermArray;
@property (strong, nonatomic) NSArray *TermMessageArray;
@property (strong, nonatomic) NSArray *PhotoTitles;

@property (weak, nonatomic) NSString *IntroductionPlaceholder;

@end

@implementation JobWriteView

#pragma mark - [ Variable ]

@synthesize IntroductionPlaceholder;



- (void) SetEditData:(NSDictionary *)data
{
    HTTPRequest *request = [[HTTPRequest alloc] initWithTag:JW_HTTP_DETAIL];
    [request setDelegate:self];
    [request SendUrl:URL_ADS_DETAIL withDictionary:@{ [data objectForKey:@"prim_code"]:@"prim_code" } ];
}

#pragma mark - [ VIEW LOAD ]

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.JobTitleImg.layer.masksToBounds = YES;
    [self.JobTitleImg.layer setCornerRadius:10];
    
    
    IntroductionPlaceholder = @"구직자에게 우리 가게를 소개해주세요.\n\n(ex 근무 환경, 손님 환경, 동료 환경 등등)\n\n+ 자동입력을 사용 하시면 빠르게 소개를 작성할 수 있습니다.";
    [self.IntroductionTextView setDelegate:self];
    [self.IntroductionTextView setText:IntroductionPlaceholder];
    [self.IntroductionTextView setTextColor:[UIColor lightGrayColor]];
    [self.IntroductionTextView.layer setBorderWidth:1];
    [self.IntroductionTextView.layer setCornerRadius:5];
    
    self.EnableThema = [NSMutableArray arrayWithObjects:@"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", nil];
    self.ThemaTitles = @[ @"초보가능", @"당일지급", @"경력우대", @"출퇴근자유", @"파트타임", @"차비지원", @"숙식제공", @"성형지원", @"선불가능" ];
    self.ThemaImageNames = @[ @"option_1.png", @"option_2.png", @"option_3.png", @"option_4.png", @"option_5.png", @"option_6.png", @"option_7.png", @"option_8.png", @"option_9.png" ];

    self.TermArray = @[ @"7", @"14", @"30", @"90" ];
    self.TermMessageArray = @[ @"7일 25,000 포인트", @"14일 97,000 포인트", @"30일 194,000 포인트", @"90일 232,800 포인트(이벤트 20% 할인)" ];
    
    self.PhotoTitles = @[ @"앨범", @"카메라", @"삭제", @"닫기" ];
    
    [self.PhoneNumTf setDelegate:self];
    
    [self.ThemaCollectionView setDelegate:self];
    [self.ThemaCollectionView setDataSource:self];
    
    
    [self.ThemaCollectionView setFrame:CGRectMake(self.ThemaCollectionView.frame.origin.x, self.ThemaCollectionView.frame.origin.y, self.view.frame.size.width, self.ThemaCollectionView.frame.size.height)];

    [self.ScrollView setFrame:CGRectMake(self.ScrollView.frame.origin.x, self.ScrollView.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - [ ACTION EVENT ]

- (IBAction) IntroductionMacro:(id)sender {
    NSLog(@"자동입력");
}

- (IBAction) AlertShow:(id)sender {
    
    switch ([sender tag]) {
        case JW_SECTORS:
            
            [[AlertManager sharedInstance] showAlertTitle:@"업종"
                                                     data:[SystemManager AlertDataKey:CSV_KEY_SECTOR]
                                                      tag:JW_SECTORS
                                                 delegate:self
                                       showViewController:self];
            break;
            
        case JW_AREA:
            
            [[AlertManager sharedInstance] showAlertTitle:@"시도"
                                                     data:[SystemManager AlertDataKey:CSV_KEY_AREA]
                                                      tag:JW_AREA
                                                 delegate:self
                                       showViewController:self];
            
            break;
            
        case JW_PROVINCE:
            
            if ([self.AreaLb.text isEqualToString:@"선택"]) {
                [[AlertManager sharedInstance] showAlertTitle:@"시도를 먼저 선택해주세요."
                                                         data:@[ @"닫기" ]
                                                          tag:JW_PROVINCE
                                                     delegate:nil
                                           showViewController:self];
            }
            else {
                [[AlertManager sharedInstance] showAlertTitle:@"군구"
                                                         data:[SystemManager AlertDataKey:[SystemManager ProvinceKey:self.AreaLb.text]]
                                                          tag:JW_PROVINCE
                                                     delegate:self
                                           showViewController:self];
            }
            
            break;
            
        case JW_PAYTYPE:
            
            [[AlertManager sharedInstance] showAlertTitle:@"지급"
                                                     data:[SystemManager AlertDataKey:CSV_KEY_PAYTYPE]
                                                      tag:JW_PAYTYPE
                                                 delegate:self
                                       showViewController:self];
            
            break;
            
        case JW_AGE:
            
            [[AlertManager sharedInstance] showAlertTitle:@"나이"
                                                     data:[SystemManager AlertDataKey:CSV_KEY_AGE]
                                                      tag:JW_AGE
                                                 delegate:self
                                       showViewController:self];
            
            break;
            
        case JW_SEX:
            
            [[AlertManager sharedInstance] showAlertTitle:@"성별"
                                                     data:@[ @"남성", @"여성" ]
                                                      tag:JW_SEX
                                                 delegate:self
                                       showViewController:self];
            
            break;
            
        case JW_TERM:
            
            [[AlertManager sharedInstance] showAlertTitle:@"기간"
                                                     data:self.TermMessageArray
                                                      tag:JW_TERM
                                                 delegate:self
                                       showViewController:self];
            
            break;
            
        case JW_IMAGE:
            
            [[AlertManager sharedInstance] showAlertTitle:@"앨범선택"
                                                     data:self.PhotoTitles
                                                      tag:JW_IMAGE
                                                 delegate:self
                                       showViewController:self];
            
            break;
            
        default:
            break;
    }
}

- (IBAction) Close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction) AdsWrite:(id)sender
{
    if ([self IsException])
    {
        HTTPRequest *request = [[HTTPRequest alloc] initWithTag:1];
        
        [request SendUrl:URL_ADS_WRITE_EDITOR withDictionary:[self getData]];
    }
    
}


#pragma mark - [ TEXTVIEW DELEGATE ]

- (void) textViewDidBeginEditing:(UITextView *)textView {
    textView.text = @"";
    [self.IntroductionTextView setTextColor:[UIColor blackColor]];
}

- (void) textViewDidEndEditing:(UITextView *)textView {
    
}

- (void) textViewDidChangeSelection:(UITextView *)textView {

}

- (void) textViewDidChange:(UITextView *)textView {
    
}

#pragma mark - [ COLLECTIONVIEW DELEGATE ]

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.ThemaTitles count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ThemaCollectionCell *cell = [self.ThemaCollectionView dequeueReusableCellWithReuseIdentifier:@"ThemaCollectionCell" forIndexPath:indexPath];
    
    [cell SetTitleText:[self.ThemaTitles objectAtIndex:indexPath.row]];
    [cell SetIconImageName:[self.ThemaImageNames objectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGSize) collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
   sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float w = collectionView.frame.size.width / 374.0f;
    
    return CGSizeMake(124 * w, 100 * w);
}


- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ThemaCollectionCell *cell = (ThemaCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    NSString *vStr = [self.EnableThema objectAtIndex:indexPath.row];
    int v = [vStr intValue];
    if (v == 0) {
        [self.EnableThema removeObjectAtIndex:indexPath.row];
        [self.EnableThema insertObject:@"1" atIndex:indexPath.row];
        [cell IsThemaEnable:true];
    }
    else {
        [self.EnableThema removeObjectAtIndex:indexPath.row];
        [self.EnableThema insertObject:@"0" atIndex:indexPath.row];
        [cell IsThemaEnable:false];
    }
}

#pragma mark - [ ALERTMANAGER DELEGATE ]

- (void) AlertManagerDidSelected:(NSInteger)tag withIndex:(NSInteger)index {
    switch (tag) {
        case JW_IMAGE:
            switch (index) {
                case 0: [self ShowPhoto]; break;
                case 1: [self ShowCamera]; break;
                case 2:
                    _JobTitleImg.image = [UIImage imageNamed:@"default_picture.png"];
                    break;
                default:
                    break;
            }
            break;
        case JW_TERM:
            self.TermLb.text = [NSString stringWithFormat:@"%@일", [self.TermArray objectAtIndex:index]];
            self.TermIndex = index;
            break;
        default:
            break;
    }
}

- (void) AlertManagerSelected:(NSString *)selectedString withTag:(NSInteger)tag {
    switch (tag) {
        case JW_SECTORS:
            _SectorLb.text = selectedString;            break;
        case JW_AREA:
            _AreaLb.text = selectedString;            break;
        case JW_PROVINCE:
            _ProvinceLb.text = selectedString;            break;
        case JW_PAYTYPE:
            _PayTypeLb.text = selectedString;            break;
        case JW_SEX:
            _SexLb.text = selectedString;            break;
        case JW_TERM:
            _TermLb.text = selectedString;            break;
        default:
            break;
    }
}


#pragma mark - [ PICKERVIEW DELEGATE ]

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    _JobTitleImg.image = img;
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - [ PROCESS ]

- (void) ShowCamera {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    
    imagePickerController.allowsEditing = YES;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}

- (void) ShowPhoto {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    
    imagePickerController.allowsEditing = YES;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}

- (NSDictionary *) getData {
    
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    
//    NSData *imageData = UIImagePNGRepresentation(self.JobTitleImg.image);
//    [data setValue:imageData forKey:@""];
    @try {
        [data setValue:[[SystemManager sharedInstance] UUID] forKey:@"device_id"];
        [data setValue:@"write"             forKey:@"write_type"];
        [data setValue:self.JobNameLb.text  forKey:@"company_name"];
        [data setValue:self.SectorLb.text   forKey:@"company_sector"];
        [data setValue:self.AreaLb.text     forKey:@"company_address1"];
        [data setValue:self.ProvinceLb.text forKey:@"company_address2"];
        [data setValue:self.AgeMinTf.text   forKey:@"company_agemin"];
        [data setValue:self.AgeMaxTf.text   forKey:@"company_agemax"];
        [data setValue:self.PayTf.text      forKey:@"company_payvalue"];
        [data setValue:self.PayTypeLb.text  forKey:@"companypay"];
        
        if ([self.SexLb.text isEqualToString:@"남성"])
        { [data setValue:@"1" forKey:@"company_sex"]; }
        else
        { [data setValue:@"2" forKey:@"company_sex"]; }
        
        [data setValue:self.PhoneNumTf.text forKey:@"company_phonenum"];
        [data setValue:self.IntroductionTextView.text forKey:@"company_content"];
        [data setValue:[self.TermArray objectAtIndex:self.TermIndex] forKey:@"ad_date"];
        
        NSString *ThemaStr = @"";
        for (int i = 0; i < self.EnableThema.count; i++) {
            
            NSString *v = [self.EnableThema objectAtIndex:i];
            NSString *comma = @",";
            if (i == self.EnableThema.count - 1) {
                comma = @"";
            }
            ThemaStr = [ThemaStr stringByAppendingFormat:@"%@%@", v, comma];
        }
        
        [data setValue:ThemaStr forKey:@"company_theme"];
    }
    @catch (NSException *ex) {
        NSLog(@"EX : %@", ex);
    }
    return data;
}

- (BOOL) IsException {
    int minAge = [self.AgeMinTf.text intValue];
    int maxAge = [self.AgeMaxTf.text intValue];
    
    bool exception = false;
    
    NSString *message = @"";
    
    if ([self.JobNameLb.text isEqualToString:@""]) {
        message = @"가게 이름이 입력되지 않았습니다.";
    }
    else if ([self.SectorLb.text isEqualToString:@"선택"]) {
        message = @"업종이 입력되지 않았습니다.";
    }
    else if ([self.AreaLb.text isEqualToString:@"선택"]) {
        message = @"시도가 입력되지 않았습니다.";
    }
    else if ([self.ProvinceLb.text isEqualToString:@"선택"]) {
        message = @"군구가 입력되지 않앗습니다.";
    }
    else if ((minAge <= 0) || (maxAge <= 0) || maxAge < minAge) {
        message = @"나이 입력값이 잘못 적용되어 있습니다.";
    }
    else if ([self.PayTf.text isEqualToString:@""]) {
        message = @"페이 금액이 입력되지 않았습니다.";
    }
    else if ([self.PayTypeLb.text isEqualToString:@"선택"]) {
        message = @"지급 방식이 입력되지 않았습니다.";
    }
    else if ([self.SexLb.text isEqualToString:@"선택"]) {
        message = @"성별이 입력되지 않았습니다.";
    }
    else if ([self.PhoneNumTf.text length] != 11) {
        message = @"연락처가 입력되지 않았습니다.";
    }
    else if ([self.TermLb.text isEqualToString:@"광고기간 선택"]) {
        message = @"게시 기간이 설정되지 않았습니다.";
    }
    else{
        exception = true;
    }
    
    if (!exception) {
        [[AlertManager sharedInstance] showAlertTitle:@""
                                              message:message
                                                 data:@[ @"닫기" ]
                                                  tag:0
                                             delegate:nil
                                   showViewController:self];
        return false;
    }
    else
        return true;
}

#pragma mark - [ HTTPREQUEST DELEGATE ]

- (void) HTTPRequestFinish:(NSDictionary *)data HttpTag:(HTTP_TAG)httpTag ReturnRequest:(id)request {
    NSLog(@"HTTP Request Finish : %d", (int)httpTag);
}

#pragma mark - [ TEXTFIELD DELEGATE ]

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    const char * _char = [string cStringUsingEncoding:NSUTF8StringEncoding];
    int isBackSpace = strcmp(_char, "\b");
    
    if (isBackSpace == -8) {
        return true;
    }
    
    if ([textField.text length] >= 11) {
        return false;
    }
    
    return YES;
}

@end
