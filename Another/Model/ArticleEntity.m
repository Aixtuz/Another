//
//  ArticleEntity.m
//  Another
//
//  Created by Aixtuz Kang on 15/12/1.
//  Copyright (c) 2015年 Aixtuz Kang. All rights reserved.
//

#import "ArticleEntity.h"

@implementation ArticleEntity


// 字典转模型的构造方法
- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)articleEntityWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

// 处理字典中多余的键值对的处理
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
