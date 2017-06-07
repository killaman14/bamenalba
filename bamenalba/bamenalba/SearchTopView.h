//
//  JobInfoTopView.h
//  bamenalba
//
//  Created by GSMAC on 2017. 5. 26..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchTopViewDelegate <NSObject>

@required
- (void) CallCityButton;
- (void) CallProvinceButton;
- (void) CallPremiumButton;
- (void) CallDistanceButton;

@end

@interface SearchTopView : UIView

@property (weak, nonatomic) IBOutlet UIButton *CityButton;

@property (weak, nonatomic) IBOutlet UIButton *ProvinceButton;

@property (weak, nonatomic) IBOutlet UIButton *PremiumButton;

@property (weak, nonatomic) IBOutlet UIButton *DistanceButton;


@property (weak, nonatomic) id<SearchTopViewDelegate> delegate;

- (void) SetCityLabelText:(NSString *)text;
- (void) SetProvinceLabelText:(NSString *)text;
- (void) SetPremiumLabelText:(NSString *)text;
- (void) SetDistanceLabelText:(NSString *)text;
@end
