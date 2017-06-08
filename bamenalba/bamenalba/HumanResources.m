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

@interface HumanResources () <UITableViewDelegate, UITableViewDataSource, SearchTopViewDelegate, HumanResourcesCellDelegate, AlertManagerDelegate, PostAlertDelegate>
@property (weak, nonatomic) IBOutlet UIView *TopView;

@property (weak, nonatomic) SearchTopView *_SearchTopView;

@property (weak, nonatomic) PostAlert *_PostAlert;

@property (weak, nonatomic) IBOutlet UITableView *TableView;
@end

@implementation HumanResources

@synthesize TopView;

@synthesize _SearchTopView;

@synthesize _PostAlert;

@synthesize TableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _SearchTopView = [[[NSBundle mainBundle] loadNibNamed:@"SearchTopView"
                                                    owner:self
                                                  options:nil] objectAtIndex:0];
    [_SearchTopView setFrame:CGRectMake(0, 0, TopView.frame.size.width, TopView.frame.size.height)];
    [_SearchTopView setDelegate:self];
    [TopView addSubview:_SearchTopView];
    
    NSLog(@"%@\n%@\n%@", NSStringFromCGRect(self.view.frame), NSStringFromCGRect(_SearchTopView.frame), NSStringFromCGRect(TopView.frame));
    
    [TableView setDelegate:self];
    [TableView setDataSource:self];
    [TableView registerNib:[UINib nibWithNibName:NSStringFromClass([HumanResourcesCell class]) bundle:nil] forCellReuseIdentifier:@"HumanResourcesCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



#pragma mark - [ TABLE VIEW DELEGATE ]

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HumanResourcesCell *cell = (HumanResourcesCell *) [tableView dequeueReusableCellWithIdentifier:@"HumanResourcesCell" forIndexPath:indexPath];
    
    [cell setDelegate:self];
    
    return cell;
}

- (double) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
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
    
    
}

- (void) CallPremiumButton {
    NSLog(@"CallPremiumButton %ld", [[[SystemManager TabbarController] tabBar] tag]);
    
}

- (void) CallDistanceButton {
    
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
    NSLog(@"Human Select : %@", selectedString);
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
