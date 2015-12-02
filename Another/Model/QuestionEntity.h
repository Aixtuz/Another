//
//  QuestionEntity.h
//  Another
//
//  Created by Aixtuz Kang on 15/12/2.
//  Copyright © 2015年 Aixtuz Kang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionEntity : NSObject

// 日期
@property (nonatomic, copy) NSString *strQuestionMarketTime;
// 问题
@property (nonatomic, copy) NSString *strQuestionTitle;
@property (nonatomic, copy) NSString *strQuestionContent;
// 回答
@property (nonatomic, copy) NSString *strAnswerTitle;
@property (nonatomic, copy) NSString *strAnswerContent;
// 编辑
@property (nonatomic, copy) NSString *sEditor;

// 字典转模型的构造方法
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)questionEntityWithDict:(NSDictionary *)dict;

@end
