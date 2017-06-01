//
//  JobInfoTopView.h
//  bamenalba
//
//  Created by GSMAC on 2017. 5. 26..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JobInfoTopViewDelegate <NSObject>

@required
- (void) CallCityButton;
- (void) CallProvinceButton;
- (void) CallPrimiumButton;
- (void) CallDistanceButton;

@end

@interface JobInfoTopView : UIView

@property (weak, nonatomic) IBOutlet UIButton *CityButton;

@property (weak, nonatomic) IBOutlet UIButton *ProvinceButton;

@property (weak, nonatomic) id<JobInfoTopViewDelegate> delegate;

- (void) SetCityLabelText:(NSString *)text;
- (void) SetProvinceLabelText:(NSString *)text;
- (void) SetPrimiumLabelText:(NSString *)text;
- (void) SetDistanceLabelText:(NSString *)text;
@end
