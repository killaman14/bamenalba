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
- (void) CallEditButton:(int)index;
- (void) CallDeleteButton:(int)index;

@end

@interface JobInfoCell : UITableViewCell

@property (assign, nonatomic) float scale;

@property (weak, nonatomic) IBOutlet UIImageView *TitleIMG;
/*
 [ 주소 ]
 */
@property (weak, nonatomic) IBOutlet UILabel *CompanyName;

/*
 [ 이름(나이) ]
 */
@property (weak, nonatomic) IBOutlet UILabel *Name;

/*
 [ 아이템 적용 뷰 ]
 */
@property (weak, nonatomic) IBOutlet UIView *ItemView;



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
- (IBAction) CallEdit;
- (IBAction) CallDelete;

@end
