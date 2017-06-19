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

@interface MemoBox () <UITableViewDelegate, UITableViewDataSource, SearchTopViewDelegate>
@property (weak, nonatomic) SearchTopView *_SearchTopView;
@end

@implementation MemoBox
@synthesize TopView;
@synthesize TableView;
@synthesize _SearchTopView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
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


#pragma mark - 

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MemoBoxCell *cell = (MemoBoxCell *) [tableView dequeueReusableCellWithIdentifier:@"MemoBoxCell" forIndexPath:indexPath];
    
    return cell;
}

@end
