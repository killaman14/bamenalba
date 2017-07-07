//
//  UIImageView+Cache.h
//  bamenalba
//
//  Created by Sejung Park on 2017. 7. 6..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView_Cache : NSObject
{
    NSMutableDictionary* mMemCache;
}


+ (UIImageView_Cache*)getInstance;

-(void) loadFromUrl: (NSURL*) url callback:(void (^)(UIImage *image))callback;

-(NSString*)md5:(NSString *)str;

-(UIImage*)saveToDisk:(UIImage*)image withKey:(NSString*)key;
-(UIImage*)loadFromDisk:(NSString*)key;

-(UIImage*)saveToMemory:(UIImage*)image withKey:(NSString*)key;
-(UIImage*)loadFromMemory:(NSString*)key;

-(UIImage*)makeThumbnail:(UIImage*)image;

@end
