//
//  SignUpInfo.h
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 16..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpInfo : UIViewController

@property (weak, nonatomic) IBOutlet UILabel* ExampleLb;

@property (weak, nonatomic) IBOutlet UITextField *NicknameTf;
@property (weak, nonatomic) IBOutlet UILabel *SectorLb;
@property (weak, nonatomic) IBOutlet UILabel *AreaLb;
@property (weak, nonatomic) IBOutlet UILabel *ProvinceLb;
@property (weak, nonatomic) IBOutlet UILabel *AgeLb;
@property (weak, nonatomic) IBOutlet UILabel *SexLb;
@property (weak, nonatomic) IBOutlet UILabel *CommentLb;




- (IBAction) AlertShow:(id)sender;


- (void) SignUpIsCompany:(BOOL) isCompany;

@end
