//
//  HttpRequest.h
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 19..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import <Foundation/Foundation.h>


#define DEFAULT_URL @"http://52.78.205.104/dev_main/protocol/1/"

#define POST_KEY @"info"

@interface HTTPRequest : NSObject



- (void) SendUrl:(NSString *)url withData:(NSData *)data;
@end
