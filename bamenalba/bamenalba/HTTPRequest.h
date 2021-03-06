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
#define URL_GPS_UPDATE @"token/gps_m.php"
#define URL_SIGNUP @"login_check/member_join.php"

#define URL_ADS_LIST    @"ads_write/ads_list.php"
#define URL_ADS_DETAIL  @"ads_write/ads_detail.php"
#define URL_ADS_WRITE_EDITOR   @"ads_write/ads_management.php"

#define URL_MEETING_LIST @"lting/lting_list.php"
#define URL_MEETING_WRITE_EDITOR    @"lting/lting_management.php"

#define URL_HUMAN_LIST  @"hinfo/hinfo_list.php"
#define URL_HUMAN_DETAIL    @"hinfo/hinfo_detail.php"


#define URL_CHAT_LIST @"chat/chat_list.php"
#define URL_CAHT_CONTENT_LOAD @"chat/chat_room.php"

#define URL_POST_SEND @"token/push.php"

#define URL_MYINFO_LOAD @"hinfo/hinfo_detail.php"
#define URL_MYINFO_EDITOR @"login_check/member_fix.php"

#define URL_AUTO_RESPONDER @"token/autoresponder.php"

#define URL_CASH_UPDATE @"cash_info/cash_i.php"


typedef enum
{
    HTTP_SUCCESS = 1000,
    
    HTTP_FAIL       = 2000,
    HTTP_EMPLY_USER = 2001,
    HTTP_BLOCK      = 2002,
    HTTP_TEXT_UPLOAD_FAIL   = 2003,
    HTTP_IMAGE_UPLOAD_FAIL  = 2004,
    HTTP_INSUFFICIENT_CACHE = 2005,
    HTTP_CACHE_UPDATE_FAIL  = 2006,
    HTTP_QUERY_NULL         = 2007,
    HTTP_ACCOUNT_DUPLICATE  = 2008,

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
