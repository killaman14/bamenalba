//
//  JobWrite.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 9..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "JobWriteView.h"

#import "ThemaCell.h"


#define DEFAILT_COLLECTIONVIEW_WIDTH 390
#define DEFAILT_COLLECTIONVIEW_HEIGHT 120

#define DEFAILT_COLLECTIONCELL_WIDTH 100.0f
#define DEFAILT_COLLECTIONCELL_HEIGHT 30.0f

@interface JobWriteView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) NSArray *ThemaData;
@property (strong, nonatomic) NSMutableArray *EnableThema;

@property (assign) float width;
@property (assign) float height;
@end

@implementation JobWriteView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.EnableThema = [NSMutableArray array];
    self.ThemaData = @[@"초보가능", @"당일지급", @"경력우대", @"출퇴근자유", @"파트타임", @"차비지원", @"숙식제공", @"성형지원", @"선불가능"];
    
    [self.ThemaCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ThemaCell class]) bundle:nil] forCellWithReuseIdentifier:@"ThemaCell"];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction) Close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}




#pragma mark - [ COLLECTIONVIEW DELEGATE ]

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.ThemaData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ThemaCell *cell = [self.ThemaCollectionView dequeueReusableCellWithReuseIdentifier:@"ThemaCell" forIndexPath:indexPath];
    
    [[cell themaText] setText:[self.ThemaData objectAtIndex:indexPath.row]];
    
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
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", [NSString stringWithFormat:@"%ld", (long)indexPath.row]];
    NSArray *d = [self.EnableThema filteredArrayUsingPredicate:predicate];
    
    if (d == nil || [d count] == 0) {
        NSLog(@"추가");
        [self.EnableThema addObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
    }
    else {
        NSLog(@"삭제");
        NSMutableArray *removeItems = [NSMutableArray array];
        for(NSString *item in self.EnableThema) {
            if ([item isEqualToString:[NSString stringWithFormat:@"%ld", (long)indexPath.row]]) {
                [removeItems addObject:item];
            }
        }
        
        [self.EnableThema removeObjectsInArray:removeItems];
    }
}


@end
