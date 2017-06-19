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


#define SEARCHTOP_ONE_BUTTON @"0"
#define SEARCHTOP_TWO_BUTTON @"1"
#define SEARCHTOP_THREE_BUTTON @"2"
#define SEARCHTOP_RIGHT_BUTTON @"3"


@protocol SearchTopViewDelegate <NSObject>
@required
- (void) requestButton:(TOPVIEW_BUTTON) buttontype;
@optional
- (NSDictionary *) searchbarTitles;

@end

@interface SearchTopView : UIView

@property (weak, nonatomic) IBOutlet UIButton *LEFT_ONE_BUTTON;
@property (weak, nonatomic) IBOutlet UIButton *LEFT_TWO_BUTTON;
@property (weak, nonatomic) IBOutlet UIButton *LEFT_THREE_BUTTON;

@property (weak, nonatomic) IBOutlet UIButton *RIGHT_BUTTON;


@property (weak, nonatomic) id<SearchTopViewDelegate> delegate;

- (IBAction) Call:(id)sender;

- (void) setHidden:(BOOL)hidden ButtonType:(TOPVIEW_BUTTON) buttontype;
- (void) setText:(NSString *)text ButtonType:(TOPVIEW_BUTTON) buttontype;

@end
