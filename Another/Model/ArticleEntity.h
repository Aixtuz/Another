//
//  ArticleEntity.h
//  Another
//
//  Created by Aixtuz Kang on 15/12/1.
//  Copyright (c) 2015年 Aixtuz Kang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleEntity : NSObject

// 日期
@property (nonatomic, copy) NSString *strContMarketTime;
// 标题
@property (nonatomic, copy) NSString *strContTitle;
// 内容
@property (nonatomic, copy) NSString *strContent;
// 作者
@property (nonatomic, copy) NSString *strContAuthor;
// 简介
@property (nonatomic, copy) NSString *sAuth;

// 字典转模型的构造方法
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)articleEntityWithDict:(NSDictionary *)dict;

@end
