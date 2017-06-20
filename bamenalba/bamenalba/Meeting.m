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


@end

@implementation Meeting

@synthesize TopView;

@synthesize Table;

@synthesize _SearchTopView;

@synthesize data;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    data = [NSMutableArray array];
    [data addObject:@""]; [data addObject:@""]; [data addObject:@""]; [data addObject:@""]; [data addObject:@""];
    
    _SearchTopView = [[[NSBundle mainBundle] loadNibNamed:@"SearchTopView"
                                                    owner:self
                                                  options:nil] objectAtIndex:0];
    
    [_SearchTopView setFrame:CGRectMake(0, 0, self.view.frame.size.width, _SearchTopView.frame.size.height)];
    [_SearchTopView setDelegate:self];
    [TopView addSubview:_SearchTopView];
    
    Table.delegate = self;
    Table.dataSource = self;
//    [Table registerNib:[UINib nibWithNibName:NSStringFromClass([MeetingCell class]) bundle:nil] forCellReuseIdentifier:@"MeetingCell"];
    Table.rowHeight = UITableViewAutomaticDimension;
    Table.estimatedRowHeight = 140;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - [ TABLEVIEW DELEGATE ]

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.data count];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MeetingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeetingCell" forIndexPath:indexPath];
    
    return cell;
}




- (void) requestButton:(TOPVIEW_BUTTON)buttontype {
    NSLog(@"buttontype : %u", buttontype);
}

- (NSDictionary *) searchbarTitles {
    NSDictionary *titles = @{ SEARCHTOP_ONE_BUTTON : @"전체",
                              SEARCHTOP_TWO_BUTTON : @"근처",
                              SEARCHTOP_THREE_BUTTON : @"내꺼",
                              SEARCHTOP_RIGHT_BUTTON : @"번개팅 작성" };
    return titles;
}

@end
