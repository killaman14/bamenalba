//
//  JobInfoDetailView.m
//  bamenalba
//
//  Created by GSMAC on 2017. 6. 2..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "JobInfoDetailView.h"

@interface JobInfoDetailView () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;

@property (weak, nonatomic) IBOutlet UIStackView *StackView;
@end

@implementation JobInfoDetailView


- (id) initWithCoder:(NSCoder *)aDecoder data:(NSDictionary *)data
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [_ScrollView setContentSize:_ScrollView.frame.size];
    
    [_ScrollView resignFirstResponder];
    
    
    NSLog(@"Frame Size : %@", NSStringFromCGRect(_ScrollView.frame));
    
    NSLog(@"Stack View : %@", NSStringFromCGRect(_StackView.frame));
    
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



#pragma mark - [ EVENT ]

- (IBAction) Close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
 
