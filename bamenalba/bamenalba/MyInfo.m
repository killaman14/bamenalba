//
//  MyInfo.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 9..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "MyInfo.h"

#import "UIImageView+Corner.h"

#import "AlertManager.h"
#import "SystemManager.h"
#import "HTTPRequest.h"

typedef enum {
    MI_ALERT_ALBUM      = 0,
    MI_ALERT_AGE        = 1,
    MI_ALERT_AREA       = 2,
    MI_ALERT_PROVINCE   = 3,
    MI_ALERT_SECTOR     = 4,
    MI_ALERT_COMMENT    = 5,
    
    MI_PHOTO_ALBUM  = 50,
    MI_PHOTO_CAMERA = 51,
    MI_PHOTO_DELETE = 52,
    
    MI_NICK_EXCEPTION = 8,
    MI_SECRETKEY_EXCEPTION = 11,
    
    MI_HTTP_DATALOAD = 100,
    MI_HTTP_FIX      = 101,
} MI_TAG;

@interface MyInfo () <AlertManagerDelegate, HTTPRequestDelegate>

@property (assign, nonatomic) CGRect OldScrollFrame;
@property (assign, nonatomic) CGSize OldContentSize;

@property (strong, nonatomic) NSArray *PhotoTitles;

@property (strong, nonatomic) NSDictionary *Data;
@end

@implementation MyInfo

@synthesize Data;

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setObject:[[SystemManager sharedInstance] AccountNumber] forKey:@"atype"];
    [data setObject:[[SystemManager sharedInstance] UUID] forKey:@"device_id"];
    
    HTTPRequest *request = [[HTTPRequest alloc] initWithTag:MI_HTTP_DATALOAD];
    [request setDelegate:self];
    [request SendUrl:URL_MYINFO_LOAD withDictionary:data];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Data = [NSDictionary dictionary];
    
    self.PhotoTitles = @[ @"앨범", @"카메라", @"삭제", @"닫기" ];
    
    [self.MyImage.layer setCornerRadius:10];
    [self.MyImage.layer setMasksToBounds:YES];
    
    [self.NickTf setDelegate:self];
    [self.SecretKeyTf setDelegate:self];
    [self.SecretKeyTf.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasHiden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardhide:)];
    [tapGesture setDelegate:self];
    [self.ScrollView addGestureRecognizer:tapGesture];
}

- (void) keyboardhide:(id)sender {
    [self.ScrollView endEditing:YES];
}

- (void)keyboardWasShown:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    int height = MIN(keyboardSize.height,keyboardSize.width);
    
    CGRect gr = self.ScrollView.frame;
    [self.ScrollView setFrame:CGRectMake(gr.origin.x, gr.origin.y, gr.size.width, gr.size.height - height)];
    [self.ScrollView setContentSize:CGSizeMake(self.ScrollView.contentSize.width, self.ScrollView.contentSize.height)];
}

- (void) keyboardWasHiden:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    int height = MIN(keyboardSize.height,keyboardSize.width);
    
    CGRect gr = self.ScrollView.frame;
    [self.ScrollView setFrame:CGRectMake(gr.origin.x, gr.origin.y, gr.size.width, gr.size.height + height)];
    
    [self.ScrollView setContentOffset:CGPointZero animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - [ ACTION ]

- (IBAction) AlertShow:(id)sender
{
    [self keyboardWasHiden:nil];
    [self.ScrollView endEditing:YES];
    
    switch ([sender tag]) {
        case MI_ALERT_ALBUM:
            // 앨범 //
            [[AlertManager sharedInstance] showAlertTitle:@"앨범"
                                                     data:self.PhotoTitles
                                                      tag:MI_ALERT_ALBUM
                                                 delegate:self
                                       showViewController:self];
            
            break;
            
        case MI_ALERT_AGE:
            // 나이 //
            [[AlertManager sharedInstance] showAlertTitle:@"나이"
                                                     data:[SystemManager AlertDataKey:CSV_KEY_AGE]
                                                      tag:MI_ALERT_AGE
                                                 delegate:self
                                       showViewController:self];
            break;
            
        case MI_ALERT_AREA:
            // 시도 //
            [[AlertManager sharedInstance] showAlertTitle:@"시도"
                                                     data:[SystemManager AlertDataKey:CSV_KEY_AREA]
                                                      tag:MI_ALERT_AREA
                                                 delegate:self
                                       showViewController:self];
            break;
            
        case MI_ALERT_PROVINCE:
            // 군구 //
            [[AlertManager sharedInstance] showAlertTitle:@"군구"
                                                     data:[SystemManager AlertDataKey:[SystemManager ProvinceKey:self.AreaLb.text]]
                                                      tag:MI_ALERT_PROVINCE
                                                 delegate:self
                                       showViewController:self];
            break;
            
        case MI_ALERT_SECTOR:
            // 업종 //
            [[AlertManager sharedInstance] showAlertTitle:@"업종"
                                                     data:[SystemManager AlertDataKey:CSV_KEY_SECTOR]
                                                      tag:MI_ALERT_SECTOR
                                                 delegate:self
                                       showViewController:self];
            break;
            
        case MI_ALERT_COMMENT:
            // 한마디 //
            
            
            [[AlertManager sharedInstance] showAlertTitle:@"한마디"
                                                     data:[SystemManager AlertDataKey:[[[SystemManager sharedInstance] AccountNumber] isEqualToString:@"1"] == true ? CSV_KEY_MENT : CSV_KEY_COMPANYMENT]
                                                      tag:MI_ALERT_COMMENT
                                                 delegate:self
                                       showViewController:self];
            break;
            
        default:
            break;
    }
}

- (IBAction) SegmentChangeValue:(id)sender
{
    if (self.SexSc.selectedSegmentIndex == 0) {
        [self.SexSc setTintColor:[UIColor blueColor]];
    }
    else {
        [self.SexSc setTintColor:[UIColor magentaColor]];
    }
}

- (IBAction) KeyExample:(id)sender
{
    
}

- (IBAction) SaveSend:(id)sender
{
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    
    [data setObject:@"fix" forKey:@"write_type"];
    [data setObject:[[SystemManager sharedInstance] UUID] forKey:@"device_id"];
    [data setObject:self.NickTf.text forKey:@"user_nickname"];
    [data setObject:[NSString stringWithFormat:@"%d", ([self.SexSc selectedSegmentIndex] + 1)] forKey:@"user_sex"];
    [data setObject:self.AgeLb.text forKey:@"user_age"];
    [data setObject:self.AreaLb.text forKey:@"user_add_01"];
    [data setObject:self.ProvinceLb.text forKey:@"user_add_02"];
    [data setObject:self.SectorLb.text forKey:@"user_sector"];
    [data setObject:self.CommentLb.text forKey:@"user_ment"];
    
    HTTPRequest *request = [[HTTPRequest alloc] initWithTag:MI_HTTP_FIX];
    [request setDelegate:self];
    [request SendUrl:URL_MYINFO_EDITOR withDictionary:data];
    
}

- (IBAction) Close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


#pragma mark - [ TEXTFIELD DELEGATE ]

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    const char * _char = [string cStringUsingEncoding:NSUTF8StringEncoding];
    int isBackSpace = strcmp(_char, "\b");
    
    if (isBackSpace == -8) {
        return YES;
    }
    
    if ([textField tag] == MI_NICK_EXCEPTION && [textField.text length] >= 8) {
        return NO;
    }
    else
    if ([textField tag] == MI_SECRETKEY_EXCEPTION && [textField.text length] >= 11) {
        return NO;
    }
    
    
    
    return YES;
}

#pragma mark - [ ALERTMANAGER DELEGATE ]

- (void) AlertManagerDidSelected:(NSInteger)tag withIndex:(NSInteger)index {

    if (tag == MI_ALERT_ALBUM)
    {
        switch (index + (MI_PHOTO_ALBUM)) {
            case MI_PHOTO_ALBUM:
                [self ShowPhoto];
                break;
            case MI_PHOTO_CAMERA:
                [self ShowCamera];
                break;
            case MI_PHOTO_DELETE:
                self.MyImage.image = [UIImage imageNamed:@"default_picture.png"];
                break;
            default:
                break;
        }
    }
    
}
                            
- (void) AlertManagerSelected:(NSString *)selectedString withTag:(NSInteger)tag {
    if (tag == MI_ALERT_AGE) {
        [self.AgeLb setText:[NSString stringWithFormat:@"%@ 세", selectedString]];
    }
    else if (tag == MI_ALERT_AREA) {
        [self.AreaLb setText:selectedString];
    }
    else if (tag == MI_ALERT_PROVINCE) {
        [self.ProvinceLb setText:selectedString];
    }
    else if (tag == MI_ALERT_SECTOR) {
        [self.SectorLb setText:selectedString];
    }
    else if (tag == MI_ALERT_COMMENT) {
        [self.CommentLb setText:selectedString];
    }
}

#pragma mark - [ HTTPREQUEST DELEGATE ]

- (void) HTTPRequestFinish:(NSDictionary *)data RequestTag:(int)tag HttpTag:(HTTP_TAG)httpTag ReturnRequest:(id)request {
    if (httpTag == HTTP_SUCCESS) {
        if (tag == MI_HTTP_DATALOAD) {
            self.Data = [data objectForKey:@"detail"];
            
            self.NickTf.text = [self.Data objectForKey:@"user_nickname"];
            self.AgeLb.text = [NSString stringWithFormat:@"%@세", [self.Data objectForKey:@"user_age"]];
            if ([[self.Data objectForKey:@"user_sex"] isEqualToString:@"M"]) {
                [self.SexSc setTintColor:[UIColor blueColor]];
                [self.SexSc setSelectedSegmentIndex:0];
            }
            else {
                [self.SexSc setTintColor:[UIColor magentaColor]];
                [self.SexSc setSelectedSegmentIndex:1];
            }
            self.SectorLb.text = [self.Data objectForKey:@"user_sector"];
            self.AreaLb.text = [self.Data objectForKey:@"user_add_01"];
            self.ProvinceLb.text = [self.Data objectForKey:@"user_add_02"];
            self.CommentLb.text = [self.Data objectForKey:@"user_ment"];
            self.SecretKeyTf.text = [self.Data objectForKey:@"acountkey"];
        }
    }
    request = nil;
}

- (void) HTTPRequestFinish:(NSDictionary *)data HttpTag:(HTTP_TAG)httpTag ReturnRequest:(id)request {
    
}

#pragma mark - [ PICKERVIEW DELEGATE ]

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.MyImage.image = img;
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

- (BOOL) IsException {
    if ([self.NickTf.text isEqualToString:@""]) {
        return false;
    }
    else if ([self.SecretKeyTf.text isEqualToString:@""]) {
        return false;
    }
    return true;
}

@end
