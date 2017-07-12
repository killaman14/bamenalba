//
//  Meeting.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 13..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "Meeting.h"
#import "MeetingCell.h"

#import "HTTPRequest.h"
#import "SystemManager.h"

#import "SearchTopView.h"

#import "KEY.h"

@interface Meeting () <UITableViewDelegate, UITableViewDataSource, SearchTopViewDelegate, HTTPRequestDelegate>
@property (strong, nonatomic) SearchTopView *_SearchTopView;
@property (nonatomic, strong) NSMutableArray *Data;

@property (assign) BOOL IsLoading;

@property (assign, nonatomic) NSInteger Page;
@property (assign, nonatomic) NSInteger TPage;

@end

@implementation Meeting

@synthesize TopView;

@synthesize Table;

@synthesize _SearchTopView;

@synthesize Data;



- (void) InitLoadData {
    self.IsLoading = false;
    
    self.Page = 0;
    self.TPage = 0;
    
    [self.Data removeAllObjects];
    
    [self.Table reloadData];
    
    [self loadMore];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _SearchTopView = [[[NSBundle mainBundle] loadNibNamed:@"SearchTopView"
                                                    owner:self
                                                  options:nil] objectAtIndex:0];
    
    
    self.Data = [NSMutableArray array];
    
    [_SearchTopView setFrame:CGRectMake(0, 0, self.view.frame.size.width, _SearchTopView.frame.size.height)];
    [_SearchTopView setDelegate:self];
    [TopView addSubview:_SearchTopView];
    
    Table.delegate = self;
    Table.dataSource = self;
    Table.estimatedRowHeight = 40;
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
    return [self.Data count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MeetingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeetingCell" forIndexPath:indexPath];
    
    [cell setCellData:[Data objectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

#pragma mark - [ SEARCH TOP VIEW DELEGATE ]

- (NSDictionary *) searchbarTitles {
    NSDictionary *titles = @{ SEARCHTOP_ONE_BUTTON : @"전체",
                              SEARCHTOP_TWO_BUTTON : @"근처",
                              SEARCHTOP_THREE_BUTTON : @"내꺼",
                              SEARCHTOP_RIGHT_BUTTON : @"번개팅 작성" };
    return titles;
}

- (void) requestButton:(TOPVIEW_BUTTON)buttontype {
    if (buttontype == TOPVIEW_RIGHT_BUTTON) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"MeetingWrite"];
        [self presentViewController:vc animated:YES completion:NULL];
    }
    else if (buttontype == TOPVIEW_LEFT_BUTTON_ONE) {
        NSLog(@"ONE");
    }
    else if (buttontype == TOPVIEW_LEFT_BUTTON_TWO) {
        NSLog(@"TWO");
    }
    else if (buttontype == TOPVIEW_LEFT_BUTTON_THREE) {
        NSLog(@"THREE");
    }
}

- (BOOL) searchButtonActivity {
    return true;
}

#pragma mark - [ HTTP REQUEST DELEGATE ]

- (void) HTTPRequestFinish:(NSDictionary *)data HttpTag:(HTTP_TAG)httpTag ReturnRequest:(id)request {
    
    NSDictionary *Info = [NSDictionary dictionary];
    
    switch (httpTag) {
        case HTTP_SUCCESS:
            @try {
                Info = [data objectForKey:@"info"];
                
                self.Page = [[Info objectForKey:@"cpage"] intValue];
                
                self.TPage = [[Info objectForKey:@"tpage"] intValue];
                
                [self.Table setClearsContextBeforeDrawing:YES];
                
                [self.Data addObjectsFromArray:[NSArray arrayWithArray:[data objectForKey:@"list"]]];
                
                [self.Table reloadData];
            } @catch (NSException *exception) {
                NSLog(@"Exception : %@", exception);
            } @finally {
                
            }
            
            break;
            
        default:
            break;
    }
    
    self.IsLoading = false;
}

#pragma mark - [ PROCESS ]

- (void) loadMore
{
    if (self.IsLoading == false)
    {
        self.IsLoading = true;
        
        self.Page = self.Page + 1;
        
        NSMutableDictionary *user_data = [NSMutableDictionary dictionary];
        
        [user_data setObject:[[SystemManager sharedInstance] UUID] forKey:KEY_DEVICE_ID];
        [user_data setObject:[NSString stringWithFormat:@"%d", self.Page] forKey:KEY_PAGE];
        [user_data setObject:@"전체" forKey:KEY_AREA];
        [user_data setObject:@"전체" forKey:KEY_PROVINCE];
        [user_data setObject:@"전체" forKey:KEY_SORT];
        
        HTTPRequest *request = [[HTTPRequest alloc] initWithTag:1];
        [request setDelegate:self];
        [request SendUrl:URL_MEETING_LIST withDictionary:user_data];
    }

}

@end
