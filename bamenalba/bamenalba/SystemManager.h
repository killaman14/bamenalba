//
//  SystemManager.h
//  bamenalba
//
//  Created by Sejung Park on 2017. 5. 30..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define CSV_KEY_AGE         @"age"
#define CSV_KEY_SECTOR      @"sector"
#define CSV_KEY_PAYTYPE     @"paytype"
#define CSV_KEY_INQUIRETYPE @"inquiretype"
#define CSV_KEY_AREA        @"area"
#define CSV_KEY_SEOUL       @"seoul"
#define CSV_KEY_GYEONGGI    @"gyeonggi"
#define CSV_KEY_BUSAN       @"busan"
#define CSV_KEY_INCHEON     @"incheon"
#define CSV_KEY_DAEGU       @"daegu"
#define CSV_KEY_GWANGJU     @"gwangju"
#define CSV_KEY_GYEONGNAM   @"gyeongnam"
#define CSV_KEY_CHUNGNAM    @"chungnam"
#define CSV_KEY_DAEJEON     @"daejeon"
#define CSV_KEY_CHUNGBUK    @"chungbuk"
#define CSV_KEY_GYEONGSANGBUK @"gyeongsangbuk"
#define CSV_KEY_ULSAN       @"ulsan"
#define CSV_KEY_SEJONG      @"sejong"
#define CSV_KEY_JEONBUK     @"jeonbuk"
#define CSV_KEY_GANGWON     @"gangwon"
#define CSV_KEY_JEONNAM     @"JEONNAM"
#define CSV_KEY_JEJU        @"jeju"
#define CSV_KEY_MENT        @"ment"
#define CSV_KEY_COMPANYMENT @"company_ment"


#define APP_INIT            @"init"
#define APP_VERSION         @"version"
#define IS_SIGNUP           @"issignup"

@interface SystemManager : NSObject
{
    BOOL IsInit;
    BOOL IsSignUp;
    
    NSString *UUID;
    NSString *AccountNumber;
    
    NSDictionary *UserData;
}
@property (assign, nonatomic) BOOL IsSignUp;

@property (strong, nonatomic) NSString *UUID;
@property (strong, nonatomic) NSString *AccountNumber;
@property (assign, nonatomic) const NSString *PUSH_TOKEN;

@property (strong, nonatomic) NSDictionary *UserData;


+ (id)sharedInstance;

+ (NSArray *) AlertDataKey:(NSString *)key;

+ (NSString *) ProvinceKey:(NSString *)area;

+ (UITabBarController *) TabbarController;




- (NSString *) TimeSpace_WriteTime:(NSDate *)wt CurrentTime:(NSDate *)ct;

@end
