//
//  JobInformation.m
//  bamenalba
//
//  Created by GSMAC on 2017. 5. 26..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "JobInformation.h"
#import "SearchTopView.h"
#import "JobInfoCell.h"
#import "JobInfoDetailView.h"
#import "JobWriteView.h"

#import "PostAlert.h"

#import "SystemManager.h"
#import "AlertManager.h"

#import "AppDelegate.h"

#import "HTTPRequest.h"

#import "KEY.h"


@interface JobInformation ()
<SearchTopViewDelegate, JobInfoCellDelegate, AlertManagerDelegate, HTTPRequestDelegate, PostAlertDelegate>
@property (strong, nonatomic) SearchTopView *_SearchTopView;

@property (strong, nonatomic) PostAlert *PAlert;

@property (nonatomic, strong) NSMutableArray *Data;

@property (weak, nonatomic) NSString *CityName;
@property (weak, nonatomic) NSString *ProvinceName;
@property (weak, nonatomic) NSString *DistanceText;

@property (assign) BOOL IsLoading;

@property (assign, nonatomic) NSInteger Page;
@property (assign, nonatomic) NSInteger TPage;
@end



@implementation JobInformation


@synthesize TopView;
@synthesize Table;
@synthesize Data;

@synthesize _SearchTopView;


- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void) InitLoadData {
    
    
    self.CityName = @"전체";
    self.ProvinceName = @"전체";
    self.DistanceText = @"거리순";
    
    [self loadInit];
    
    [self loadMore];
}

- (void) HTTPRequestFinish:(NSDictionary *)data HttpTag:(HTTP_TAG)httpTag ReturnRequest:(id)request {
    
    NSDictionary *Info = [NSDictionary dictionary];
    
    switch (httpTag) {
        case HTTP_SUCCESS:

            Info = [data objectForKey:@"info"];
            
            self.Page = [[Info objectForKey:@"cpage"] intValue];
            
            self.TPage = [[Info objectForKey:@"tpage"] intValue];
            
            [self.Table setClearsContextBeforeDrawing:YES];
            
            [self.Data addObjectsFromArray:[NSArray arrayWithArray:[data objectForKey:@"list"]]];
            
            [self.Table reloadData];
            break;
            
        default:
            break;
    }
    
    self.IsLoading = false;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Data = [NSMutableArray array];
    [Data removeAllObjects];
    
    self.PAlert = (PostAlert *)[[[NSBundle mainBundle] loadNibNamed:@"PostAlert" owner:self options:nil] firstObject];
    [self.PAlert setDelegate:self];
    
    _SearchTopView = [[[NSBundle mainBundle] loadNibNamed:@"SearchTopView"
                                                     owner:self
                                                   options:nil] objectAtIndex:0];
    
    [_SearchTopView setFrame:CGRectMake(0, 0, self.view.frame.size.width, _SearchTopView.frame.size.height)];
    [_SearchTopView setDelegate:self];
    [TopView addSubview:_SearchTopView];
    
    
    
    Table.delegate = self;
    Table.dataSource = self;
    Table.estimatedRowHeight = 110;
}

- (NSDictionary *) searchbarTitles {
    NSDictionary *titles = @{ SEARCHTOP_ONE_BUTTON : @"⚬ 전체(지역)",
                              SEARCHTOP_THREE_BUTTON : @"⚬ 거리순",
                              SEARCHTOP_RIGHT_BUTTON : @"⚬ 광고작성" };
    return titles;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - TableView Delegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [Data count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"JobInfoCell";
    JobInfoCell *cell = (JobInfoCell *) [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [cell setDelegate:self];
    [cell SetData:[Data objectAtIndex:indexPath.row] Index:indexPath.row];

    return cell;
}


#pragma mark - [ ALERT MANAGER Delegate ]

- (void) AlertManagerSelected:(NSString *)selectedString withTag:(NSInteger)tag
{
    if (tag == AlertDataArea) {
        self.CityName = selectedString;
        [_SearchTopView setText:selectedString ButtonType:TOPVIEW_LEFT_BUTTON_ONE];

        [self CallProvinceButton];
    }
    else if(tag == AlertDataProvince) {
        self.ProvinceName = selectedString;
        
        [_SearchTopView setText:selectedString ButtonType:TOPVIEW_LEFT_BUTTON_TWO];
        
        [self loadInit];
        
        [self loadMore];
    }
    else if(tag == AlertDataSort) {
        self.DistanceText = selectedString;
        
        [_SearchTopView setText:selectedString ButtonType:TOPVIEW_LEFT_BUTTON_THREE];
        
        [self loadInit];
        
        [self loadMore];
    }
}


- (void) CallCityButton {
    
    NSMutableArray *data = [NSMutableArray arrayWithObject:@"전체"];
    [data addObjectsFromArray:[SystemManager AlertDataKey:CSV_KEY_AREA]];
    
    [[AlertManager sharedInstance] showAlertTitle:@"지역선택"
                                             data:data
                                              tag:AlertDataArea
                                         delegate:self
                               showViewController:self];
}


- (void) CallProvinceButton
{
    if ([self.CityName isEqualToString:@"전체"]) {
        [_SearchTopView setHidden:YES ButtonType:TOPVIEW_LEFT_BUTTON_TWO];
        
        self.ProvinceName = @"전체";
        
        [self loadInit];
        
        [self loadMore];
    }
    else {
        NSString *provinceKey = [SystemManager ProvinceKey:self.CityName];
        
        [[AlertManager sharedInstance] showAlertTitle:@"지역선택"
                                                 data:[SystemManager AlertDataKey:provinceKey]
                                                  tag:AlertDataProvince
                                             delegate:self
                                   showViewController:self];
    }
}

- (void) CallDistanceButton {

    [[AlertManager sharedInstance] showAlertTitle:@"정렬"
                                             data:@[ @"거리순", @"등록순", @"나의글" ]
                                              tag:AlertDataSort
                                         delegate:self
                               showViewController:self];
    
}

#pragma mark - [ SEARCH TOP VIEW DELEGATE ]

- (void) requestButton:(TOPVIEW_BUTTON)buttontype
{
    switch (buttontype) {
        case TOPVIEW_LEFT_BUTTON_ONE:
            [self CallCityButton];
            break;
        case TOPVIEW_LEFT_BUTTON_TWO:
            [self CallProvinceButton];
        case TOPVIEW_LEFT_BUTTON_THREE:
            [self CallDistanceButton];
            break;
        case TOPVIEW_RIGHT_BUTTON:
            [self storyBoardViewLoad:@"JobWriteView"];
        default:
            break;
    }
}

#pragma mark - [ JobInfoCell Delegate ]

- (void) CallDetailButton:(int) index{
    
    NSDictionary *data = [self.Data objectAtIndex:index];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    JobInfoDetailView *vc = [sb instantiateViewControllerWithIdentifier:@"JobInfoDetailView"];
    [vc InitLoadData:data];
    [self presentViewController:vc animated:YES completion:NULL];
}

- (void) CallPostButton:(int) index {
    [self.PAlert SetData:[self.Data objectAtIndex:index]];
    [self.PAlert Show:self.view];
}

- (void) CallEditButton:(int)index {
    
    NSDictionary *data = [self.Data objectAtIndex:index];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    JobWriteView *vc = [sb instantiateViewControllerWithIdentifier:@"JobInfoDetailView"];
//    [vc InitLoadData:data];
    [self presentViewController:vc animated:YES completion:NULL];
}

- (void) CallDeleteButton:(int)index {
    
}

- (void) PostAlertClose {
    [self.view willRemoveSubview:self.PAlert];
}

#pragma mark - [ PROCESS ]

- (void) storyBoardViewLoad:(NSString *)identifier {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:identifier];
    [self presentViewController:vc animated:YES completion:NULL];
}

- (void) loadInit {
    self.IsLoading = false;
    
    self.Page = 0;
    self.TPage = 0;
    
    [self.Data removeAllObjects];
    [self.Table reloadData];
}

- (void) loadMore
{
    if (self.IsLoading == false)
    {
        self.IsLoading = true;
        
        self.Page = self.Page + 1;
        
        NSMutableDictionary *user_data = [NSMutableDictionary dictionary];
        
        [user_data setObject:[[SystemManager sharedInstance] UUID] forKey:KEY_DEVICE_ID];
        [user_data setObject:[NSString stringWithFormat:@"%ld", (long)self.Page] forKey:KEY_PAGE];
        [user_data setObject:self.CityName forKey:KEY_AREA];
        [user_data setObject:self.ProvinceName forKey:KEY_PROVINCE];
        [user_data setObject:self.DistanceText forKey:KEY_SORT];
        
        HTTPRequest *request = [[HTTPRequest alloc] initWithTag:1];
        [request setDelegate:self];
        [request SendUrl:URL_ADS_LIST withDictionary:user_data];
    }
}

#pragma mark - [ SCROLLVIEW DELEGATE ]

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float offset = (scrollView.contentOffset.y - (scrollView.contentSize.height - scrollView.frame.size.height));
    if (offset >= 0 && offset <= 5 && (self.TPage > self.Page)) {
        [self loadMore];
    }
}

@end
