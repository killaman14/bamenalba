//
//  MeetingWrite.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 13..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "MeetingWrite.h"
#import "AlertManager.h"


@interface MeetingWrite () <AlertManagerDelegate>
@property (strong, nonatomic) NSArray *PhotoTitles;
@property (weak, nonatomic) NSString *IntroductionPlaceholder;
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - [ ACTION ]

- (IBAction) Close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction) TingSend:(id)sender {
    
}

- (IBAction) AlertShow:(id)sender {
    [[AlertManager sharedInstance] showAlertTitle:@"앨범선택"
                                             data:self.PhotoTitles
                                              tag:0
                                         delegate:self
                               showViewController:self];
}

#pragma mark - [ TEXTVIEW DELEGATE ]

- (void) textViewDidBeginEditing:(UITextView *)textView {
    textView.text = @"";
    [textView setTextColor:[UIColor blackColor]];
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
