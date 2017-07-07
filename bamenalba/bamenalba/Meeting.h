//
//  Meeting.h
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 13..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Meeting : UIViewController

@property (nonatomic, strong) IBOutlet UIView *TopView;
@property (nonatomic, strong) IBOutlet UITableView *Table;

- (void) InitLoadData;

@end
