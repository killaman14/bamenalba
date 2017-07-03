//
//  SignUp.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 16..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "SignUp.h"

#import "SignUpInfo.h"

@interface SignUp ()
@property (strong, nonatomic) SignUpInfo *SUIViewController;
@end

@implementation SignUp

@synthesize SUIViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.UserView.layer setCornerRadius:5];
    [self.CompanyView.layer setCornerRadius:5];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SUIViewController = (SignUpInfo *) [sb instantiateViewControllerWithIdentifier:@"SignUpInfo"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction) User:(id)sender {
    [SUIViewController SignUpIsCompany:false];
    [self presentViewController:SUIViewController animated:YES completion:NULL];
}

- (IBAction) Company:(id)sender {
    [SUIViewController SignUpIsCompany:true];
    [self presentViewController:SUIViewController animated:YES completion:NULL];
}

- (void) Viewload {
    
}

@end
