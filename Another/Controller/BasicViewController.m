//
//  BasicViewController.m
//  Another
//
//  Created by Aixtuz Kang on 15/12/3.
//  Copyright © 2015年 Aixtuz Kang. All rights reserved.
//

#import "BasicViewController.h"

@interface BasicViewController () <UICollectionViewDataSource, UIScrollViewDelegate>

///  指定日期
@property (nonatomic, strong) NSDate *day;

@end

@implementation BasicViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.day = [NSDate date];
    self.day = [NSDate dateWithTimeIntervalSinceNow: - 24 * 60 * 60];
}

// 设置 flowlayout
- (void)layoutWithFlow:(UICollectionViewFlowLayout *)flow {
    
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
    flow.itemSize = rect.size;
    
    // 横间距
    flow.minimumInteritemSpacing = 0;
    // 纵间距
    flow.minimumLineSpacing = 0;
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


#pragma scrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    scrollView.userInteractionEnabled = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    // 刷新数据
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width + 1;
    self.day = [NSDate dateWithTimeIntervalSinceNow: -index * 24 *60 *60];
    scrollView.userInteractionEnabled = YES;
}

@end

