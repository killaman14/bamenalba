//
//  Meeting.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 13..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "Meeting.h"
#import "MeetingCell.h"

#import "SearchTopView.h"

@interface Meeting () <UITableViewDelegate, UITableViewDataSource, SearchTopViewDelegate>
@property (strong, nonatomic) SearchTopView *_SearchTopView;


@property (nonatomic, strong) NSMutableArray *sampleData;

@end

@implementation Meeting

@synthesize TopView;

@synthesize Table;

@synthesize _SearchTopView;

@synthesize sampleData;


- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _SearchTopView = [[[NSBundle mainBundle] loadNibNamed:@"SearchTopView"
                                                    owner:self
                                                  options:nil] objectAtIndex:0];
    
    
    self.sampleData = [NSMutableArray array];
    
    [self.sampleData addObject:@{ @"name":@"김봉자", @"sex":@"남자" , @"age":@"33세", @"dis":@"10km", @"time":@"2초", @"content":@"123" }];
    
    [self.sampleData addObject:@{ @"name":@"김봉자", @"sex":@"여자", @"age":@"34세", @"dis":@"10km", @"time":@"2초", @"content":@"123123123123123123123123123" }];
    
    [self.sampleData addObject:@{ @"name":@"김봉자", @"sex":@"남자", @"age":@"35세", @"dis":@"10km", @"time":@"2초", @"content":@"123123123123123123123123123\n123123123123123123123123123" }];
    
    [self.sampleData addObject:@{ @"name":@"김봉자", @"sex":@"여자", @"age":@"36세", @"dis":@"10km", @"time":@"2초", @"content":@"123123123123123123123123123\n123123123123123123123123123\n123123123123123123123123123" }];
    
    [self.sampleData addObject:@{ @"name":@"김봉자", @"sex":@"남자", @"age":@"37세", @"dis":@"10km", @"time":@"2초", @"content":@"123123123123123123123123123\n123123123123123123123123123\n123123123123123123123123123\n123123123123123123123123123" }];
    
    NSLog(@"sampleData : %lu", (unsigned long)self.sampleData.count);
    
    [_SearchTopView setFrame:CGRectMake(0, 0, self.view.frame.size.width, _SearchTopView.frame.size.height)];
    [_SearchTopView setDelegate:self];
    [TopView addSubview:_SearchTopView];
    
    Table.delegate = self;
    Table.dataSource = self;
    Table.estimatedRowHeight = 81;
    Table.rowHeight = UITableViewAutomaticDimension;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - [ TABLEVIEW DELEGATE ]

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sampleData count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MeetingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeetingCell" forIndexPath:indexPath];
    
    [cell setCellData:[sampleData objectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MeetingCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.frame.size.height < 81)
        return 81;
    else
        return UITableViewAutomaticDimension;
}



- (void) requestButton:(TOPVIEW_BUTTON)buttontype {
    if (buttontype == TOPVIEW_RIGHT_BUTTON) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"MeetingWrite"];
        [self presentViewController:vc animated:YES completion:NULL];
    }
}

- (NSDictionary *) searchbarTitles {
    NSDictionary *titles = @{ SEARCHTOP_ONE_BUTTON : @"전체",
                              SEARCHTOP_TWO_BUTTON : @"근처",
                              SEARCHTOP_THREE_BUTTON : @"내꺼",
                              SEARCHTOP_RIGHT_BUTTON : @"번개팅 작성" };
    return titles;
}

@end
