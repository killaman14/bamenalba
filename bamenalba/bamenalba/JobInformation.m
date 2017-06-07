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

#import "SystemManager.h"
#import "AlertManager.h"

#import "AppDelegate.h"

@interface JobInformation ()
<UITableViewDelegate, UITableViewDataSource, SearchTopViewDelegate, JobInfoCellDelegate, AlertManagerDelegate>
@property (strong, nonatomic) SearchTopView *_SearchTopView;

@property (weak, nonatomic) NSString *CityName;
@property (weak, nonatomic) NSString *ProvinceName;
@end



@implementation JobInformation


@synthesize TopView;

@synthesize Table;

@synthesize data;



@synthesize _SearchTopView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SystemManager sharedInstance];

    
    data = [NSMutableArray array];
    
    [[[NSBundle mainBundle] loadNibNamed:@"SearchTopView"
                                   owner:self
                                 options:nil] objectAtIndex:0];
    
    _SearchTopView = [[[NSBundle mainBundle] loadNibNamed:@"SearchTopView"
                                                     owner:self
                                                   options:nil] objectAtIndex:0];
    [_SearchTopView setDelegate:self];
    [TopView addSubview:_SearchTopView];
    
    Table.delegate = self;
    Table.dataSource = self;
    [Table registerNib:[UINib nibWithNibName:NSStringFromClass([JobInfoCell class]) bundle:nil] forCellReuseIdentifier:@"JobInfoCell"];
    
    NSArray *address = @[ @"가락동 1번지", @"황금동 2번지", @"황금동 2번지" ];
    NSArray *name = @[ @"김실장", @"김마담", @"미미짱"];
    NSArray *age = @[ @"33", @"42", @"66" ];
    
    NSArray *category = @[ @"노래방", @"룸사롱/주점", @"가라오케" ];
    NSArray *sex = @[ @"남자", @"여자", @"여자" ];
    NSArray *pay_type = @[ @"일급", @"일급", @"주급" ];
    NSArray *pay = @[ @"500,000원", @"1,000,000원", @"500,000" ];
    NSArray *city = @[ @"부산", @"광주", @"제주" ];
    NSArray *province = @[ @"달동", @"광산구", @"제주시" ];
    NSArray *distance = @[ @"10km", @"0km", @"100km" ];
    
    for (int i = 0; i < 3; i++)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        [dic setObject:[address objectAtIndex:i] forKey:@"ADDRESS"];
        [dic setObject:[name objectAtIndex:i] forKey:@"NAME"];
        [dic setObject:[age objectAtIndex:i] forKey:@"AGE"];
        [dic setObject:[category objectAtIndex:i] forKey:@"CATEGORY"];
        [dic setObject:[sex objectAtIndex:i] forKey:@"SEX"];
        [dic setObject:[pay_type objectAtIndex:i] forKey:@"PAY_TYPE"];
        [dic setObject:[pay objectAtIndex:i] forKey:@"PAY"];
        [dic setObject:[city objectAtIndex:i] forKey:@"CITY"];
        [dic setObject:[province objectAtIndex:i] forKey:@"PROVINCE"];
        [dic setObject:[distance objectAtIndex:i] forKey:@"DISTANCE"];
        
        [data addObject:dic];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - TableView Delegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [data count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JobInfoCell *cell = (JobInfoCell *) [tableView dequeueReusableCellWithIdentifier:@"JobInfoCell" forIndexPath:indexPath];
    
    [cell setDelegate:self];
    
    [cell SetData:[data objectAtIndex:indexPath.row] Index:indexPath.row];
    
    return cell;
}

- (double) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}


#pragma mark - [ JobInfo Top View Delegate ]

- (void) AlertManagerSelected:(NSString *)selectedString withTag:(NSInteger)tag
{
    if (tag == AlertDataArea) {
        self.CityName = selectedString;
        [_SearchTopView SetCityLabelText:selectedString];
        
        [self CallProvinceButton];
    }
    else if(tag == AlertDataProvince) {
        self.ProvinceName = selectedString;
        [_SearchTopView SetProvinceLabelText:selectedString];
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

- (void) CallPremiumButton {
    NSLog(@"CallPrimiumButton");
}

- (void) CallDistanceButton {
    NSLog(@"CallDistanceButton");
}

#pragma mark - [ JobInfoCell Delegate ]

- (void) CallDetailButton:(int) index{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"JobInfoDetailView"];
    [self presentViewController:vc animated:YES completion:NULL];
}

- (void) CallPostButton:(int) index {
    NSLog(@"Post :  %d", index);
}



@end
