//
//  MainTabBarViewController.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 7. 5..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "MainTabBarViewController.h"

#import "JobInformation.h"
#import "Meeting.h"
#import "HumanResources.h"
#import "MemoBox.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setDelegate:self];
    
    [self setSelectedIndex:0];
    [self DataLoad:self.selectedIndex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) tabBar:(UITabBar *)tabBar willBeginCustomizingItems:(NSArray<UITabBarItem *> *)items {
    
}

- (void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
}

- (void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    [self DataLoad:self.selectedIndex];
}



- (void) DataLoad:(int)tabIndex {
    
    if (tabIndex == 0) {
        JobInformation *v = (JobInformation *)[self selectedViewController];
        [v InitLoadData];
    }
    else if (tabIndex == 1) {
        Meeting *v = (Meeting *)[self selectedViewController];
        [v InitLoadData];
    }
    else if (tabIndex == 2) {
        HumanResources *v = (HumanResources *)[self selectedViewController];
        [v InitLoadData];
    }
    else if (tabIndex == 3) {
        MemoBox *v = (MemoBox *)[self selectedViewController];
        [v InitLoadData];
    }
    else {
        
    }
}

- (void) SceneDataLoad:(id)viewcontroller {
    
}

@end
