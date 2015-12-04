//
//  PhraseViewController.m
//  Another
//
//  Created by Aixtuz Kang on 15/11/22.
//  Copyright © 2015年 Aixtuz Kang. All rights reserved.
//

#import "HPViewController.h"
#import "HPEntity.h"
#import "HPViewCell.h"
#import "KCLNetworkTools.h"

@interface HPViewController ()

///  模型缓存
@property (nonatomic, strong) NSMutableDictionary *hpDict;
///  布局属性
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@end

@implementation HPViewController

// Cell 重用标识
static NSString * const reuseIdentifier = @"HPViewCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    [self.collectionView registerClass:[HPViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

// 设置 flowlayout
- (void)viewDidLayoutSubviews {
    [self layoutWithFlow:self.flowLayout];
}


// 模型集合增加元素方法
- (void)addByDateStr:(NSString *)dateStr andInfo:(NSString *)info andKey:(NSString *)key {
    
    if ([self.hpDict objectForKey:dateStr] == nil) {
        
        // 拼接 url
        NSString *urlStr = [NSString stringWithFormat:@"http://rest.wufazhuce.com/OneForWeb/one/%@?strDate=%@", info, dateStr];
        NSURL *url = [NSURL URLWithString:urlStr];
        
        // 异步发送请求
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            // 封装的 GET 请求
            [KCLNetworkTools getWithUrl:url andKey:key completion:^(NSDictionary *dict) {
                HPEntity *hpEntity = [HPEntity hpEntityWithDict:dict];
                [self.hpDict setObject:hpEntity forKey:dateStr];
                
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
    
    if (![self.hpDict objectForKey:dateStr]) {
        // 给模型集合 添加元素
        [self addByDateStr:dateStr andInfo:@"getHpinfo" andKey:@"hpEntity"];
    }
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.hpDict.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HPViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // key
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow: -indexPath.row * 24 * 60 * 60];
    NSString *dateStr = [self strWithDate:date];
    [cell setWithModel:[self.hpDict objectForKey:dateStr] andDateStr:dateStr];

    return cell;
}

#pragma 懒加载

- (NSMutableDictionary *)hpDict {
    if (_hpDict == nil) {
        _hpDict = [NSMutableDictionary dictionary];
    }
    return _hpDict;
}


@end


