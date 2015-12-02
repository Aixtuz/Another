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

///  指定日期
@property (nonatomic, strong) NSDate *day;
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
    
    self.day = [NSDate date];
    
    // Register cell classes
    [self.collectionView registerClass:[QuestionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
}

- (void)viewDidLayoutSubviews {
    
    // 顶部距离
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    CGRect rectNav = self.navigationController.navigationBar.frame;
    NSInteger topHeight = rectStatus.size.height + rectNav.size.height;
    
    // 底部距离
    CGRect rectTab = self.tabBarController.tabBar.frame;
    NSInteger bottomHeight = rectTab.size.height;
    
    // 尺寸:
    CGRect rect = self.collectionView.bounds;
    rect.origin = CGPointMake(rect.origin.x, rect.origin.y - topHeight);
    rect.size = CGSizeMake(rect.size.width, rect.size.height - topHeight - bottomHeight);
    self.flowLayout.itemSize = rect.size;
    
    // 横间距
    self.flowLayout.minimumInteritemSpacing = 0;
    // 纵间距
    self.flowLayout.minimumLineSpacing = 0;
}

// 模型集合增加元素方法
- (void)addByDateStr:(NSString *)dateStr andInfo:(NSString *)info {
    
    if ([self.questionDict objectForKey:dateStr] == nil) {
        
        // 拼接 url
        NSString *urlStr = [NSString stringWithFormat:@"http://rest.wufazhuce.com/OneForWeb/one/%@?strDate=%@", info, dateStr];
        NSURL *url = [NSURL URLWithString:urlStr];
        
        // 封装的 GET 请求
        [KCLNetworkTools getWithUrl:url andKey:@"questionAdEntity" completion:^(NSDictionary *dict) {
            QuestionEntity *questionEntity = [QuestionEntity questionEntityWithDict:dict];
            [self.questionDict setObject:questionEntity forKey:dateStr];
            
            // 主线程更新
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        }];
    }
}

// 重写指定日期的 Setter 方法
- (void)setDay:(NSDate *)day {
    
    // date --> str
    NSString *dateStr = [self strWithDate:day];
    
    // 给模型集合 添加元素
    [self addByDateStr:dateStr andInfo:@"getOneQuestionInfo"];
}

// date --> str
- (NSString *)strWithDate:(NSDate *)date {
    
    // 日期格式化
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    return [formatter stringFromDate:date];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

