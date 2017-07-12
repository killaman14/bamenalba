//
//  JobInformation.h
//  bamenalba
//
//  Created by GSMAC on 2017. 5. 26..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobInformation : UIViewController <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIView *TopView;
@property (nonatomic, strong) IBOutlet UITableView *Table;




- (void) InitLoadData;

@end
