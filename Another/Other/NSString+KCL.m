//
//  NSMutableString+KCL.m
//  Another
//
//  Created by Aixtuz Kang on 15/12/3.
//  Copyright © 2015年 Aixtuz Kang. All rights reserved.
//

#import "NSString+KCL.h"

@implementation NSString (KCL)

// 字符串处理
- (NSString *)strFormat {
    NSMutableString *strM = [NSMutableString stringWithString:self];
    // 取出斜体符
    strM = [NSMutableString stringWithString:[strM stringByReplacingOccurrencesOfString:@"<i>" withString:@"\r\n"]];
    strM = [NSMutableString stringWithString:[strM stringByReplacingOccurrencesOfString:@"</i>" withString:@"\r\n"]];
    // 链接符分割
    strM = [NSMutableString stringWithString:[strM stringByReplacingOccurrencesOfString:@"&" withString:@"\r\n"]];
    // 替换换行符
    strM = [NSMutableString stringWithString:[strM stringByReplacingOccurrencesOfString:@"<br>" withString:@"\r\n"]];
    return strM;
}

// 路径处理
- (NSString *)fileNameToPath {
    
    // Caches
    NSString *cache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    // BundleID
    NSDictionary *dic = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [dic objectForKey:@"CFBundleIdentifier"];
    
    // App 文件夹
    NSString *folder = [cache stringByAppendingPathComponent:appName];
    
    // 完整路径
    return [folder stringByAppendingPathComponent:self];
}

@end
