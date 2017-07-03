//
//  HttpRequest.h
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 19..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import <Foundation/Foundation.h>


#define DEFAULT_URL @"http://bamenalba.ivyro.net/"

#define POST_KEY @"data"



#define URL_LOGIN_CHECK @"login_check/check_login.php"

typedef enum
{
    HTTP_SUCCESS = 1000,
    
    HTTP_SECRET_KEY_ERROR = 2000,
    HTTP_EMPLY_USER = 2001,
    HTTP_BLOCK = 2002,

} HTTP_TAG;



@interface HTTPRequest : NSObject
- (void) SendUrl:(NSString *)url withData:(NSData *)data;
@end
