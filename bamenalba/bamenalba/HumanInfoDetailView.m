//
//  HumanInfoDetailView.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 5..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "HumanInfoDetailView.h"

@interface HumanInfoDetailView ()
@property (nonatomic, strong) NSMutableDictionary *sampleData;
@end

@implementation HumanInfoDetailView

@synthesize sampleData;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    sampleData = [NSMutableDictionary dictionary];
    
    [sampleData setObject:@"김마메" forKey:@"nick"];
    [sampleData setObject:@"22세" forKey:@"age"];
    [sampleData setObject:@"남자" forKey:@"sex"];
    [sampleData setObject:@"광주" forKey:@"area"];
    [sampleData setObject:@"광역시" forKey:@"pro"];
    [sampleData setObject:@"노래방" forKey:@"hop"];
    [sampleData setObject:@"하하하하하하" forKey:@"comment"];
    
    
    [self.TitleImg.layer setMasksToBounds:YES];
    [self.TitleImg.layer setCornerRadius:10];
    
    [self.NicknameLb setText:[sampleData objectForKey:@"nick"]];
    [self.AgeLb setText:[sampleData objectForKey:@"age"]];
    [self.SexLb setText:[sampleData objectForKey:@"sex"]];
    [self.AreaLb setText:[sampleData objectForKey:@"area"]];
    [self.ProvinceLb setText:[sampleData objectForKey:@"pro"]];
    [self.HopesectorLb setText:[sampleData objectForKey:@"hop"]];
    [self.CommentLb setText:[sampleData objectForKey:@"comment"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - [ ACTION ]

- (IBAction) TitleImageZoom:(id)sender {
    
}

- (IBAction) PostSend:(id)sender {
    
}

- (IBAction) Close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
