//
//  HPEntity.h
//  Another
//
//  Created by Aixtuz Kang on 15/11/22.
//  Copyright © 2015年 Aixtuz Kang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPEntity : NSObject

// VOL 编号
@property (nonatomic, copy) NSString *strHpTitle;
// 图片地址
@property (nonatomic, copy) NSString *strOriginalImgUrl;
// 作者
@property (nonatomic, copy) NSString *strAuthor;
// 内容
@property (nonatomic, copy) NSString *strContent;
// 时间
@property (nonatomic, copy) NSString *strMarketTime;

// 字典转模型的构造方法
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)hpEntityWithDict:(NSDictionary *)dict;

@end
