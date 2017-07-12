//
//  SystemManager.m
//  bamenalba
//
//  Created by Sejung Park on 2017. 5. 30..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "SystemManager.h"
#import "CHCSVParser.h"

#import <math.h>


@interface SystemManager() <CHCSVParserDelegate, UITabBarDelegate, UITabBarControllerDelegate>
{
    NSMutableArray *CSVKeys;
    
    NSMutableDictionary *CSVProvinceKeys;
    
    NSMutableDictionary *CSVData;
}

@property (assign, nonatomic) NSInteger ReadLineIndex;

@property (strong, nonatomic) NSMutableArray *CSVKeys;

@property (strong, nonatomic) NSMutableDictionary *CSVProvinceKeys;

@property (strong, nonatomic) NSMutableDictionary *CSVData;

@property (strong, nonatomic) UITabBarController *Tabbar;

@end


@implementation SystemManager

@synthesize UserData;

@synthesize CSVKeys;
@synthesize CSVProvinceKeys;
@synthesize CSVData;
@synthesize Tabbar;

@synthesize IsSignUp;
@synthesize UUID;
@synthesize PUSH_TOKEN;

@synthesize ReadLineIndex = _ReadLineIndex;

static SystemManager *sharedInstance = nil;




#pragma mark - EVENT

+ (id)sharedInstance {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,
                  ^{
                      sharedInstance = [[SystemManager alloc] init];
                      
                      [sharedInstance InitApp];
                      
                      [sharedInstance InitCSVLoad];
                      
                      [sharedInstance InitProvinceKeySetting];
                      
                      [sharedInstance InitTabbar];
                  });
    
    return sharedInstance;
}


+ (NSArray *) AlertDataKey:(NSString *)key {
    
    if ([sharedInstance CSVData] != nil) {
        if ([[[sharedInstance CSVData] allKeys] containsObject:key]) {
            return [[sharedInstance CSVData] objectForKey:key];
        }
    }
    
    return nil;
}

+ (NSString *) ProvinceKey:(NSString *)area {
    return [[sharedInstance CSVProvinceKeys] objectForKey:area];
}

+ (UITabBarController *) TabbarController {
    if (sharedInstance.Tabbar == nil) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        sharedInstance.Tabbar = [sb instantiateViewControllerWithIdentifier:@"TabBar"];
    }
    
    return sharedInstance.Tabbar;
}


- (BOOL) tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
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
    if (CSVProvinceKeys != nil) {
        [CSVProvinceKeys removeAllObjects];
    }
    else {
        CSVProvinceKeys = [[NSMutableDictionary alloc] init];
    }
    
    [CSVProvinceKeys setObject:CSV_KEY_SEOUL       forKey:@"서울"];
    [CSVProvinceKeys setObject:CSV_KEY_GYEONGGI    forKey:@"경기"];
    [CSVProvinceKeys setObject:CSV_KEY_BUSAN       forKey:@"부산"];
    [CSVProvinceKeys setObject:CSV_KEY_INCHEON     forKey:@"인천"];
    [CSVProvinceKeys setObject:CSV_KEY_DAEGU       forKey:@"대구"];
    [CSVProvinceKeys setObject:CSV_KEY_GWANGJU     forKey:@"광주"];
    [CSVProvinceKeys setObject:CSV_KEY_GYEONGNAM   forKey:@"경남"];
    [CSVProvinceKeys setObject:CSV_KEY_CHUNGNAM    forKey:@"충남"];
    [CSVProvinceKeys setObject:CSV_KEY_DAEJEON     forKey:@"대전"];
    [CSVProvinceKeys setObject:CSV_KEY_CHUNGBUK    forKey:@"충북"];
    [CSVProvinceKeys setObject:CSV_KEY_GYEONGSANGBUK forKey:@"경북"];
    [CSVProvinceKeys setObject:CSV_KEY_ULSAN       forKey:@"울산"];
    [CSVProvinceKeys setObject:CSV_KEY_SEJONG      forKey:@"세정"];
    [CSVProvinceKeys setObject:CSV_KEY_JEONBUK     forKey:@"전북"];
    [CSVProvinceKeys setObject:CSV_KEY_GANGWON     forKey:@"강원"];
    [CSVProvinceKeys setObject:CSV_KEY_JEONNAM     forKey:@"전남"];
    [CSVProvinceKeys setObject:CSV_KEY_JEJU        forKey:@"제주"];
}

- (NSString *) getDeviceUUID
{
    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
    NSString* iOSUUID = [userDefault stringForKey:@"UUID_KEY"];
    
    if ( iOSUUID == nil || [iOSUUID isEqual: @""] )
    {
        iOSUUID = [[NSUUID UUID] UUIDString];
    }
    
    [userDefault setObject:iOSUUID forKey:@"UUID_KEY"];
    [userDefault synchronize];
    
    return [NSString stringWithUTF8String:[iOSUUID UTF8String]];
}

// 시간 차이 구하기 (분, 시간, 일) 1~60분, 1~23시간, 1일
- (NSString *) TimeSpace_WriteTime:(NSDate *)wt CurrentTime:(NSDate *)ct
{
    //date1과 date2의 차이를 dateComp변수에 저장
    NSDateComponents *dateComp;
    dateComp = [[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:wt toDate:ct options:0];

    long duration = [dateComp second];//((date1.getTime() - date2.getTime()) / 1000); // gettime()
    int res = 0;
 
    if(duration < 1)
    {
        return @"1초 전";
    }
    else if(duration < 60)
    {
        res = (int)duration;
        
        return [NSString stringWithFormat:@"%d 초 전", (int)ceil(res)];
    }
    else if(duration < 3600)
    {
        res = ((int)(duration/60)<=0)?1:(int)(duration/60);
        
        return [NSString stringWithFormat:@"%d 분 전", (int)ceil(res)];
    }
    else if(duration < 86400)
    {
        res = ((int)(duration/3600)<=0)?1:(int)(duration/3600);
        return [NSString stringWithFormat:@"%d 시간 전", (int)ceil(res)];
    }
    else
    {
        res = ((int)(duration/86400)<=0)?1:(int)(duration/86400);
        return [NSString stringWithFormat:@"%d 일", (int)ceil(res)];
    }
}


#pragma mark - [ CSV ]

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
    CSVData = [[NSMutableDictionary alloc] init];
    
    CSVKeys = [[NSMutableArray alloc] init];
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
            [CSVKeys addObject:[arr objectAtIndex:i]];
            [CSVData setObject:[NSMutableArray array] forKey:[arr objectAtIndex:i]];
        }
    }
    
    else {
        for (int i = 0; i < arr.count; i++)
        {
            if (![[arr objectAtIndex:i] isEqualToString:@""])
            {
                [[CSVData objectForKey:[CSVKeys objectAtIndex:i]] addObject:[arr objectAtIndex:i]];
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


#pragma mark - [ APP PROCESS ] 

- (void) InitApp
{
//    self.UUID = [self getDeviceUUID];
    self.UUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    [self setIsSignUp:[[NSUserDefaults standardUserDefaults] boolForKey:IS_SIGNUP]];
    
    self.UserData = [NSDictionary dictionary];
}

- (void) setPUSH_TOKEN:(const NSString *)PUSH_TOKEN {
    self.PUSH_TOKEN = PUSH_TOKEN;
}


#pragma mark - [ EVENT ]

- (void) SaveSignup {
    
}


#pragma mark - [ ALERT DATA ] 


#pragma mark - 

- (void) setUserData:(NSDictionary *)data {
    UserData = data;
    
    self.AccountNumber = [UserData objectForKey:@"member_type"];
}

@end
