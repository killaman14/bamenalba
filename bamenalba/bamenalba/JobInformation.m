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

@property (weak, nonatomic) NSString *CityName;
@property (weak, nonatomic) NSString *ProvinceName;

@property (assign) BOOL IsLoading;

@property (assign, nonatomic) NSInteger Page;
@property (assign, nonatomic) NSInteger TPage;
@end



@implementation JobInformation


@synthesize TopView;
@synthesize Table;
@synthesize sampleData;

@synthesize _SearchTopView;


- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void) InitLoadData {
    self.IsLoading = false;
    
    self.Page = 0;
    self.TPage = 0;
    
    [self.sampleData removeAllObjects];
    
    [self.Table reloadData];
    
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
            
            [self.sampleData addObjectsFromArray:[NSArray arrayWithArray:[data objectForKey:@"list"]]];
            
            [self.Table reloadData];
            break;
            
        default:
            break;
    }
    
    self.IsLoading = false;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    sampleData = [NSMutableArray array];
    [sampleData removeAllObjects];
    
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
    return [sampleData count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"JobInfoCell";
    JobInfoCell *cell = (JobInfoCell *) [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [cell setDelegate:self];
    [cell SetData:[sampleData objectAtIndex:indexPath.row] Index:indexPath.row];

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
    }
    else if(tag == AlertDataSort) {
        [_SearchTopView setText:selectedString ButtonType:TOPVIEW_LEFT_BUTTON_THREE];
    }
}


- (void) CallCityButton {
    [[AlertManager sharedInstance] showAlertTitle:@"지역선택"
                                             data:[SystemManager AlertDataKey:CSV_KEY_AREA]
                                              tag:AlertDataArea
                                         delegate:self
                               showViewController:self];
}


- (void) CallProvinceButton
{
    NSString *provinceKey = [SystemManager ProvinceKey:self.CityName];
    
    [[AlertManager sharedInstance] showAlertTitle:@"지역선택"
                                             data:[SystemManager AlertDataKey:provinceKey]
                                              tag:AlertDataProvince
                                         delegate:self
                               showViewController:self];
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
    NSLog(@"requestButton : %u", buttontype);
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
    
    NSDictionary *data = [self.sampleData objectAtIndex:index];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    JobInfoDetailView *vc = [sb instantiateViewControllerWithIdentifier:@"JobInfoDetailView"];
    [vc InitLoadData:data];
    [self presentViewController:vc animated:YES completion:NULL];
}

- (void) CallPostButton:(int) index {
    [self.PAlert Show:self.view];
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


- (void) loadMore
{
    if (self.IsLoading == false)
    {
        self.IsLoading = true;
        
        self.Page = self.Page + 1;
        
        NSMutableDictionary *user_data = [NSMutableDictionary dictionary];
        
        [user_data setObject:[[SystemManager sharedInstance] UUID] forKey:KEY_DEVICE_ID];
        [user_data setObject:[NSString stringWithFormat:@"%ld", (long)self.Page] forKey:KEY_PAGE];
        [user_data setObject:@"전체" forKey:KEY_AREA];
        [user_data setObject:@"전체" forKey:KEY_PROVINCE];
        [user_data setObject:@"거리순" forKey:KEY_SORT];
        
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
        // This is the last cell so get more data
        NSLog(@"Load More");
        [self loadMore];
        //        [self loadmore];
    }
}

@end
