//
//  MemoBox.m
//  bamenalba
//
//  Created by GSMAC on 2017. 5. 26..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "MemoBox.h"
#import "MemoBoxCell.h"

#import "SearchTopView.h"
#import "SystemManager.h"
#import "HTTPRequest.h"
#import "KEY.h"

@interface MemoBox () <SearchTopViewDelegate, HTTPRequestDelegate>
@property (weak, nonatomic) SearchTopView *_SearchTopView;

@property (strong, nonatomic) NSMutableArray *Data;

@property (assign) BOOL IsLoading;
@property (assign) int Page;
@property (assign) int TPage;
@end

@implementation MemoBox
@synthesize TopView;
@synthesize TableView;
@synthesize _SearchTopView;

@synthesize Data;

- (void) InitLoadData {
    
    self.IsLoading = false;
    
    self.Page = 0;
    self.TPage = 0;
    
    if (self.Data != nil) {
        self.Data = [NSMutableArray array];
    }
    [self.Data removeAllObjects];
    
    [self.TableView reloadData];
    
    
    [self loadMore];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Data = [NSMutableArray array];
    [self.Data removeAllObjects];
    
    _SearchTopView = [[[NSBundle mainBundle] loadNibNamed:@"SearchTopView"
                                                    owner:self
                                                  options:nil] objectAtIndex:0];
    [_SearchTopView setFrame:CGRectMake(0, 0, TopView.frame.size.width, TopView.frame.size.height)];
    [_SearchTopView setDelegate:self];
    
    [TopView addSubview:_SearchTopView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -

- (IBAction) Close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - 

- (void) requestButton:(TOPVIEW_BUTTON)buttontype {
    
}

- (NSDictionary *) searchbarTitles {
    NSDictionary *titles = @{ SEARCHTOP_RIGHT_BUTTON : @"전체-삭제" };
    return titles;
}


#pragma mark - [ TABLEVIEW DELEGATE ]

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.Data count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MemoBoxCell *cell = (MemoBoxCell *) [tableView dequeueReusableCellWithIdentifier:@"MemoBoxCell" forIndexPath:indexPath];
    
    [cell setCellData:[self.Data objectAtIndex:[indexPath row]]];
    
    
    return cell;
}


#pragma mark - [ HTTPREQUEST DELEGATE ]


- (void) HTTPRequestFinish:(NSDictionary *)data HttpTag:(HTTP_TAG)httpTag ReturnRequest:(id)request {
    if (httpTag == HTTP_SUCCESS) {
        self.Data = [data objectForKey:@"list"];
        
        [self.TableView reloadData];
    }
    /*
     "user_img":"http:\/\/bamenalba.ivyro.net\/img\/member_395004.jpg",
     "user_nickname":"\ubc30\uc2a4\uc2e0",
     "user_age":"28",
     "user_sex":"F",
     "content":"\u314e\u314e\u314e\u314e",
     "w_date":"2017-07-11 10:07:32",
     "d_date":"2017-07-11 10:09:04",
     "room_key":"3583526811",
     "distance":"245",
     "target_device":"352722070234532",
     "count":"0"
     */
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
//        [user_data setObject:@"352469074678179" forKey:KEY_DEVICE_ID];
        [user_data setObject:[NSString stringWithFormat:@"%ld", (long)self.Page] forKey:KEY_PAGE];
//        [user_data setObject:@"1" forKey:KEY_PAGE];

        HTTPRequest *request = [[HTTPRequest alloc] initWithTag:1];
        [request setDelegate:self];
        [request SendUrl:URL_CHAT_LIST withDictionary:user_data];
    }
}

@end
