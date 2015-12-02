//
//  KCLNetworkTools.h
//  Another
//
//  Created by Aixtuz Kang on 15/11/26.
//  Copyright (c) 2015年 Aixtuz Kang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HPEntity.h"

@interface KCLNetworkTools : NSURLSession

// GET 请求
+ (void)getWithUrl:(NSURL *)url andKey:(NSString *)key completion:(void (^)(NSDictionary *))completion;

// 单例对象的初始化方法
+ (instancetype)shareNetworkTools;

@end
