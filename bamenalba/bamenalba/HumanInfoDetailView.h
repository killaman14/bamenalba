//
//  HumanInfoDetailView.h
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 5..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HumanInfoDetailView : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *TitleImg;
@property (weak, nonatomic) IBOutlet UILabel *NicknameLb;
@property (weak, nonatomic) IBOutlet UILabel *AgeLb;
@property (weak, nonatomic) IBOutlet UILabel *SexLb;
@property (weak, nonatomic) IBOutlet UILabel *AreaLb;
@property (weak, nonatomic) IBOutlet UILabel *ProvinceLb;
@property (weak, nonatomic) IBOutlet UILabel *HopesectorLb;
@property (weak, nonatomic) IBOutlet UILabel *CommentLb;



- (void) SetData:(NSDictionary *)data;

- (IBAction) TitleImageZoom:(id)sender;

- (IBAction) PostSend:(id)sender;

- (IBAction) Close:(id)sender;
@end
