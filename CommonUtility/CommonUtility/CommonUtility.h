//
//  CommonUtility.h
//  CommonUtility
//
//  Created by jianghao on 16/9/13.
//  Copyright © 2016年 Dean. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, MobileOperatorType) {
    MobileOperatorTypeNone,//木有
    MobileOperatorTypeCM,//中国移动
    MobileOperatorTypeCU,//中国联通
    MobileOperatorTypeCT//中国电信
};

@interface CommonUtility : NSObject

/**
 *运营商验证
 */
+(MobileOperatorType)phoneNumberOfMobileOperator:(NSString*)number;

/**
 *用户身份证号码验证
 */
+(BOOL)isCheckUserIdCard:(NSString *)idCard;

/**
 *银行卡号验证
 */
+(BOOL)isValidBankCardNumber:(NSString *)number;

/**
 *邮件地址验证
 */
+(BOOL)isValidEmailAddress:(NSString *)email;

/**
 *颜色值转换 #FF9900、0XFF9900 等颜色字符串，转换为 UIColor 对象
 */
+(UIColor *)colorWithHexString:(NSString *)stringToConvert;

/**
 *判断某个点是否在某个区域里
 */
+(BOOL)isPointInRect:(CGPoint)p rect:(CGRect)rect;

/**
 *用户产生文件，iTunes备份和恢复的时候会包括此目录;app/Documents
 */
+(NSString *)documentPath;

/**
 * 缓存文件，比如数据库缓存、下载缓存；iTunes不会备份此目录，此目录下文件不会在应用退出删除;app/Library/Caches
 * 比app/tmp时间长，tmp文件夹app退出是就有可能清理；
 * caches文件夹在系统清理磁盘空间时会清理。
 */
+(NSString *)cachePath;

/**
 * 应用支持数据,如：配置文件、模板文件；iTunes会备份此目录;app/Library/Application support/
 */
+(NSString *)ApplicationSupportPath;

/**
 *清除缓存文件
 */
+(void)clearCache;

/**
 *计算缓存的大小
 */
+(float)calculateCache;

/**
 *获取GIF帧图片
 */
+(NSArray*)getGifImages:(NSString*)gifName;


/**
 *  将字符串编码为base64
 *  @param      str        待转换的字符串
 *  @return     转换后的字符串
 */
+(NSString *)base64encodeString:(NSString *)str;

/**
 *  将base64串解码，返回string
 *  @param      base64str  待转换的base64串
 *  @return     转换后的字符串
 */
+(NSString *)stringBase64Decode:(NSString *)base64str;

/**
 *  DES加密或解密
 *
 *  @param      data       待加密/解密的数据
 *  @param      keyString  是密码（一般是8位）
 *  @param      op         表示加密/解密(kCCEncrypt/kCCDecrypt)
 *  @return     解密/加密后的结果
 */
+(NSData *)desData:(NSData *)data key:(NSString *)keyString CCOperation:(CCOperation)op;


/**
 *  获取当前时间，格式为yyyy-MM-dd HH:mm:ss
 *
 *  @return     当前时间
 */
+(NSString*)getCurrentTime;

/**
 *将传入的时间格式转换为对应的格式
 * dateStr 时间字符串
 * fromFormatter 与dateStr对应的Formatter
 * toFormatter 要生成的时间对应的Formatter
 */
+(NSString *)ToFormatStrFromDateStr:(NSString *)dateStr fromFormatter:(NSDateFormatter *)fromFormatter toFormatter:(NSDateFormatter *)toFormatter;

/**
 *  获取星期几
 */
+(NSString*)weekdayForDate:(NSDate *)theDate;

/**
 *  获取两地之间的距离描述
 */
+(NSString *)descriptionForDistance:(NSInteger)distance;

/**
 *  根据位置将颜色转换为Image
 */
+(UIImage *)imageWithColor:(UIColor *)color andRect:(CGRect)rect;
/**
 *  将颜色转换为Image
 */
+(UIImage *)imageWithColor:(UIColor *)color;
/**
 *  根据位置，文字，字体将颜色转换为Image
 */
+(UIImage *)imageWithColor:(UIColor *)color andRect:(CGSize)size text:(NSString *)text font:(UIFont *)font;

/**
 *  解析URL，组装成key:value形式
 */
+(NSMutableDictionary*)urlParser:(NSString*)urlString appScheme:(NSString*)appScheme;





@end
