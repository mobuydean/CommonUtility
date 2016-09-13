//
//  CommonUtility.m
//  CommonUtility
//
//  Created by jianghao on 16/9/13.
//  Copyright © 2016年 Dean. All rights reserved.
//

#import "CommonUtility.h"
#import <ImageIO/ImageIO.h>

@implementation CommonUtility


#pragma mark - --- 运营商验证
+(MobileOperatorType)phoneNumberOfMobileOperator:(NSString*)number
{
    static NSPredicate* checkerCM;
    static NSPredicate* checkerCU;
    static NSPredicate* checkerCT;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        checkerCM = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$"];
        checkerCU = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$"];
        checkerCT = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$"];
    });
    if ([checkerCM evaluateWithObject:number]) {
        return MobileOperatorTypeCM;
    }else if ([checkerCU evaluateWithObject:number]) {
        return MobileOperatorTypeCU;
    }else if ([checkerCT evaluateWithObject:number]) {
        return MobileOperatorTypeCT;
    }else{
        return MobileOperatorTypeNone;
    }
}

#pragma mark - --- 用户身份证号码验证
+(BOOL)isCheckUserIdCard:(NSString *)idCard
{
    static NSPredicate* checker;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
        checker = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    });
    return [checker evaluateWithObject:idCard];
}

#pragma mark - --- 银行卡号验证
+(BOOL)isValidBankCardNumber:(NSString *)number
{
    static NSPredicate* checker;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        checker = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(\\d{16,19}|\\d{6}[- ]\\d{10,13}|\\d{4}[- ]\\d{4}[- ]\\d{8,11})$"];
    });
    return [checker evaluateWithObject:number];
}

#pragma mark - --- 邮件地址验证
+(BOOL)isValidEmailAddress:(NSString *)email
{
    static NSPredicate* checker;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        checker = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
    });
    return [checker evaluateWithObject:email];
}

#pragma mark - --- 颜色值转换 #FF9900、0XFF9900 等颜色字符串，转换为 UIColor 对象
+(UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor blackColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    
    CGFloat alpha = 1.0f;
    if ([cString length] == 8) {
        NSRange range;
        range.location = 0;
        range.length = 2;
        NSString *alphaString = [cString substringWithRange:range];
        cString = [cString substringFromIndex:2];
        
        unsigned int alphaInt;
        [[NSScanner scannerWithString:alphaString] scanHexInt:&alphaInt];
        alpha = (float)alphaInt / 255.0f;
    }
    
    
    if ([cString length] != 6) return [UIColor whiteColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

#pragma mark - --- 判断某个点是否在某个区域里
+(BOOL)isPointInRect:(CGPoint)p rect:(CGRect)rect
{
    CGFloat rectX = rect.origin.x;
    CGFloat rectY = rect.origin.y;
    CGFloat rectWidth = rect.size.width;
    CGFloat rectHeight = rect.size.height;
    CGFloat pX = p.x;
    CGFloat pY = p.y;
    if(pX < rectX
       ||(pX > rectX + rectWidth)
       || pY < rectY
       || pY > rectY + rectHeight)
    {
        return NO;
    }
    return YES;
}

#pragma mark - --- 常用路径
+ (NSString*)documentPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

+ (NSString*)cachePath
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}

+ (NSString *)ApplicationSupportPath
{
    return [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) firstObject];
}

#pragma mark - --- 清除缓存文件
+(void)clearCache
{
    NSString *filePath = [self cachePath];
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        if ([manager fileExistsAtPath:filePath]){
            
            NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:filePath] objectEnumerator];
            
            NSString* fileName = nil;
            
            while ((fileName = [childFilesEnumerator nextObject]) != nil){
                NSString* fileAbsolutePath = [filePath stringByAppendingPathComponent:fileName];
                [manager removeItemAtPath:fileAbsolutePath error:nil];
            }
        }
    }

}

#pragma mark - --- 计算缓存的大小
+(float)calculateCache
{
    NSString *filePath = [self cachePath];
    NSFileManager * manager = [NSFileManager defaultManager];
    float cache = 0;
    if ([manager fileExistsAtPath:filePath]) {
        long long folderSize = 0;
        if ([manager fileExistsAtPath:filePath]){
            
            NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:filePath] objectEnumerator];
            
            NSString* fileName = nil;
            
            while ((fileName = [childFilesEnumerator nextObject]) != nil){
                NSString* fileAbsolutePath = [filePath stringByAppendingPathComponent:fileName];
                folderSize += [self fileSizeAtPath:fileAbsolutePath];
            }
            
            cache = folderSize / 1024 / 1024.0;
        }
    }
    return cache;
}

+(long long)fileSizeAtPath:(NSString *)filePath
{
    NSFileManager *manger = [NSFileManager defaultManager];
    if ([manger fileExistsAtPath:filePath]) {
        return [[manger attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

#pragma mark - 获取GIF帧图片
+ (NSArray*)getGifImages:(NSString*)gifName {
    NSMutableArray *images = [NSMutableArray array];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:gifName ofType:@"gif"];
    CGFloat scale = [UIScreen mainScreen].scale;
    if (scale > 1.0f){
        if (scale > 2.0){
            path = [[NSBundle mainBundle] pathForResource:[gifName stringByAppendingString:@"@3x"] ofType:@"gif"];
        }else{
            path = [[NSBundle mainBundle] pathForResource:[gifName stringByAppendingString:@"@2x"] ofType:@"gif"];
        }
    }
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (data)
    {
        CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
        size_t count = CGImageSourceGetCount(source);
        NSTimeInterval duration = 0.0f;
        
        for (size_t i = 0; i < count; i++)
        {
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            
            NSDictionary *frameProperties = CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(source, i, NULL));
            duration += [[[frameProperties objectForKey:(NSString*)kCGImagePropertyGIFDictionary] objectForKey:(NSString*)kCGImagePropertyGIFDelayTime] doubleValue];
            
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            
            CGImageRelease(image);
        }
        
        if (!duration) {
            duration = (1.0f/10.0f)*count;
        }
        
        CFRelease(source);
    }
    return images;
}

#pragma mark - DES 加密/解密
+(NSData *)desData:(NSData *)data key:(NSString *)keyString CCOperation:(CCOperation)op
{
    char buffer [1024] ;
    memset(buffer, 0, sizeof(buffer));
    size_t bufferNumBytes;
    CCCryptorStatus cryptStatus = CCCrypt(op,
                                          
                                          kCCAlgorithmDES,
                                          
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          
                                          [keyString UTF8String],
                                          
                                          kCCKeySizeDES,
                                          
                                          NULL,
                                          
                                          [data bytes],
                                          
                                          [data length],
                                          
                                          buffer,
                                          
                                          1024,
                                          
                                          &bufferNumBytes);
    if(cryptStatus == kCCSuccess) {
        NSData *returnData =  [NSData dataWithBytes:buffer length:bufferNumBytes];
        return returnData;
    }
    return nil;
    
}

#pragma mark - --- BASE64 编码
+(NSString *)base64encodeString:(NSString *)str
{
    if ([str length] == 0) {
        return @"";
    }
    NSData *plainData = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [plainData base64EncodedStringWithOptions:0];
    return base64String;
}

#pragma mark - --- BASE64 解码
+(NSString *)stringBase64Decode:(NSString *)base64str
{
    if ([base64str length] == 0) {
        return @"";
    }
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:base64str options:0];
    NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    return decodedString;
}


#pragma mark - ---  获取当前时间
+(NSString*)getCurrentTime
{
    NSDate *nowUTC = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:nowUTC];
}


#pragma mark - --- 将传入的时间格式转换为对应的格式
+(NSString *)ToFormatStrFromDateStr:(NSString *)dateStr fromFormatter:(NSDateFormatter *)fromFormatter toFormatter:(NSDateFormatter *)toFormatter
{
    NSDate *date = [fromFormatter dateFromString:dateStr];
    return [toFormatter stringFromDate:date];
}

#pragma mark - --- 获取星期几
+(NSString*)weekdayForDate:(NSDate *)theDate
{
    NSString* weekDayString;
    
    NSDateComponents *weekdayComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:theDate];
    NSInteger weekday = [weekdayComponents weekday];
    
    switch (weekday) {
        case 1:
            weekDayString = @"星期日";
            break;
            
        case 2:
            weekDayString = @"星期一";
            break;
            
        case 3:
            weekDayString = @"星期二";
            break;
            
        case 4:
            weekDayString = @"星期三";
            break;
            
        case 5:
            weekDayString = @"星期四";
            break;
            
        case 6:
            weekDayString = @"星期五";
            break;
            
        case 7:
            weekDayString = @"星期六";
            break;
            
        default:
            return nil;
            break;
    }
    
    return weekDayString;
}

#pragma mark - --- 获取两地之间的距离描述
+(NSString *)descriptionForDistance:(NSInteger)distance
{
    if (distance > 0 && distance < 10) {
        return @"身边";
    }
    
    if (distance >= 10 && distance < 1000) {
        return [NSString stringWithFormat:@"%ld米", (long)distance];
    }
    if (distance >= 1000 && distance < 1000*100) {
        CGFloat newDistance = distance/1000.0;
        return [NSString stringWithFormat:@"%0.1f公里", newDistance];
    }
    if (distance >= 100*1000 && distance < 1000*1000) {
        return [NSString stringWithFormat:@"百里外"];
    }
    if (distance >= 1000*1000) {
        return [NSString stringWithFormat:@"千里外"];
    }
    return nil;
}

#pragma mark - --- 将颜色转换为Image
+(UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
#pragma mark - --- 根据位置将颜色转换为Image
+(UIImage *)imageWithColor:(UIColor *)color andRect:(CGRect)rect
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
#pragma mark - --- 根据位置，文字，字体将颜色转换为Image
+(UIImage *)imageWithColor:(UIColor *)color andRect:(CGSize)size text:(NSString *)text font:(UIFont *)font
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    CGFloat width = [text sizeWithAttributes:@{NSFontAttributeName:font}].width;
    [text drawInRect:CGRectMake((size.width-width)/2,size.height/3, width, size.height/2) withAttributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:[ UIColor whiteColor]}];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}


#pragma mark - --- URL解析
+(NSMutableDictionary*)urlParser:(NSString*)urlString appScheme:(NSString*)appScheme {
    NSMutableDictionary* urlDict = [NSMutableDictionary dictionaryWithCapacity:5];
    
    @try {
        if ([appScheme length]>0 && [urlString hasPrefix:appScheme]) {
            // 对 APPLICATION_SCHEME 进行解析
            
            NSString* operationString = [urlString stringByReplacingOccurrencesOfString:appScheme withString:@""];
            
            NSArray* operationArray = [operationString componentsSeparatedByString:@"?"];
            if (operationArray && [operationArray count]>0) {
                NSString* operationName = [operationArray objectAtIndex:0];
                [urlDict setObject:operationName forKey:@"m"];
                
                if ([operationArray count]>1) {
                    NSString* argumentsString = [operationArray objectAtIndex:1];
                    if (argumentsString && [argumentsString length]>0) {
                        NSArray* argumentsArray = [argumentsString componentsSeparatedByString:@"&"];
                        for (int n=0; n<[argumentsArray count]; n++) {
                            NSString* argPairString = [argumentsArray objectAtIndex:n];
                            if (argPairString && [argPairString length]>0) {
                                NSString *argmentName,*argmentValue;
                                NSArray* argPairArray = [argPairString componentsSeparatedByString:@"="];
                                if (argPairArray && [argPairArray count]>0) {
                                    argmentName = [argPairArray objectAtIndex:0];
                                    if ([operationArray count]>1) {
                                        argmentValue = [argPairArray objectAtIndex:1];
                                    }else {
                                        argmentValue = @"";
                                    }
                                    [urlDict setObject:argmentValue forKey:argmentName];
                                }
                            }
                        }
                    }
                }
            }else{
                urlDict = nil;
            }
        }else{
            // 其余的得到key：value值
            NSArray* operationArray = [urlString componentsSeparatedByString:@"?"];
            if (operationArray && [operationArray count] > 1) {
                NSString *paramStr = [operationArray objectAtIndex:1];
                NSArray *paramArray = [paramStr componentsSeparatedByString:@"&"];
                for (NSString *item in paramArray) {
                    NSArray *itemArray = [item componentsSeparatedByString:@"="];
                    NSString *itemKey = [itemArray objectAtIndex:0];
                    NSString *itemValue;
                    if ([itemArray count] > 1) {
                        itemValue = [itemArray objectAtIndex:1];
                    }else{
                        itemValue = @"";
                    }
                    
                    [urlDict setObject:itemValue forKey:itemKey];
                }
            }else{
                urlDict = nil;
            }
        }
    } @catch (NSException *exception) {
        
        return nil;
        
    } @finally {
        return urlDict;
    }
    
    
    return urlDict;
}







@end
