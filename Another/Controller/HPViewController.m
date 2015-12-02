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

@interface HPViewController () <UICollectionViewDataSource>

///  指定日期
@property (nonatomic, strong) NSDate *day;
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
    
    self.day = [NSDate date];
    
    // Register cell classes
    [self.collectionView registerClass:[HPViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
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
    
    if ([self.hpDict objectForKey:dateStr] == nil) {
        
        // 拼接 url
        NSString *urlStr = [NSString stringWithFormat:@"http://rest.wufazhuce.com/OneForWeb/one/%@?strDate=%@", info, dateStr];
        NSURL *url = [NSURL URLWithString:urlStr];
        
        // 封装的 GET 请求
        [KCLNetworkTools getWithUrl:url andKey:@"hpEntity" completion:^(NSDictionary *dict) {
            HPEntity *hpEntity = [HPEntity hpEntityWithDict:dict];
            [self.hpDict setObject:hpEntity forKey:dateStr];
            
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
    [self addByDateStr:dateStr andInfo:@"getHpinfo"];
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
    return self.hpDict.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HPViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // key
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow: -indexPath.row * 24 * 60 * 60];
    NSString *key = [self strWithDate:date];
    [cell setWithModel:[self.hpDict objectForKey:key]];

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


