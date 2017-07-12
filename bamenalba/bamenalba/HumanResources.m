//
//  HumanResources.m
//  bamenalba
//
//  Created by GSMAC on 2017. 5. 26..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "HumanResources.h"
#import "HumanInfoDetailView.h"
#import "HumanResourcesCell.h"
#import "SearchTopView.h"

#import "SystemManager.h"
#import "AlertManager.h"
#import "PostAlert.h"
#import "HTTPRequest.h"
#import "KEY.h"

@interface HumanResources () <SearchTopViewDelegate, HumanResourcesCellDelegate, AlertManagerDelegate, PostAlertDelegate, HTTPRequestDelegate>
@property (weak, nonatomic) SearchTopView *_SearchTopView;
@property (weak, nonatomic) PostAlert *_PostAlert;

@property (weak, nonatomic) NSString *CityText;
@property (weak, nonatomic) NSString *ProvinceText;

@property (strong, nonatomic) NSMutableArray *Data;

@property (assign) BOOL IsLoading;

@property (assign, nonatomic) NSInteger Page;
@property (assign, nonatomic) NSInteger TPage;
@end

@implementation HumanResources

@synthesize TopView;

@synthesize _SearchTopView;

@synthesize _PostAlert;

@synthesize TableView;

@synthesize Data;


- (void) InitLoadData {
    self.IsLoading = false;
    
    self.Page = 0;
    self.TPage = 0;
    
    if (Data != nil) {
        self.Data = [NSMutableArray array];
    }
    [Data removeAllObjects];
    
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
    
    [TableView setDelegate:self];
    [TableView setDataSource:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSDictionary *) searchbarTitles {
    NSDictionary *titles = @{ SEARCHTOP_ONE_BUTTON : @"전체(지역)", SEARCHTOP_RIGHT_BUTTON : @"성별-전체" };
    return titles;
}


#pragma mark - [ TABLE VIEW DELEGATE ]

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.Data count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HumanResourcesCell *cell = (HumanResourcesCell *) [tableView dequeueReusableCellWithIdentifier:@"HumanResourcesCell" forIndexPath:indexPath];
    
    [cell SetCellData:[self.Data objectAtIndex:indexPath.row]];
    
    [cell setDelegate:self];
    
    return cell;
}


#pragma mark - [ SEARCH VIEW DELEGATE ]

- (void) CallCityButton {
    [[AlertManager sharedInstance] showAlertTitle:@"지역선택"
                                             data:[SystemManager AlertDataKey:CSV_KEY_AREA]
                                              tag:AlertDataArea
                                         delegate:self
                               showViewController:self];
}

- (void) CallProvinceButton {
    
    NSString *provinceKey = [SystemManager ProvinceKey:self.CityText];
    
    [[AlertManager sharedInstance] showAlertTitle:@"지역선택"
                                             data:[SystemManager AlertDataKey:provinceKey]
                                              tag:AlertDataProvince
                                         delegate:self
                               showViewController:self];
}

- (void) CallSexButton {
    [[AlertManager sharedInstance] showAlertTitle:@"성별"
                                             data:@[ @"남자", @"여자" ]
                                              tag:AlertDataSex
                                         delegate:self
                               showViewController:self];
}

- (void) requestButton:(TOPVIEW_BUTTON)buttontype {
    switch (buttontype) {
        case TOPVIEW_LEFT_BUTTON_ONE:
            [self CallCityButton];
            break;
        case TOPVIEW_LEFT_BUTTON_TWO:
            [self CallProvinceButton];
            break;
        case TOPVIEW_RIGHT_BUTTON:
            [self CallSexButton];
        default:
            break;
    }
}


#pragma mark - [ CELL DELEGATE ]

- (void) CallDetailView:(NSDictionary *)data {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HumanInfoDetailView *vc = [sb instantiateViewControllerWithIdentifier:@"HumanInfoDetailView"];
    [vc SetData:data];
    [self presentViewController:vc animated:YES completion:NULL];
}

- (void) CallPost {
    _PostAlert = (PostAlert *)[[[NSBundle mainBundle] loadNibNamed:@"PostAlert" owner:self options:nil] firstObject];
    
    _PostAlert.frame = self.view.bounds;
    
    _PostAlert.alpha = 0.0f;
    
    [_PostAlert setUserInteractionEnabled:NO];
    
    [_PostAlert setDelegate:self];
    
    [self.view addSubview:_PostAlert];
    

    
    [UIView animateWithDuration:0.25f
                          delay:0.0f
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         _PostAlert.alpha = 1.0;
                     }
                     completion:^(BOOL finished){
                         [_PostAlert setUserInteractionEnabled:YES];
                     }];
}


#pragma mark - [ ALERT DELEGATE ]

- (void) AlertManagerSelected:(NSString *)selectedString withTag:(NSInteger)tag {
    switch (tag) {
        case AlertDataArea:
            self.CityText = selectedString;
            [_SearchTopView setText:selectedString ButtonType:TOPVIEW_LEFT_BUTTON_ONE];
            
            [self CallProvinceButton];
            break;
        case AlertDataProvince:
            [_SearchTopView setText:selectedString ButtonType:TOPVIEW_LEFT_BUTTON_TWO];
            break;
        case AlertDataSex:
            [_SearchTopView setText:selectedString ButtonType:TOPVIEW_RIGHT_BUTTON];
        default:
            break;
    }
}

#pragma mark - [ POST ALERT DELEGATE ]

- (void) PostAlertClose {
    
}

#pragma mark - [ HTTPREQUEST DELEGATE ]

- (void) HTTPRequestFinish:(NSDictionary *)data HttpTag:(HTTP_TAG)httpTag ReturnRequest:(id)request {
    
    if (httpTag == HTTP_SUCCESS)
    {
        self.Data = [data objectForKey:@"list"];
        
        [self.TableView reloadData];
    }
    
    self.IsLoading = false;
}

#pragma mark - [ EVENT ]

- (IBAction) Close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void) loadMore {
    if (self.IsLoading == false)
    {
        self.IsLoading = true;
        
        self.Page = self.Page + 1;
        
        NSMutableDictionary *user_data = [NSMutableDictionary dictionary];
        
        [user_data setObject:[[SystemManager sharedInstance] UUID] forKey:KEY_DEVICE_ID];
        [user_data setObject:[NSString stringWithFormat:@"%ld", (long)self.Page] forKey:KEY_PAGE];
        [user_data setObject:@"전체" forKey:KEY_AREA];
        [user_data setObject:@"전체" forKey:KEY_PROVINCE];
        [user_data setObject:@"전체" forKey:KEY_USER_SEX];
        
        HTTPRequest *request = [[HTTPRequest alloc] initWithTag:1];
        [request setDelegate:self];
        [request SendUrl:URL_HUMAN_LIST withDictionary:user_data];
    }
}

@end
