//
//  QuestionViewController.m
//  Another
//
//  Created by Aixtuz Kang on 15/12/2.
//  Copyright (c) 2015年 Aixtuz Kang. All rights reserved.
//

#import "QuestionViewController.h"
#import "QuestionEntity.h"
#import "QuestionViewCell.h"
#import "KCLNetworkTools.h"

@interface QuestionViewController ()

///  模型缓存
@property (nonatomic, strong) NSMutableDictionary *questionDict;
///  布局属性
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@end

@implementation QuestionViewController

// Cell 重用标识
static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    [self.collectionView registerClass:[QuestionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
}

// 设置 flowlayout
- (void)viewDidLayoutSubviews {
    [self layoutWithFlow:self.flowLayout];
}

// 模型集合增加元素方法
- (void)addByDateStr:(NSString *)dateStr andInfo:(NSString *)info {
    
    if ([self.questionDict objectForKey:dateStr] == nil) {
        
        // 拼接 url
        NSString *urlStr = [NSString stringWithFormat:@"http://rest.wufazhuce.com/OneForWeb/one/%@?strDate=%@", info, dateStr];
        NSURL *url = [NSURL URLWithString:urlStr];
        
        // 异步发送请求
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            // 封装的 GET 请求
            [KCLNetworkTools getWithUrl:url andKey:@"questionAdEntity" completion:^(NSDictionary *dict) {
                QuestionEntity *questionEntity = [QuestionEntity questionEntityWithDict:dict];
                [self.questionDict setObject:questionEntity forKey:dateStr];
                
                // 主线程更新
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.collectionView reloadData];
                });
            }];
        });
    }
}

// 重写指定日期的 Setter 方法
- (void)setDay:(NSDate *)day {
    
    // date --> str
    NSString *dateStr = [self strWithDate:day];
    
    // 给模型集合 添加元素
    [self addByDateStr:dateStr andInfo:@"getOneQuestionInfo"];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.questionDict.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QuestionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // key
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow: -indexPath.row * 24 * 60 * 60];
    NSString *key = [self strWithDate:date];
    [cell setWithModel:[self.questionDict objectForKey:key]];
    
    return cell;
}

#pragma 懒加载

- (NSMutableDictionary *)questionDict {
    if (_questionDict == nil) {
        _questionDict = [NSMutableDictionary dictionary];
    }
    return _questionDict;
}

@end

