//
//  MeetingWrite.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 13..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "MeetingWrite.h"

@interface MeetingWrite ()

@end

@implementation MeetingWrite

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"\n%@\n%@\n%@", NSStringFromCGRect(self.view.frame), NSStringFromCGSize(self.ScrollView.contentSize), NSStringFromCGRect(self.ScrollView.frame));
    
    [self.ScrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction) Close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
