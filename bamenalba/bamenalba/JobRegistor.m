//
//  JobRegistor.m
//  bamenalba
//
//  Created by GSMAC on 2017. 5. 26..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "JobRegistor.h"

#import "ThemaCell.h"

@interface JobRegistor () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) NSArray *data;
@end

@implementation JobRegistor

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.data = @[@"초보가능", @"당일지급", @"경력우대", @"출퇴근자유", @"파트타임", @"차비지원", @"숙식제공", @"성형지원", @"선불가능"];
    
    [self.CollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ThemaCell class]) bundle:nil] forCellWithReuseIdentifier:@"ThemaCell"];

    [self.CollectionView setDelegate:self];
    [self.CollectionView setDataSource:self];
    
    
    NSLog(@"viewFrame : %@\nCollectionFrame : %@", NSStringFromCGRect(self.view.frame), NSStringFromCGRect(self.CollectionView.frame));
    
    [self.CollectionView setFrame:self.view.frame];
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

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.data count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ThemaCell *cell = [self.CollectionView dequeueReusableCellWithReuseIdentifier:@"ThemaCell" forIndexPath:indexPath];
    
    [[cell themaText] setText:[self.data objectAtIndex:indexPath.row]];
    
    return cell;
}


- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
