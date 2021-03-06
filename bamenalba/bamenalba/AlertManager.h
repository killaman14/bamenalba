//
//  AlertManager.h
//  bamenalba
//
//  Created by Sejung Park on 2017. 5. 31..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


enum AlertData
{
    AlertDataAge,
    
    AlertDataArea,
    AlertDataProvince,
    
    AlertDataSeoul,
    AlertDataGyeonggi,
    AlertDataBusan,
    AlertDataIncheon,
    AlertDataDaegu,
    AlertDataGwangju,
    AlertDataGyeongnam,
    AlertDataChungnam,
    AlertDataDaejeon,
    AlertDataChungbuk,
    AlertDataGyeongsangbuk,
    AlertDataUlsan,
    AlertDataSejong,
    AlertDataJeonbuk,
    AlertDataGangwon,
    AlertDataJeonnam,
    AlertDataJeju,
    
    
    AlertDataMent,
    AlertDataCompanyMent,
    AlertDataSector,
    AlertDataPayType,
    AlertDataInquireType,
    AlertDataSort,
    AlertDataSex,
};


@protocol AlertManagerDelegate <NSObject>

@optional
- (void) AlertManagerDidSelected:(NSInteger)tag withIndex:(NSInteger)index;
- (void) AlertManagerSelected:(NSString *)selectedString withTag:(NSInteger)tag;
@end



@interface AlertManager : NSObject

+ (id)sharedInstance;


- (void) showAlertTitle:(NSString *)title
                   data:(NSArray *)data
                    tag:(NSInteger)tag
               delegate:(id<AlertManagerDelegate>) delegate
     showViewController:(UIViewController *) viewController;

- (void) showAlertTitle:(NSString *)title
                message:(NSString *)message
                   data:(NSArray *)data
                    tag:(NSInteger)tag
               delegate:(id<AlertManagerDelegate>) delegate
     showViewController:(UIViewController *) viewController;

@end
