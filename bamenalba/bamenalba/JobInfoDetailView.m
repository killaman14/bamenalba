//
//  JobInfoDetailView.m
//  bamenalba
//
//  Created by GSMAC on 2017. 6. 2..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "JobInfoDetailView.h"

@interface JobInfoDetailView () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation JobInfoDetailView

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



#pragma mark - [ TableView Delegate ]

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    return cell;
}

@end
 
