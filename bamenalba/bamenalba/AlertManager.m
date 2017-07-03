//
//  AlertManager.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 5. 31..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "AlertManager.h"

@implementation AlertManager

static AlertManager *sharedInstance = nil;

+ (id)sharedInstance {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,
                  ^{
                      sharedInstance = [[AlertManager alloc] init];
                  });
    
    return sharedInstance;
}

- (void) showAlertTitle:(NSString *)title
                   data:(NSArray *)data
                    tag:(NSInteger)tag
               delegate:(id<AlertManagerDelegate>) delegate
     showViewController:(UIViewController *) viewController
{
    UIAlertController *actionSheet = [UIAlertController
                                      alertControllerWithTitle:title
                                      message:@""
                                      preferredStyle:UIAlertControllerStyleAlert];
    
    
    int index = 0;
    for (NSString *message in data)
    {
        UIAlertAction *action = [UIAlertAction actionWithTitle:message
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action)
                                 {
                                     if (delegate != nil)
                                     {
                                         if ([delegate respondsToSelector:@selector(AlertManagerSelected:withTag:)])
                                             [delegate AlertManagerSelected:message withTag:tag];
                                         
                                         if ([delegate respondsToSelector:@selector(AlertManagerDidSelected:withIndex:)])
                                             [delegate AlertManagerDidSelected:tag withIndex:index];
                                         
                                     }
                                 }];
        
        [actionSheet addAction:action];
        
        index++;
    }
    
    [actionSheet setModalPresentationStyle:UIModalPresentationPopover];
    [actionSheet.view setTintColor:[UIColor blackColor]];
    
    [viewController presentViewController:actionSheet animated:YES completion:nil];
}


@end
