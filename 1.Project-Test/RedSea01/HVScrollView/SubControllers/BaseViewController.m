//
//  BaseViewController.m
//  HVScrollView
//
//  Created by Libo on 17/6/14.
//  Copyright © 2017年 iDress. All rights reserved.
//

// ----------- 悬浮菜单SPPageMenu的框架github地址:https://github.com/SPStore/SPPageMenu ---------
// ----------- 本demo地址:https://github.com/SPStore/HVScrollView ----------

#import "BaseViewController.h"
//#import "MJRefresh.h"

NSNotificationName const ChildScrollViewDidScrollNSNotification = @"ChildScrollViewDidScrollNSNotification";
NSNotificationName const ChildScrollViewRefreshStateNSNotification = @"ChildScrollViewRefreshStateNSNotification";

@interface BaseViewController () <UITableViewDataSource,UITableViewDelegate>
//@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger rowCount;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rowCount = 20;
    
    [self.view addSubview:self.tableView];
    self.scrollView = self.tableView;
    
   /*
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 下拉刷新
        [self downPullUpdateData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 上拉加载
        [self upPullLoadMoreData];
    }];
    */
    /*
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
*/
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetDifference = scrollView.contentOffset.y - self.lastContentOffset.y;
   // NSLog(@"offsetDifference: %f scrollView.contentOffset.y: %f, self.lastContentOffset.y:%f",offsetDifference,scrollView.contentOffset.y,self.lastContentOffset.y);
    // 滚动时发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:ChildScrollViewDidScrollNSNotification object:nil userInfo:@{@"scrollingScrollView":scrollView,@"offsetDifference":@(offsetDifference)}];
    self.lastContentOffset = scrollView.contentOffset;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell_1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%zd行",indexPath.row];
 
    return cell;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
       // _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, kScreenW, kScreenH-bottomMargin) style:UITableViewStylePlain];
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, self.view.bounds.size.height-230) style:UITableViewStylePlain];
       // _tableView.contentInset = UIEdgeInsetsMake(kScrollViewBeginTopInset, 0, 0, 0);
       // _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(kScrollViewBeginTopInset, 0, 0, 0);
         _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
         _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.backgroundColor=[UIColor colorWithWhite:1 alpha:0.8];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}
-(void)viewDidDisappear:(BOOL)animated
{
    _tableView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
    _tableView.scrollIndicatorInsets=UIEdgeInsetsMake(0, 0, 0, 0);
    [_tableView setContentOffset:CGPointMake(0, 0)];
}
-(void)updataeTableCell
{
    [super viewWillLayoutSubviews];
    //_tableView.contentInset = UIEdgeInsetsZero;
    // _tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
       [_tableView setContentOffset:CGPointMake(0, 0)];
    _tableView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
    _tableView.scrollIndicatorInsets=UIEdgeInsetsMake(0, 0, 0, 0);
}

@end
