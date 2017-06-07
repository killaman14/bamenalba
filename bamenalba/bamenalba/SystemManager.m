//
//  SystemManager.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 5. 30..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "SystemManager.h"
#import "CHCSVParser.h"




@interface SystemManager() <CHCSVParserDelegate, UITabBarDelegate, UITabBarControllerDelegate>
{
    NSMutableArray *Keys;
    
    NSMutableDictionary *ProvinceKeys;
    
    NSMutableDictionary *Data;
}

@property (assign, nonatomic) NSInteger ReadLineIndex;

@property (strong, nonatomic) NSMutableArray *Keys;

@property (strong, nonatomic) NSMutableDictionary *ProvinceKeys;

@property (strong, nonatomic) NSMutableDictionary *Data;

@property (strong, nonatomic) UITabBarController *Tabbar;

@end


@implementation SystemManager


@synthesize Keys;
@synthesize ProvinceKeys;
@synthesize Data;
@synthesize Tabbar;

@synthesize ReadLineIndex = _ReadLineIndex;

static SystemManager *sharedInstance = nil;




#pragma mark - EVENT

+ (id)sharedInstance {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,
                  ^{
                      sharedInstance = [[SystemManager alloc] init];
                      
                      [sharedInstance InitCSVLoad];
                      
                      [sharedInstance InitProvinceKeySetting];
                      
                      [sharedInstance InitTabbar];
                  });
    
    return sharedInstance;
}


+ (NSArray *) AlertDataKey:(NSString *)key {
    
    if ([sharedInstance Data] != nil) {
        if ([[[sharedInstance Data] allKeys] containsObject:key]) {
            return [[sharedInstance Data] objectForKey:key];
        }
    }
    
    return nil;
}

+ (NSString *) ProvinceKey:(NSString *)area {
    return [[sharedInstance ProvinceKeys] objectForKey:area];
}

+ (UITabBarController *) TabbarController {
    if (sharedInstance.Tabbar == nil) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        sharedInstance.Tabbar = [sb instantiateViewControllerWithIdentifier:@"TabBar"];
    }
    
    return sharedInstance.Tabbar;
}


- (BOOL) tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    NSLog(@"alsdkjflaskdj");
    return NO;
}


#pragma mark - [ PROCESSING ]

- (void) InitTabbar {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Tabbar = [sb instantiateViewControllerWithIdentifier:@"TabBar"];
    [Tabbar setDelegate:self];
}

- (void) InitProvinceKeySetting
{
    if (ProvinceKeys != nil) {
        [ProvinceKeys removeAllObjects];
    }
    else {
        ProvinceKeys = [[NSMutableDictionary alloc] init];
    }
    
    [ProvinceKeys setObject:CSV_KEY_SEOUL forKey:@"서울"];
    [ProvinceKeys setObject:CSV_KEY_GYEONGGI forKey:@"경기"];
    [ProvinceKeys setObject:CSV_KEY_BUSAN forKey:@"부산"];
    [ProvinceKeys setObject:CSV_KEY_INCHEON forKey:@"인천"];
    [ProvinceKeys setObject:CSV_KEY_DAEGU forKey:@"대구"];
    [ProvinceKeys setObject:CSV_KEY_GWANGJU forKey:@"광주"];
    [ProvinceKeys setObject:CSV_KEY_GYEONGNAM forKey:@"경남"];
    [ProvinceKeys setObject:CSV_KEY_CHUNGNAM forKey:@"충남"];
    [ProvinceKeys setObject:CSV_KEY_DAEJEON forKey:@"대전"];
    [ProvinceKeys setObject:CSV_KEY_CHUNGBUK forKey:@"충북"];
    [ProvinceKeys setObject:CSV_KEY_GYEONGSANGBUK forKey:@"경북"];
    [ProvinceKeys setObject:CSV_KEY_ULSAN forKey:@"울산"];
    [ProvinceKeys setObject:CSV_KEY_SEJONG forKey:@"세정"];
    [ProvinceKeys setObject:CSV_KEY_JEONBUK forKey:@"전북"];
    [ProvinceKeys setObject:CSV_KEY_GANGWON forKey:@"강원"];
    [ProvinceKeys setObject:CSV_KEY_JEONNAM forKey:@"전남"];
    [ProvinceKeys setObject:CSV_KEY_JEJU forKey:@"제주"];
}

- (void) InitCSVLoad {
    NSBundle *mainBundle = [NSBundle mainBundle];
    
    NSString *myFile = [mainBundle pathForResource: @"x" ofType: @"csv"];
    
    NSStringEncoding encoding = 0;
    
    NSInputStream *stream = [NSInputStream inputStreamWithFileAtPath:myFile];
    
    CHCSVParser *p = [[CHCSVParser alloc] initWithInputStream:stream usedEncoding:&encoding delimiter:';'];
    
    [p setRecognizesBackslashesAsEscapes:YES];
    
    [p setSanitizesFields:YES];
    
    [p setDelegate:self];
    
    [p parse];
}

- (void) parserDidBeginDocument:(CHCSVParser *)parser
{
    Data = [[NSMutableDictionary alloc] init];
    
    Keys = [[NSMutableArray alloc] init];
}

- (void) parser:(CHCSVParser *)parser didBeginLine:(NSUInteger)recordNumber
{
    self.ReadLineIndex = recordNumber;
}

- (void)parser:(CHCSVParser *)parser didReadField:(NSString *)field atIndex:(NSInteger)fieldIndex
{
    NSArray *arr = [field componentsSeparatedByString:@","];
   
    if (self.ReadLineIndex == 1)
    {
        for (int i = 0; i < arr.count; i++)
        {
            [Keys addObject:[arr objectAtIndex:i]];
            [Data setObject:[NSMutableArray array] forKey:[arr objectAtIndex:i]];
        }
    }
    
    else {
        for (int i = 0; i < arr.count; i++)
        {
            if (![[arr objectAtIndex:i] isEqualToString:@""])
            {
                [[Data objectForKey:[Keys objectAtIndex:i]] addObject:[arr objectAtIndex:i]];
            }
        }
    }
}

- (void)parser:(CHCSVParser *)parser didEndLine:(NSUInteger)recordNumber
{
    
}

- (void)parserDidEndDocument:(CHCSVParser *)parser
{
    NSLog(@"InitCSVLoad END");
}

- (void)parser:(CHCSVParser *)parser didFailWithError:(NSError *)error
{
    NSLog(@"ERROR: %@", error);
}

@end
