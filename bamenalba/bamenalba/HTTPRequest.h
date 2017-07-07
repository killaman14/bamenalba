//
//  HttpRequest.h
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 19..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import <Foundation/Foundation.h>


#define DEFAULT_URL @"http://bamenalba.ivyro.net/"


#define SECRET_KEY @"321654"

#define POST_KEY @"data"



#define URL_LOGIN_CHECK @"login_check/check_login.php"
#define URL_SIGNUP @"login_check/member_join.php"

#define URL_ADS_LIST    @"ads_write/ads_list.php"
#define URL_ADS_DETAIL  @"ads_write/ads_detail.php"
#define URL_MEETING_LIST @"lting/lting_list.php"

typedef enum
{
    HTTP_SUCCESS = 1000,
    
    HTTP_FAIL       = 2000,
    HTTP_EMPLY_USER = 2001,
    HTTP_BLOCK      = 2002,

} HTTP_TAG;


@protocol HTTPRequestDelegate <NSObject>
- (void) HTTPRequestFinish:(NSDictionary *)data HttpTag:(HTTP_TAG)httpTag ReturnRequest:(id)request;
@optional
- (void) HTTPRequestFinish:(NSDictionary *)data RequestTag:(int)tag HttpTag:(HTTP_TAG)httpTag ReturnRequest:(id)request;
@end

@interface HTTPRequest : NSObject

@property (strong, nonatomic) id<HTTPRequestDelegate> delegate;

- (id) initWithTag:(NSInteger) tag;

- (void) SendUrl:(NSString *)url RequestTag:(int)tag withDictionary:(NSDictionary *)data;

- (void) SendUrl:(NSString *)url withDictionary:(NSDictionary *)data;
- (void) SendUrl:(NSString *)url withData:(NSData *)data;
@end
