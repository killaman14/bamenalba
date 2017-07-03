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
} MI_TAG;

@interface MyInfo () <AlertManagerDelegate>
@property (strong, nonatomic) NSArray *PhotoTitles;
@end

@implementation MyInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.PhotoTitles = @[ @"앨범", @"카메라", @"삭제", @"닫기" ];
    
    [self.MyImage.layer setCornerRadius:10];
    [self.MyImage.layer setMasksToBounds:YES];
    
    [self.SecretKeyTf.layer setBorderColor:[UIColor darkGrayColor].CGColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - [ ACTION ]

- (IBAction) AlertShow:(id)sender
{
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
                                                     data:[SystemManager AlertDataKey:CSV_KEY_AREA]
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
    NSLog(@"%@", [self.SexSc titleForSegmentAtIndex:self.SexSc.selectedSegmentIndex]);
}

- (IBAction) KeyExample:(id)sender
{
    
}

- (IBAction) SaveSend:(id)sender
{
    
}

- (IBAction) Close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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

@end
