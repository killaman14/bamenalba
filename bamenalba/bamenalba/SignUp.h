//
//  SignUp.h
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 16..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUp : UIViewController


@property (weak, nonatomic) IBOutlet UIView *UserView;
@property (weak, nonatomic) IBOutlet UIView *CompanyView;

- (IBAction) User:(id)sender;
- (IBAction) Company:(id)sender;

@end
