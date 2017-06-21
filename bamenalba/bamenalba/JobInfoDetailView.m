//
//  JobInfoDetailView.m
//  bamenalba
//
//  Created by GSMAC on 2017. 6. 2..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "JobInfoDetailView.h"
#import "ThemaCollectionCell.h"

@interface JobInfoDetailView () <UIScrollViewDelegate, UITextViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;

@property (weak, nonatomic) IBOutlet UITextView *IntroduceTextView;

@property (strong, nonatomic) NSString *IntroduceText;

@property (strong, nonatomic) NSMutableDictionary *Data;


@property (strong, nonatomic) NSArray *ThemaTitles;
@property (strong, nonatomic) NSArray *ThemaImages;

@end

@implementation JobInfoDetailView

@synthesize IntroduceTextView;

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
        
    }
    return self;
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    ThemaTitles = @[ @"초보가능", @"당일지급", @"경력우대", @"출퇴근자유", @"파트타임", @"차비지원", @"숙식제공", @"성형지원", @"선불가능" ];
    ThemaImages = @[ @"arrow.png", @"arrow.png", @"arrow.png", @"arrow.png", @"arrow.png", @"arrow.png", @"arrow.png", @"arrow.png", @"arrow.png" ];
    
    
    [self.IntroduceTextView setDelegate:self];
    
    [self.IntroduceTextView setText:IntroduceText];
    [self.IntroduceTextView setTextColor:[UIColor lightGrayColor]];
    
    
    [self.ScrollView setDelegate:self];
    
    CGSize size = CGSizeMake(self.view.frame.size.width, self.ScrollView.contentSize.height);
    [self.ScrollView setContentSize:size];
    
    
    
    
    
    [CollectionView setDelegate:self];
    [CollectionView setDataSource:self];

    [_ScrollView setContentSize:_ScrollView.frame.size];
    
    [_ScrollView resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)Close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)Call:(id)sender {
    
}

- (IBAction)Post:(id)sender {
    
}

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
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    float w = CollectionView.frame.size.width / 398.0f;
    float h = CollectionView.frame.size.height / 209.67f;
    return CGSizeMake(100 * w, 60 * h);
}

#pragma mark - [ SCROLL VIEW DELEGATE ]




#pragma mark - [ TEXT VIEW DELEGATE ]

- (void) textViewDidBeginEditing:(UITextView *)textView {
    
    [self.ScrollView setContentOffset:CGPointMake(self.IntroduceTextView.frame.origin.x,
                                                  self.IntroduceTextView.frame.origin.y + self.IntroduceTextView.frame.size.height + [UIScreen mainScreen].bounds.size.height/2) ];
}

@end
