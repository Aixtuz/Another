//
//  KCLNetworkTools.h
//  Another
//
//  Created by Aixtuz Kang on 15/11/26.
//  Copyright (c) 2015年 Aixtuz Kang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPEntity.h"

@interface KCLNetworkTools : NSObject

// GET 请求
+ (void)getWithUrl:(NSURL *)url andKey:(NSString *)key completion:(void (^)(NSDictionary *))completion;

// 下载图片
+ (void)setImageView:(UIImageView *)imageView withUrlStr:(NSString *)str andDateStr:(NSString *)dateStr;

// 单例对象的初始化方法
+ (instancetype)shareNetworkTools;

@end
