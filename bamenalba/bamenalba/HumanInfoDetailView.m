//
//  HumanInfoDetailView.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 5..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "HumanInfoDetailView.h"
#import "SystemManager.h"

#import "HTTPRequest.h"

@interface HumanInfoDetailView () <HTTPRequestDelegate>
@property (nonatomic, strong) NSMutableDictionary *Data;
@end

@implementation HumanInfoDetailView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.TitleImg.layer setMasksToBounds:YES];
    [self.TitleImg.layer setCornerRadius:10];
    
    /*
    [self.NicknameLb setText:[sampleData objectForKey:@"nick"]];
    [self.AgeLb setText:[sampleData objectForKey:@"age"]];
    [self.SexLb setText:[sampleData objectForKey:@"sex"]];
    [self.AreaLb setText:[sampleData objectForKey:@"area"]];
    [self.ProvinceLb setText:[sampleData objectForKey:@"pro"]];
    [self.HopesectorLb setText:[sampleData objectForKey:@"hop"]];
    [self.CommentLb setText:[sampleData objectForKey:@"comment"]];
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - [ EVENT ]

- (void) SetData:(NSDictionary *)data {
    
    NSMutableDictionary *requestData = [NSMutableDictionary dictionary];
    [requestData setObject:[data objectForKey:@"device_id"] forKey:@"device_id"];
    [requestData setObject:@"1" forKey:@"atype"];
    
    HTTPRequest *request = [[HTTPRequest alloc] initWithTag:0];
    [request setDelegate:self];
    [request SendUrl:URL_HUMAN_DETAIL withDictionary:requestData];
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

#pragma mark - [ HTTPREQUEST DELEGATE ]

- (void) HTTPRequestFinish:(NSDictionary *)data HttpTag:(HTTP_TAG)httpTag ReturnRequest:(id)request {
    
    if (httpTag == HTTP_SUCCESS)
    {
        self.Data = [data objectForKey:@"detail"];
        
        [self.NicknameLb setText:[self.Data objectForKey:@"user_nickname"]];
        [self.AgeLb setText:[self.Data objectForKey:@"user_age"]];
        [self.SexLb setText:[self.Data objectForKey:@"user_sex"]];
        [self.AreaLb setText:[self.Data objectForKey:@"user_add_01"]];
        [self.ProvinceLb setText:[self.Data objectForKey:@"user_add_02"]];
        [self.HopesectorLb setText:[self.Data objectForKey:@"user_sector"]];
        [self.CommentLb setText:[self.Data objectForKey:@"user_ment"]];
    }
}

@end
