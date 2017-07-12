//
//  MeetingWrite.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 13..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "MeetingWrite.h"

#import "SystemManager.h"
#import "AlertManager.h"
#import "HTTPRequest.h"


@interface MeetingWrite () <AlertManagerDelegate, HTTPRequestDelegate>
@property (strong, nonatomic) NSArray *PhotoTitles;
@property (weak, nonatomic) NSString *IntroductionPlaceholder;

@property (assign, nonatomic) CGRect OldScrollFrame;
@property (assign, nonatomic) CGSize OldContentSize;
@end

@implementation MeetingWrite

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.PhotoTitles = @[ @"앨범", @"카메라", @"삭제", @"닫기" ];
    self.IntroductionPlaceholder = @"번개톡 내용을 작성하세요.\n\n(빠르게 인재를 구인광고할 때!\n\n(급하게 나의 일자리를 찾을 때 번개팅!)";
    
    [self.TitleImg.layer setMasksToBounds:YES];
    [self.TitleImg.layer setCornerRadius:10];
    
    [self.ContentTextView setDelegate:self];
    [self.ContentTextView setText:self.IntroductionPlaceholder];
    [self.ContentTextView setTextColor:[UIColor lightGrayColor]];
    [self.ContentTextView.layer setBorderWidth:1];
    [self.ContentTextView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    [self.ScrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
    self.OldContentSize = self.ScrollView.contentSize;
    self.OldScrollFrame = self.ScrollView.frame;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasHiden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)keyboardWasShown:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    int height = MIN(keyboardSize.height,keyboardSize.width);

    CGRect gr = self.ScrollView.frame;
    [self.ScrollView setFrame:CGRectMake(gr.origin.x, gr.origin.y, gr.size.width, gr.size.height - height)];

    [self.ScrollView setContentOffset:CGPointMake(self.ScrollView.contentOffset.x, [self.ContentTextView frame].origin.y)  animated:YES];
}

- (void) keyboardWasHiden:(NSNotification *)notification
{
    [self.ScrollView setFrame:self.OldScrollFrame];
    [self.ScrollView setContentSize:CGSizeMake(self.OldContentSize.width, self.OldContentSize.height-10)];
    [self.ScrollView setContentOffset:CGPointZero  animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - [ ACTION ]

- (IBAction) Close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction) TingSend:(id)sender {
    if (self.ContentTextView.text == self.IntroductionPlaceholder || [self.ContentTextView.text isEqualToString:@""])
    {
        [self.ContentTextView endEditing:YES];
        
        [[AlertManager sharedInstance] showAlertTitle:@"내용이 입력되지 않았습니다."
                                                 data:@[ @"닫기" ]
                                                  tag:0
                                             delegate:nil
                                   showViewController:self];
    }
    else {
        /*
         {
         "write_type":"write",
         "content":"미미쨩을 사랑해주세요~~",
         "device_id":"358094030852389"
         }
         */
        NSMutableDictionary *data = [NSMutableDictionary dictionary];
        [data setObject:@"write" forKey:@"write_type"];
        [data setObject:self.ContentTextView.text forKey:@"content"];
        [data setObject:[[SystemManager sharedInstance] UUID] forKey:@"device_id"];
        
        HTTPRequest *request = [[HTTPRequest alloc] initWithTag:0];
        [request SendUrl:URL_MEETING_WRITE_EDITOR withDictionary:data];
    }
}

- (IBAction) AlertShow:(id)sender {
    [[AlertManager sharedInstance] showAlertTitle:@"앨범선택"
                                             data:self.PhotoTitles
                                              tag:0
                                         delegate:self
                               showViewController:self];
}

- (IBAction) HideKeyboard:(id)sender {
    
}

#pragma mark - [ TEXTVIEW DELEGATE ]

- (void) textViewDidBeginEditing:(UITextView *)textView {
    textView.text = @"";
    [textView setTextColor:[UIColor blackColor]];
}

- (void) textViewDidEndEditing:(UITextView *)textView {
    if([textView.text length] == 0) {
        [self.ContentTextView setText:self.IntroductionPlaceholder];
        [self.ContentTextView setTextColor:[UIColor lightGrayColor]];
    }
}

#pragma mark - [ ALERTMANAGER DELEGATE ]

- (void) AlertManagerDidSelected:(NSInteger)tag withIndex:(NSInteger)index {
    switch (index) {
        case 0:
            [self ShowPhoto];
            break;
            
        case 1:
            [self ShowCamera];
            break;
            
        case 2:
            self.TitleImg.image = [UIImage imageNamed:@"default_picture.png"];
            break;
            
        default:
            break;
    }
}

#pragma mark - [ HTTPREQUEST DELEGATE ]

- (void) HTTPRequestFinish:(NSDictionary *)data HttpTag:(HTTP_TAG)httpTag ReturnRequest:(id)request {
    if (httpTag == HTTP_SUCCESS) {
        [self Close:nil];
    }
}

#pragma mark - [ PICKERVIEW DELEGATE ]

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.TitleImg.image = img;
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


@end
