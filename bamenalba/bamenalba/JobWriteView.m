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
    
    JW_IMAGE        = 8
} JW_BUTTONTAG;



@interface JobWriteView () <AlertManagerDelegate>


// [ THEMA ] ----------- >
@property (strong, nonatomic) NSArray *ThemaTitles;
@property (strong, nonatomic) NSArray *ThemaImageNames;
@property (strong, nonatomic) NSMutableArray *EnableThema;
// [ -------------------- ]
@property (strong, nonatomic) NSArray *PhotoTitles;


@property (assign) float width;
@property (assign) float height;

@property (weak, nonatomic) NSString *IntroductionPlaceholder;

@end

@implementation JobWriteView

#pragma mark - [ Variable ]

@synthesize IntroductionPlaceholder;



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
    
    self.EnableThema = [NSMutableArray array];
    self.ThemaTitles = @[@"초보가능", @"당일지급", @"경력우대", @"출퇴근자유", @"파트타임", @"차비지원", @"숙식제공", @"성형지원", @"선불가능"];
    self.ThemaImageNames = @[@"arrow.png",@"arrow.png",@"arrow.png",@"arrow.png",@"arrow.png",@"arrow.png",@"arrow.png",@"arrow.png",@"arrow.png"];
    
    self.PhotoTitles = @[ @"앨범", @"카메라", @"삭제", @"닫기" ];
    
    [self.ThemaCollectionView setDelegate:self];
    [self.ThemaCollectionView setDataSource:self];
    
    
    [self.ThemaCollectionView setFrame:CGRectMake(self.ThemaCollectionView.frame.origin.x, self.ThemaCollectionView.frame.origin.y, self.view.frame.size.width, self.ThemaCollectionView.frame.size.height)];
    
    self.width = [self.ThemaCollectionView frame].size.width / DEFAILT_COLLECTIONVIEW_WIDTH;
    self.height = [self.ThemaCollectionView frame].size.height / DEFAILT_COLLECTIONVIEW_HEIGHT;
    
    
    
    NSLog(@"\n%@\n%@\n%@", NSStringFromCGRect(self.view.frame), NSStringFromCGSize(self.ScrollView.contentSize), NSStringFromCGRect(self.ScrollView.frame));
    
    [self.ScrollView setFrame:CGRectMake(self.ScrollView.frame.origin.x, self.ScrollView.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            
            [[AlertManager sharedInstance] showAlertTitle:@"군구"
                                                     data:[SystemManager AlertDataKey:CSV_KEY_SECTOR]
                                                      tag:JW_PROVINCE
                                                 delegate:self
                                       showViewController:self];
            
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
                                                     data:@[ @"남자", @"여자" ]
                                                      tag:JW_SEX
                                                 delegate:self
                                       showViewController:self];
            
            break;
            
        case JW_TERM:
            
            [[AlertManager sharedInstance] showAlertTitle:@"기간"
                                                     data:@[ @"7일", @"14일", @"30일", @"90일" ]
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
    return CGSizeMake(DEFAILT_COLLECTIONCELL_WIDTH * self.width, DEFAILT_COLLECTIONCELL_HEIGHT * self.height);
}


- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ThemaCollectionCell *cell = (ThemaCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", [NSString stringWithFormat:@"%ld", (long)indexPath.row]];
    NSArray *d = [self.EnableThema filteredArrayUsingPredicate:predicate];
    
    if (d == nil || [d count] == 0) {
        [self.EnableThema addObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
        [cell IsThemaEnable:true];
        
    }
    else {
        NSMutableArray *removeItems = [NSMutableArray array];
        for(NSString *item in self.EnableThema) {
            if ([item isEqualToString:[NSString stringWithFormat:@"%ld", (long)indexPath.row]]) {
                [removeItems addObject:item];
                [cell IsThemaEnable:false];
            }
        }
        
        [self.EnableThema removeObjectsInArray:removeItems];
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
        default:
            break;
    }
}

- (void) AlertManagerSelected:(NSString *)selectedString withTag:(NSInteger)tag {
    NSLog(@"Selected String : %@    Tag : %u", selectedString, (JW_BUTTONTAG)tag);
    
    switch (tag) {
        case JW_SECTORS:
            _SectorLb.text = selectedString;            break;
        case JW_AREA:
            _AreaLb.text = selectedString;            break;
        case JW_PROVINCE:
            _ProvinceLb.text = selectedString;            break;
        case JW_PAYTYPE:
            _PayTypeLb.text = selectedString;            break;
        case JW_AGE:
            _AgeLb.text = selectedString;            break;
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
    
    NSDictionary *data = [NSDictionary dictionary];
    
    NSData *imageData = UIImagePNGRepresentation(self.JobTitleImg.image);
    [data setValue:imageData forKey:@""];
    [data setValue:self.JobNameLb.text forKey:@""];
    [data setValue:self.SectorLb.text forKey:@""];
    [data setValue:self.AreaLb.text forKey:@""];
    [data setValue:self.ProvinceLb.text forKey:@""];
    [data setValue:self.PayMinTf.text forKey:@""];
    [data setValue:self.PayMaxTf.text forKey:@""];
    [data setValue:self.PayTypeLb.text forKey:@""];
    [data setValue:self.AgeLb.text forKey:@""];
    [data setValue:self.SexLb.text forKey:@""];
    [data setValue:self.PhoneNumTf.text forKey:@""];
    [data setValue:self.IntroductionTextView.text forKey:@""];
    [data setValue:self.TermLb.text forKey:@""];

    return data;
}

@end
