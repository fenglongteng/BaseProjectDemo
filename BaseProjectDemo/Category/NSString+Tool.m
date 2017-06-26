//
//  NSString+Tool.m
//  Weather
//
//  Created by ComAnvei on 16/11/2.
//  Copyright © 2016年 anvei. All rights reserved.
//

#import "NSString+Tool.h"
#import "NSDate+YYAdd.h"
@implementation NSString (Tool)

+(NSString *)translationArabicNum:(NSInteger)arabicNum
{
    NSString *arabicNumStr = [NSString stringWithFormat:@"%ld",(long)arabicNum];
    NSArray *arabicNumeralsArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chineseNumeralsArray = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    NSArray *digits = @[@"个",@"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chineseNumeralsArray forKeys:arabicNumeralsArray];
    
    if (arabicNum < 20 && arabicNum > 9) {
        if (arabicNum == 10) {
            return @"十";
        }else{
            NSString *subStr1 = [arabicNumStr substringWithRange:NSMakeRange(1, 1)];
            NSString *a1 = [dictionary objectForKey:subStr1];
            NSString *chinese1 = [NSString stringWithFormat:@"十%@",a1];
            return chinese1;
        }
    }else{
        NSMutableArray *sums = [NSMutableArray array];
        for (int i = 0; i < arabicNumStr.length; i ++)
        {
            NSString *substr = [arabicNumStr substringWithRange:NSMakeRange(i, 1)];
            NSString *a = [dictionary objectForKey:substr];
            NSString *b = digits[arabicNumStr.length -i-1];
            NSString *sum = [a stringByAppendingString:b];
            if ([a isEqualToString:chineseNumeralsArray[9]])
            {
                if([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]])
                {
                    sum = b;
                    if ([[sums lastObject] isEqualToString:chineseNumeralsArray[9]])
                    {
                        [sums removeLastObject];
                    }
                }else
                {
                    sum = chineseNumeralsArray[9];
                }
                
                if ([[sums lastObject] isEqualToString:sum])
                {
                    continue;
                }
            }
            
            [sums addObject:sum];
        }
        NSString *sumStr = [sums  componentsJoinedByString:@""];
        NSString *chinese = [sumStr substringToIndex:sumStr.length-1];
        return chinese;
    }
}

+(NSInteger)screenNumber:(NSString*)string{
    NSCharacterSet* nonDigits =[[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSInteger remainSecond =[[string stringByTrimmingCharactersInSet:nonDigits] integerValue];
    return remainSecond;
}

//判断是否含有表情
+ (BOOL)stringContainsEmoji:(NSString *)string{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

+(BOOL)stringIsImageURL:(NSString*)url{
    if (! (url.length> 0) ) {
        return NO;
    }
    NSArray *array = @[@"bmp",@"dib",@"rle",@"emf",@"gif",@"jpg",@"jpeg",@"jpe",@"jif", @"pcx",@"dcx",@"pic",@"png",@"tga",@"tif",@"tiffxif",@"wmf",@"jfif"];
    for (NSString *suffxString in array) {
        if ([url hasSuffix:suffxString]) {
            return YES;
        }
    }
    return NO;
}

//生成一个uuid的方法
+(NSString *)getUUIDSString{
    NSString *strUUID = nil;
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault,uuidRef));
    return strUUID;
}

//检查字符串是否包含中文
+(BOOL)testStringContainChineseCharacters:(NSString*)text{
    if(text.length >0){
        
    }else{
        return NO;
    }
    NSError *error = NULL;
    NSRegularExpression *regex2 = [NSRegularExpression regularExpressionWithPattern:@"[\u4e00-\u9fa5]" options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *result = [regex2 firstMatchInString:text options:0 range:NSMakeRange(0, [text length])];
    if (result) {
        return YES;
    }else{
        return NO;
    }
}

//将Unicode编码转成中文
+(NSString *)replaceUnicode:(NSString *)unicodeStr{
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    returnStr =   [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
    //这里去除了换行去除了（） 去除了“” 等特殊符号
    returnStr =   [returnStr stringByReplacingOccurrencesOfString:@"\n"withString:@""];
    returnStr =  [returnStr stringByReplacingOccurrencesOfString:@"\""withString:@""];
    returnStr =  [returnStr stringByReplacingOccurrencesOfString:@")"withString:@""];
    returnStr =  [returnStr stringByReplacingOccurrencesOfString:@"("withString:@""];
    return returnStr;
    
}

- (BOOL)evaluateWithPredicate:(NSString *)predicate{
    NSAssert(predicate != nil, @"请输入一个不为空的正则表达式");
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", predicate];
    return [emailTest evaluateWithObject:self];
}

+(BOOL)testStringIsPhoneNumber:(NSString*)phoneNumber{
    NSString *phoneRegex1=@"1[34578]([0-9]){9}";
    NSPredicate *phoneTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex1];
    return  [phoneTest1 evaluateWithObject:phoneNumber];
}

//汉子转拼音
//用kCFStringTransformMandarinLatin方法转化出来的是带音标的拼音，如果需要去掉音标，则继续使用kCFStringTransformStripCombiningMarks方法即可。
+ (NSString *)transform:(NSString *)chinese
{
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    return [pinyin uppercaseString];
}


//判断是否为中文+数字+字母组成
+(BOOL)testChineseAndCharAndNumber:(NSString*)str{
    NSString *regex = @"^[A-Za-z0-9\u4e00-\u9fa5]+$";
    return  [str evaluateWithPredicate:regex];
}

+ (BOOL) IsEmailAdress:(NSString *)Email
{
    NSString *emailCheck = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailCheck];
    return [emailTest evaluateWithObject:Email];
}


+ (BOOL) IsIdentityCard:(NSString *)IDCardNumber
{
    if (IDCardNumber.length <= 0) {
        return NO;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:IDCardNumber];
}

//银行卡
+ (BOOL) IsBankCard:(NSString *)cardNumber
{
    if(cardNumber.length==0)
    {
        return NO;
    }
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < cardNumber.length; i++)
    {
        c = [cardNumber characterAtIndex:i];
        if (isdigit(c))
        {
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--)
    {
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo)
        {
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }
        else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
}

+ (BOOL)isBlankString:(NSString *)string{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+ (NSString*)rmbdislayWithInt:(int64_t)rmb{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior: NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
    NSString *numberString = [numberFormatter stringFromNumber: [NSNumber numberWithInteger: rmb]];
    return numberString;
}

+ (NSString *)notRounding:(double)num afterPoint:(int)position{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:num];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

+(NSString*)getTimeStringWithTimeStamp:(int64_t)timeStamp{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSInteger year = date.year;
    while (year>2020) {
        timeStamp =  timeStamp/1000;
        date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
        year = date.year;
    }
    NSTimeZone *timeZone =   [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
    NSString *timeString =  [date stringWithFormat:@"yyyy-MM-dd HH:mm:ss" timeZone:timeZone locale:locale];
    return timeString;
}

+(NSString*)getMessageTimeWithTimeStamp:(int64_t)timeStamp{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSInteger year = date.year;
    while (year>2020) {
        timeStamp =  timeStamp/1000;
        date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
        year = date.year;
    }
    NSTimeZone *timeZone =   [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
    if (date.isToday) {
        NSString *timeString =  [date stringWithFormat:@"HH:mm" timeZone:timeZone locale:locale];
        timeString = [NSString stringWithFormat:@"今天 %@",timeString];
        return timeString;
    }
    if (date.isYesterday) {
        NSString *timeString =  [date stringWithFormat:@"HH:mm" timeZone:timeZone locale:locale];
        timeString = [NSString stringWithFormat:@"昨天 %@",timeString];
        return timeString;
    }
    NSString *timeString =  [date stringWithFormat:@"yyyy-MM-dd HH:mm" timeZone:timeZone locale:locale];
    return timeString;
}


+(NSString*)getErorrMessage:(int64_t)status{
    switch (status) {
        case 0:
            return @"成功";
            break;
        case 4096:
            return @"4096未知错误";
            break;
        case 4097:
            return @"参数错误";
            break;
        case 4099:
            return @"服务器内部错误";
            break;
        case 4100:
            return @"未找到服务器";
            break;
        case 4101:
            return @"验证码错误";
            break;
        case 4102:
            return @"服务器无效";
            break;
        case 4103:
            return @"服务器繁忙";
            break;
        case 4104:
            return @"密码错误";
            break;
        case 4105:
            return @"原型错误";
            break;
        case 4106:
            return @"没有进入该房间";
            break;
        case 4107:
            return @"不被允许进入该房间";
            break;
        case 4108:
            return @"没有权限";
            break;
        case 4109:
            return @"不存在该房间";
            break;
        case 4110:
            return @"被踢出房间";
            break;
        case 4111:
            return @"该号码已绑定,请换个手机号。";
            break;
        case 4112:
            return @"您的金币不足";
            break;
        case 4113:
            return @"该手机号已经被绑定";
            break;
        case 4114:
            return @"该用户已经退出";
            break;
        case 4115:
            return @"该用户已经关闭";
            break;
        case 4116:
            return @"该用户密码";
            break;
        case 4117:
            return @"该用户已经被封";
            break;
        default:
            return @"";
            break;
    }
}


@end
