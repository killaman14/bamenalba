//
//  JobInfoTopView.h
//  bamenalba
//
//  Created by GSMAC on 2017. 5. 26..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    TOPVIEW_LEFT_BUTTON_ONE = 0,
    TOPVIEW_LEFT_BUTTON_TWO,
    TOPVIEW_LEFT_BUTTON_THREE,
    
    TOPVIEW_RIGHT_BUTTON
} TOPVIEW_BUTTON;


@protocol SearchTopViewDelegate <NSObject>

@required
- (void) requestButton:(TOPVIEW_BUTTON) buttontype;

@end

@interface SearchTopView : UIView

@property (weak, nonatomic) IBOutlet UIButton *LEFT_ONE_BUTTON;
@property (weak, nonatomic) IBOutlet UIButton *LEFT_TWO_BUTTON;
@property (weak, nonatomic) IBOutlet UIButton *LEFT_THREE_BUTTON;

@property (weak, nonatomic) IBOutlet UIButton *RIGHT_BUTTON;


@property (weak, nonatomic) id<SearchTopViewDelegate> delegate;

- (id) Init;

- (IBAction) Call:(id)sender;

- (void) setHidden:(BOOL)hidden ButtonType:(TOPVIEW_BUTTON) buttontype;
- (void) setText:(NSString *)text ButtonType:(TOPVIEW_BUTTON) buttontype;

@end
