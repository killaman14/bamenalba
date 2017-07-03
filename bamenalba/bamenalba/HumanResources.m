//
//  HumanResources.m
//  bamenalba
//
//  Created by GSMAC on 2017. 5. 26..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "HumanResources.h"
#import "HumanResourcesCell.h"
#import "SearchTopView.h"

#import "SystemManager.h"
#import "AlertManager.h"
#import "PostAlert.h"

@interface HumanResources () <SearchTopViewDelegate, HumanResourcesCellDelegate, AlertManagerDelegate, PostAlertDelegate>
@property (weak, nonatomic) SearchTopView *_SearchTopView;
@property (weak, nonatomic) PostAlert *_PostAlert;

@property (weak, nonatomic) NSString *CityText;
@property (weak, nonatomic) NSString *ProvinceText;

@property (strong, nonatomic) NSMutableArray *sampleData;
@end

@implementation HumanResources

@synthesize TopView;

@synthesize _SearchTopView;

@synthesize _PostAlert;

@synthesize TableView;


@synthesize sampleData;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sampleData = [NSMutableArray array];
    
    [self.sampleData addObject:@{ @"name" : @"도봉순", @"age" : @"22세", @"dis" : @"5km", @"coment" : @"안전한 일자리를 구하고 싶어요." }];
    [self.sampleData addObject:@{ @"name" : @"김군", @"age" : @"23세", @"dis" : @"6km", @"coment" : @"1234567890" }];
    [self.sampleData addObject:@{ @"name" : @"박군", @"age" : @"24세", @"dis" : @"7km", @"coment" : @"12345678901234567890" }];
    [self.sampleData addObject:@{ @"name" : @"문군", @"age" : @"25세", @"dis" : @"8km", @"coment" : @"123456789012345678901234567890" }];
    [self.sampleData addObject:@{ @"name" : @"성군", @"age" : @"26세", @"dis" : @"9km", @"coment" : @"1234567890123456789012345678901234567890" }];
    [self.sampleData addObject:@{ @"name" : @"손군", @"age" : @"27세", @"dis" : @"10km", @"coment" : @"12345678901234567890123456789012345678901234567890" }];
    
    _SearchTopView = [[[NSBundle mainBundle] loadNibNamed:@"SearchTopView"
                                                    owner:self
                                                  options:nil] objectAtIndex:0];
    [_SearchTopView setFrame:CGRectMake(0, 0, TopView.frame.size.width, TopView.frame.size.height)];
    [_SearchTopView setDelegate:self];
    
    [TopView addSubview:_SearchTopView];
    
    [TableView setDelegate:self];
    [TableView setDataSource:self];
//    [TableView registerNib:[UINib nibWithNibName:NSStringFromClass([HumanResourcesCell class]) bundle:nil] forCellReuseIdentifier:@"HumanResourcesCell"];
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
    return [self.sampleData count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HumanResourcesCell *cell = (HumanResourcesCell *) [tableView dequeueReusableCellWithIdentifier:@"HumanResourcesCell" forIndexPath:indexPath];
    
    [cell SetCellData:[self.sampleData objectAtIndex:indexPath.row]];
    
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

- (void) CallDetailView {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"HumanInfoDetailView"];
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
    
    _PostAlert.alpha = 1;
    
    
    [UIView animateWithDuration:0.25f
                          delay:0.0f
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         _PostAlert.alpha = 0.0;
                     }
                     completion:^(BOOL finished){
                         _PostAlert.delegate = nil;
                         [_PostAlert setUserInteractionEnabled:NO];
                         [self.view willRemoveSubview:_PostAlert];
                         
                         _PostAlert = nil;
                     }];
}


#pragma mark - [ EVENT ]

- (IBAction) Close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
