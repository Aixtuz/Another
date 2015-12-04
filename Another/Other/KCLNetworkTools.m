 //
//  KCLNetworkTools.m
//  Another
//
//  Created by Aixtuz Kang on 15/11/26.
//  Copyright (c) 2015年 Aixtuz Kang. All rights reserved.
//

#import "KCLNetworkTools.h"
#import "NSString+KCL.h"

@implementation KCLNetworkTools

// GET 请求
+ (void)getWithUrl:(NSURL *)url andKey:(NSString *)key completion:(void (^)(NSDictionary *))completion {
    
    // Session
    NSURLSession *session = [NSURLSession sharedSession];
    // Task
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        // 解析数据 (默认 JSON)
        if (data) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil][key];
            // 判断取得的字典是否有数据
            if (dict.count) {
                // 执行 block;
                completion(dict);
            } else {
                NSLog(@"只能召唤十天的数据...");
            }
        } else {
            NSLog(@"%@", error);
        }
    }];
    
    // 任务默认挂起, 需恢复
    [task resume];
}

// 下载图片
+ (void)setImageView:(UIImageView *)imageView withUrlStr:(NSString *)str andDateStr:(NSString *)dateStr {
    
    // 拼接路径 + App 文件夹 + 文件名
    NSString *path = [dateStr fileNameToPath];
    
    if (![UIImage imageWithContentsOfFile:path]) {
        // Session
        NSURLSession *session = [NSURLSession sharedSession];
        // Task
        NSURLSessionDownloadTask *task = [session downloadTaskWithURL:[NSURL URLWithString:str] completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
            
            // 缓存 --> path
            NSFileManager *mgr = [NSFileManager defaultManager];
            // 根据 url 或 path 移动, (NSURL *)location 需转 path
            [mgr moveItemAtPath:location.path toPath:path error:nil];
        }];
        
        // 任务默认挂起, 需恢复
        [task resume];
    }
    // 主线程更新 UI
    dispatch_async(dispatch_get_main_queue(), ^{
        imageView.image = [UIImage imageWithContentsOfFile:path];
    });
}

// 单例对象的初始化方法(GCD 一次性代码)
+ (instancetype)shareNetworkTools {
    
    static id instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

@end
