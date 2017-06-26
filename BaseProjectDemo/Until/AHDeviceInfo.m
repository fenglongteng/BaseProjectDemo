//
//  AHDeviceInfo.m
//  Weather
//
//  Created by luobaoyin on 16/2/26.
//  Copyright © 2016年 anvei. All rights reserved.
//

#import "AHDeviceInfo.h"
#import "Reachability.h"
#import <sys/utsname.h>
#import "SSKeychain.h"
#import "NSString+Tool.h"
#import "SVProgressHUD.h"

@implementation AHDeviceInfo

+ (CGRect)bounds
{
    return [UIScreen mainScreen].bounds;
}

+ (CGFloat)systemVersion
{
    return [CURRENT_DEVICE.systemVersion floatValue] ;
}

+ (NSString*)systemName
{
    return CURRENT_DEVICE.systemName ;
}

+ (NSString*)currentLanguage
{
    return [[NSLocale preferredLanguages] objectAtIndex:0] ;
}

+ (BOOL)isIPad
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ;
}

+ (BOOL)isIPhone
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) ;
}


+ (BOOL)isWidth320Device{
    return ([AHDeviceInfo bounds].size.width == 320) ;
}

+ (NSString *)getAppCurrentVersion{
    
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString * bundlVer =  [infoDic objectForKey:@"CFBundleVersion"];
    NSString *shortVer = [infoDic objectForKey:@"CFBundleShortVersionString"];
    NSString *version = [NSString stringWithFormat:@"%@.%@",shortVer,bundlVer];
    return  version;
    
}

+(NSInteger)deviceNumber{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([platform isEqualToString:@"iPhone3,1"]) return 4;
    if ([platform isEqualToString:@"iPhone3,2"]) return 4;
    if ([platform isEqualToString:@"iPhone3,3"]) return 4;
    if ([platform isEqualToString:@"iPhone4,1"]) return 4;
    if ([platform isEqualToString:@"iPhone5,1"]) return 5;
    if ([platform isEqualToString:@"iPhone5,2"]) return 5;
    if ([platform isEqualToString:@"iPhone5,3"]) return 5;
    if ([platform isEqualToString:@"iPhone5,4"]) return 5;
    if ([platform isEqualToString:@"iPhone6,1"]) return 5;
    if ([platform isEqualToString:@"iPhone6,2"]) return 5;
    if ([platform isEqualToString:@"iPhone7,1"]) return 7;//iphone 6plus
    if ([platform isEqualToString:@"iPhone7,2"]) return 6;
    
    return 0;
}

+ (NSString *)deviceString{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    
    return @"iPhone";

}

+ (BOOL)isLaunchFirst
{
    if([[NSUserDefaults standardUserDefaults] objectForKey:LAUNCH_FIRST_FLAG] == nil )
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:LAUNCH_FIRST_FLAG] ;
        [[NSUserDefaults standardUserDefaults] synchronize] ;
        return YES ;
    }
    return NO ;
}

+ (BOOL)isExistenceNetwork
{
    Reachability *reach = [Reachability reachabilityWithHostName:@"https://www.baidu.com"];
    NetworkStatus status = [reach currentReachabilityStatus];
    if (status == NotReachable) {
        return NO;
    }
    return YES;
}

//获取uuid且保存到钥匙串 卸载过后又安装的话读取钥匙串uuid
+ (NSString*)getUUID{
    NSString * currentDeviceUUIDStr = nil;
    //由于钥匙串有一定概率拿不到uuid，错误原因又很难说，而且拿不到的时候一小段时间都拿不到，所以尽量少用钥匙串拿数据，这里就用了NSUserDefaults减少使用钥匙串。钥匙串只在卸载app后第一次拿uuid使用。
    currentDeviceUUIDStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"uuid"];
    if (TestStringIsBlank(currentDeviceUUIDStr)) {
        currentDeviceUUIDStr = [SSKeychain passwordForService:@"com.baidu.HuaHuaLive" account:@"uuid"];
        if(!TestStringIsBlank(currentDeviceUUIDStr)){
            [[NSUserDefaults standardUserDefaults]setObject:currentDeviceUUIDStr forKey:@"uuid"];
        }
    }
//    NSError *error = nil;
//    while (error) {
//        error = nil;
//        currentDeviceUUIDStr = [SSKeychain passwordForService:@"com.baidu.HuaHuaLive"account:@"uuid" error:&error];
//    }
    if (TestStringIsBlank(currentDeviceUUIDStr))
    {
        /**
         *此uuid在相同的一个程序里面-相同的vindor-相同的设备下是不会改变的
         *此uuid是唯一的，但应用删除再重新安装后会变化，采取的措施是：只获取一次保存在钥匙串中，之后就从钥匙串中获取
         **/
        currentDeviceUUIDStr  = [UIDevice currentDevice].identifierForVendor.UUIDString;
        currentDeviceUUIDStr = [currentDeviceUUIDStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
        currentDeviceUUIDStr = [currentDeviceUUIDStr lowercaseString];
        //若获取不到就手动生成
        if (TestStringIsBlank(currentDeviceUUIDStr)) {
            CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
            CFStringRef cfuuid = CFUUIDCreateString(kCFAllocatorDefault, uuidRef);
            CFRelease(uuidRef);
            currentDeviceUUIDStr = [((__bridge NSString *) cfuuid) copy];
            currentDeviceUUIDStr = [currentDeviceUUIDStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
            currentDeviceUUIDStr = [currentDeviceUUIDStr lowercaseString];
            CFRelease(cfuuid);
        }
        //password:密码 serviece:应用标识（最好使用bundleID） account：账户名
        [SSKeychain setPassword: currentDeviceUUIDStr forService:@"com.baidu.HuaHuaLive" account:@"uuid"];
        [[NSUserDefaults standardUserDefaults]setObject:currentDeviceUUIDStr forKey:@"uuid"];
    }
    return currentDeviceUUIDStr;
}

+ (NSString*)getIPAdress{
    NSError *error;
    NSURL *ipURL = [NSURL URLWithString:@"http://ipof.in/txt"];
    NSString *ip = [NSString stringWithContentsOfURL:ipURL encoding:NSUTF8StringEncoding error:&error];
    if (TestStringIsBlank(ip)) {
        ip =@"ip获取失败";
    }
    return ip;
}

@end
