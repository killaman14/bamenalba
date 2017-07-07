//
//  MemoBox.h
//  bamenalba
//
//  Created by GSMAC on 2017. 5. 26..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemoBox : UIViewController
@property (weak, nonatomic) IBOutlet UIView *TopView;
@property (weak, nonatomic) IBOutlet UITableView *TableView;

- (void) LoadData;

@end
