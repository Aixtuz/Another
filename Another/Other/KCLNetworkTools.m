 //
//  KCLNetworkTools.m
//  Another
//
//  Created by Aixtuz Kang on 15/11/26.
//  Copyright (c) 2015年 Aixtuz Kang. All rights reserved.
//

#import "KCLNetworkTools.h"
#import "HPEntity.h"


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
            
            // 执行 block;
            completion(dict);
            
        } else {
            
            NSLog(@"%@", error);
        }
    }];
    
    // 任务默认挂起, 需恢复
    [task resume];
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
