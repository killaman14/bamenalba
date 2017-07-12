//
//  JobInfoDetailView.m
//  bamenalba
//
//  Created by GSMAC on 2017. 6. 2..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "JobInfoDetailView.h"

#import "PostAlert.h"

#import "ThemaCollectionCell.h"

#import "HTTPRequest.h"

#import "UIImage+ImageEffects.h"

@interface JobInfoDetailView () <HTTPRequestDelegate>



@property (strong, nonatomic) NSString *IntroduceText;

@property (strong, nonatomic) NSDictionary *Data;


@property (strong, nonatomic) NSArray *ThemaTitles;
@property (strong, nonatomic) NSArray *ThemaImages;

@property (strong, nonatomic) NSArray *Options;

@end

@implementation JobInfoDetailView

@synthesize IntroduceText;

@synthesize Data;


@synthesize ThemaTitles;
@synthesize ThemaImages;

@synthesize CollectionView;

- (id) initWithCoder:(NSCoder *)aDecoder data:(NSDictionary *)data
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        self.Data = [NSDictionary dictionary];
    }
    return self;
}

- (void) InitLoadData:(NSDictionary *) data {
    self.Data = data;

    HTTPRequest *request = [[HTTPRequest alloc] initWithTag:1];
    [request setDelegate:self];
    [request SendUrl:URL_ADS_DETAIL withDictionary:@{ @"prim_code" : [data objectForKey:@"prim_code"] }];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    ThemaTitles = @[ @"초보가능", @"당일지급", @"경력우대", @"출퇴근자유", @"파트타임", @"차비지원", @"숙식제공", @"성형지원", @"선불가능" ];
    ThemaImages = @[ @"option_1.png", @"option_2.png", @"option_3.png", @"option_4.png", @"option_5.png", @"option_6.png", @"option_7.png", @"option_8.png", @"option_9.png" ];

    [CollectionView setDelegate:self];
    [CollectionView setDataSource:self];
    
    
    [self.TitleImg.layer setCornerRadius:50];
    [self.TitleImg.layer setMasksToBounds:YES];
    [self.TitleImg.layer setBorderWidth:2];
    [self.TitleImg.layer setBorderColor:[UIColor whiteColor].CGColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (IBAction) Photo:(id)sender {
    
}

- (IBAction)Close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)Call:(id)sender {
    
}

- (IBAction)Post:(id)sender {
    PostAlert *pa = [[PostAlert alloc] init];
    
}

#pragma mark = [ COLLECTION VIEW DELEGATE ]

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"path");
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [ThemaTitles count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ThemaCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ThemaCollectionCell" forIndexPath:indexPath];
    
    [cell SetTitleText:[ThemaTitles objectAtIndex:indexPath.row]];
    [cell SetIconImageName:[ThemaImages objectAtIndex:indexPath.row]];
    
    if ([self.Options count] == [ThemaTitles count]) {
        [cell IsThemaEnable:[[self.Options objectAtIndex:indexPath.row] boolValue]];
    }
    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    float w = CollectionView.frame.size.width / 374.0f;
    
    return CGSizeMake(124 * w, 100 * w);
}


#pragma mark - [ HTTPRequest Delegate ]

- (void) HTTPRequestFinish:(NSDictionary *)data HttpTag:(HTTP_TAG)httpTag ReturnRequest:(id)request {
    if (httpTag == HTTP_SUCCESS) {
        self.Data = [data objectForKey:@"detail"];
        
        [self ContentLoadView];
        
    }
}

#pragma mark - [ PROCESS ]

- (void) ContentLoadView
{
    [self.TitleLb setText:[self.Data objectForKey:@"company_name"]];
    [self.CompanyNameLb setText:[self.Data objectForKey:@"company_name"]];
    
    [self.SectorLb setText:[self.Data objectForKey:@"company_sector"]];
    
    
#pragma - [ AREA + PROVINCE ]
    
    NSString *Area_ProvinceString = [NSString stringWithFormat:@"%@-%@",
                                     [self.Data objectForKey:@"company_address1"],
                                     [self.Data objectForKey:@"company_address2"]];
    [self.Area_ProvinceLb setText:Area_ProvinceString];
    
    
#pragma - [ PAY VALUE + PAY ]
    
    int intPayValue = [[self.Data objectForKey:@"company_payvalue"] intValue];
    NSString *PayValue;
    
    if (intPayValue > 0) {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber *myNumber = [NSNumber numberWithInteger:intPayValue];
        PayValue = [NSString stringWithFormat:@"%@ 원", [numberFormatter stringFromNumber:myNumber]];
    }
    else {
        PayValue = [self.Data objectForKey:@"company_payvalue"];
    }

    
    NSString *Pay_PayTypeString = [NSString stringWithFormat:@"%@ %@",
                                   PayValue,
                                   [self.Data objectForKey:@"company_pay"]];
    
    NSDictionary *PPAttribute = @{ NSForegroundColorAttributeName: [UIColor darkGrayColor] };
    
    NSMutableAttributedString *AttributePPString = [[NSMutableAttributedString alloc] initWithString:Pay_PayTypeString
                                                                                          attributes:PPAttribute];
    
    NSRange PPRange = [Pay_PayTypeString rangeOfString:PayValue];
    
    [AttributePPString setAttributes:@{ NSForegroundColorAttributeName: [UIColor colorWithRed:(238.0f/255.0f)
                                                                                        green:(44.0f/255.0f)
                                                                                         blue:(35.0f/255.0f)
                                                                                        alpha:1] }
                               range:NSMakeRange(0, PPRange.length + 1)];
    
    [self.Pay_PaytypeLb setAttributedText:AttributePPString];
    
#pragma - [ AGE + SEX ]
    
    UIColor *SexColor = [[self.Data objectForKey:@"company_sex"] isEqualToString:@"F"] ? [UIColor magentaColor] : [UIColor blueColor];
    
    NSString *Age_SexString = [NSString stringWithFormat:@"%@~%@ %@",
                               [self.Data objectForKey:@"company_agemin"],
                               [self.Data objectForKey:@"company_agemax"],
                               [[self.Data objectForKey:@"company_sex"] isEqualToString:@"M"] ? @"남성" : @"여성"];
    
    NSDictionary *ASAttribute = @{ NSForegroundColorAttributeName: SexColor };
    
    NSMutableAttributedString *AttributeASString = [[NSMutableAttributedString alloc] initWithString:Age_SexString
                                                                                          attributes:ASAttribute];
    
    NSRange ASRange = [Age_SexString rangeOfString:[NSString stringWithFormat:@"%@~%@",[self.Data objectForKey:@"company_agemin"],
                                                    [self.Data objectForKey:@"company_agemax"]]];
    
    [AttributeASString setAttributes:@{ NSForegroundColorAttributeName: [UIColor colorWithRed:(238.0f/255.0f)
                                                                                        green:(44.0f/255.0f)
                                                                                         blue:(35.0f/255.0f)
                                                                                        alpha:1] }
                               range:NSMakeRange(0, ASRange.length + 1)];
    
    [self.Sex_AgeLb setAttributedText:AttributeASString];
    
#pragma - [ OPTION ]
    
    NSString *OptionString = [self.Data objectForKey:@"option"];
    self.Options = [OptionString componentsSeparatedByString:@","];
    
    [self.CollectionView reloadData];
    
    float w = CollectionView.frame.size.width / 374.0f;
    
    CGSize cSize = CGSizeMake((124 * w) * 3, (100 * w) * 3);
    
    [CollectionView setFrame:CGRectMake(CollectionView.frame.origin.x, CollectionView.frame.origin.y, cSize.width, cSize.height)];
    
    UIView *cSuper = [CollectionView superview];
    

#pragma - [ INTRODUCE ]
    
    NSString *IntroduceString = [NSString stringWithFormat:@"%@", [self.Data objectForKey:@"company_content"]];
    
    [self.IntroduceLb setText:IntroduceString];
    
    
    
    
    [self.TitleBGImg setImage:[self imageWithBlurredImageWithImage:[UIImage imageNamed:@"intro_logo2.png"] andBlurInsetFromBottom:self.TitleBGImg.frame.size.height withBlurRadius:100]];
    
    [self blurImage:self.TitleImg.image withBottomInset:200 blurRadius:10];
    /*
     "img": "",
     "company_name": "광고 내용테스트",
     "company_sector": "BAR",
     "company_address1": "경남",
     "company_address2": "사천시",
     "company_payvalue": "1232",
     "company_pay": "시급",
     "company_sex": "F",
     "company_agemin": "22",
     "company_agemax": "35",
     "company_phonenum": "01018499595",
     "company_content": "환영합니다. ^^♥♥♥ n경남 사천시의 최고의 BAR 광고 내용테스트에서 여성 가족을 모십니다.nn항상 가족을 먼저 생각하는 저희 광고 내용테스트은(는) 대한민국 20세 이상 성인이면 됩니다!n초보라고 걱정하실 필요 없으세요.n자신감을 갖고 두두리세요!nn대학생, 알바, 투잡, 모두모두 환영이구요 웃으면서 일을 즐기면서 하시면 됩니다.n저희 가게는 테마는 초보가능, 출퇴근자유, 숙식제공, 선불가능의 테마를 지원합니다.nn항상 저희 광고 내용테스트은 여러분을 응원합니다.n언제든 쪽지,연락주세요n항상 기다리고 있습니다^^♥nn광고 내용테스트 ㅎㅎ올림",
     "option": "1,0,0,1,0,0,1,0,1",
     "r_date": "81"
     */
    
    
    
    UIImage *BG = [UIImage imageNamed:@"intro_logo2.png"];
    BG = [BG applyExtraLightEffect];
    [self.TitleBGImg setImage:BG];
}

- (UIImage*)imageWithBlurredImageWithImage:(UIImage*)image andBlurInsetFromBottom:(CGFloat)bottom withBlurRadius:(CGFloat)blurRadius{
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context =  UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -image.size.height);
    CGContextDrawImage(context, CGRectMake(0, 0, image.size.width, image.size.height), image.CGImage);
    CGContextDrawImage(context, CGRectMake(0, 0, image.size.width, bottom), [self blurImage: image withBottomInset: bottom blurRadius: blurRadius].CGImage);
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage*)blurImage:(UIImage*)image withBottomInset:(CGFloat)inset blurRadius:(CGFloat)radius{
    
    image =  [UIImage imageWithCGImage: CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, image.size.height - inset, image.size.width,inset))];
    
    CIImage *ciImage = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:ciImage forKey:kCIInputImageKey];
    [filter setValue:@(radius) forKey:kCIInputRadiusKey];
    
    CIImage *outputCIImage = filter.outputImage;
    CIContext *context = [CIContext contextWithOptions:nil];
    
    return [UIImage imageWithCGImage: [context createCGImage:outputCIImage fromRect:ciImage.extent]];
    
}

@end
