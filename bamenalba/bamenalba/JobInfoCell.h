//
//  JobInfoCell.h
//  bamenalba
//
//  Created by GSMAC on 2017. 5. 26..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum  {
    CATEGOTY,
    SEX,
    PAY_TYPE,
    PAY,
    CITY,
    PROVINCE,
    DISTANCE
} ITEM_TYPE;


@protocol JobInfoCellDelegate <NSObject>

@required
- (void) CallDetailButton:(int)index;
- (void) CallPostButton:(int)index;

@end

@interface JobInfoCell : UITableViewCell

/*
 [ 주소 ]
 */
@property (weak, nonatomic) IBOutlet UILabel *Address;

/*
 [ 이름(나이) ]
 */
@property (weak, nonatomic) IBOutlet UILabel *Name;

/*
 [ 아이템 적용 뷰 ]
 */
@property (weak, nonatomic) IBOutlet UIView *ItemView;


@property (weak, nonatomic) IBOutlet UIButton *DetailButton;

@property (weak, nonatomic) IBOutlet UIButton *PostButton;



/*
 [ 버튼 호출 시 Delegate 호출 ]
 */
@property (weak, nonatomic) id<JobInfoCellDelegate> delegate;

/*
 [ 아이템 데이터 ]
 */
@property (strong, nonatomic) NSMutableArray *Items;
@property (strong, nonatomic) NSMutableDictionary *ItemDatas;





- (void) SetData:(NSMutableDictionary *) dic Index:(NSInteger) index;

- (IBAction) CallDetail;
- (IBAction) CallPost;
@end
