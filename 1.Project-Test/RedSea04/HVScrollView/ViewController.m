//
//  ViewController.m
//  HVScrollView
//
//  Created by Libo on 17/6/14.
//  Copyright © 2017年 iDress. All rights reserved.
//

// ----------- 悬浮菜单SPPageMenu的框架github地址:https://github.com/SPStore/SPPageMenu ---------
// ----------- 本demo地址:https://github.com/SPStore/HVScrollView ----------

#import "ViewController.h"
#import "MyHeaderView.h"
#import "SPPageMenu.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourViewController.h"

#import "UINavigationController+NavAlpha.h"

#define kHeaderViewH 200
#define kPageMenuH 40
#define kNaviH (isIPhoneX ? 84 : 64)

#define isIPhoneX kScreenH==812

@interface ViewController () <SPPageMenuDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic)CGFloat scrollViewY;
@property(nonatomic)CGFloat scrollViewH;
@property (nonatomic, strong) MyHeaderView *headerView;
@property (nonatomic, strong) SPPageMenu *pageMenu;
@property(nonatomic, strong)FirstViewController *firstView;
@property(nonatomic, strong)SecondViewController *secondView;
@property(nonatomic, strong)ThirdViewController *thirdView;
@property(nonatomic, strong)FourViewController *fourView;
@end

@implementation ViewController
#pragma mark -打开初始化&加载子图
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"上拉翻页";
    
    /*
     if (@available(iOS 11.0, *)) {
     self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
     } else {
     // Fallback on earlier versions
     self.automaticallyAdjustsScrollViewInsets = NO;
     }
     */
    self.navBarTintColor = [UIColor blackColor];
    self.navAlpha = 0;
    self.navTitleColor = [UIColor clearColor];
    
    self.scrollViewY=240;
    self.scrollViewH=kScreenH-self.scrollViewY;
 
    // 添加一个全屏的scrollView，头部视图，悬浮菜单
    
    self.headerView.imageHeight=kScreenH;
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.pageMenu];
    [self.view addSubview:self.scrollView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshState:) name:ChildScrollViewRefreshStateNSNotification object:nil];
    //接收Menu拖动的动作
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observeButtonTouch:) name:@"NotiButtonTouch"object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observeScrollTouch:) name:@"NotiAnyname"object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(secondViewCreatedNotification:) name:@"newSecondView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(thirdViewCreatedNotification:) name:@"newThirdView" object:nil];
    
}
- (SPPageMenu *)pageMenu {
    
    if (!_pageMenu) {
        _pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 200, kScreenW, kPageMenuH) trackerStyle:SPPageMenuTrackerStyleLineLongerThanItem];
        [_pageMenu setItems:@[@"卷",@"章",@"节",@"查找🔍"] selectedItemIndex:0];
        _pageMenu.delegate = self;
        _pageMenu.itemTitleFont = [UIFont systemFontOfSize:16];
        _pageMenu.selectedItemTitleColor = [UIColor blackColor];
        _pageMenu.unSelectedItemTitleColor = [UIColor colorWithWhite:0 alpha:0.6];
        _pageMenu.tracker.backgroundColor = [UIColor yellowColor];
        _pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollEqualWidths;
        _pageMenu.bridgeScrollView = self.scrollView;  //导入总成scrollView
        
    }
    return _pageMenu;
}
- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        // _scrollView.frame = CGRectMake(0, 0, kScreenW, kScreenH-bottomMargin);
        _scrollView.frame = CGRectMake(0, 240, kScreenW, kScreenH-34);
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = YES;
     //   _scrollView.backgroundColor=[UIColor yellowColor];
       _scrollView.showsHorizontalScrollIndicator = YES;
        _scrollView.contentSize = CGSizeMake(kScreenW*4, 0);//2就是有几张侧翻
        _scrollView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
        //子图初始化
        _firstView=[[FirstViewController alloc] init];
        _secondView=[[SecondViewController alloc] init];
        _thirdView=[[ThirdViewController alloc] init];
        _fourView=[[FourViewController alloc] init];
        [self addChildViewController:self.firstView];
        [self addChildViewController:self.secondView];
        [self addChildViewController:self.thirdView];
        [self addChildViewController:self.fourView];
  
        // 先将第一个子控制的view添加到scrollView上去
         [self.scrollView addSubview:self.childViewControllers[0].view];
    }
    return _scrollView;
}

-(MyHeaderView *)headerView {
    
    if (!_headerView) {
        _headerView = [[MyHeaderView alloc] init];
        _headerView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
        _headerView.backgroundColor = [UIColor blueColor];
    }
    return _headerView;
}

#pragma mark - SPPageMenuDelegate 确定哪个子图
//按菜单或切换子图时，更新子图显示
- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex
{
  
    if (!self.childViewControllers.count){return;} //是否子图都有
    // 如果上一次点击的button下标与当前点击的buton下标之差大于等于2,说明跨界面移动了,此时不动画.
    //根据菜单栏点击，总成图的显示宽度
    [self.scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width * toIndex, 0) animated:NO];
    
    //@@@每次切换子控制时重新更新显示子控制图，以baseView基础class更新
    BaseViewController *targetViewController = self.childViewControllers[toIndex];
    // 如果已经加载过，就不再加载，每次都加载会
  if ([targetViewController isViewLoaded])
  {
      //return;
  }
    
    // 来到这里必然是第一次加载控制器的view，这个属性是为了防止下面的偏移量的改变导致走scrollViewDidScroll
    targetViewController.isFirstViewLoaded = YES;
    targetViewController.view.frame = CGRectMake(kScreenW*toIndex, 0, kScreenW, kScreenH);//重点，必须加载，不然不显示
    [self.scrollView addSubview:targetViewController.view];//重点，必须加载，不然不显示
    
    //根据点击的子图，即时更新table高度
    switch (toIndex) {
        case 0:
            _firstView.isFirstViewLoaded=YES;
            //      self.fourView.tableView.frame=CGRectMake(0, 0, kScreenW, kScreenH-self.scrollViewY)
            break;
        case 1:
            _secondView.isFirstViewLoaded=YES;
          //  self.secondView.tableView.frame=CGRectMake(0, 0, kScreenW, kScreenH-self.scrollViewY);
           self.secondView.chapterTableView.frame=CGRectMake(0, 0, kScreenW, kScreenH-self.scrollViewY);
            NSLog(@"tableviewH case----------------------------%f",kScreenH-self.scrollViewY);
            break;
        case 2:
            _thirdView.isFirstViewLoaded=YES;
          //  self.thirdView.tableView.frame=CGRectMake(0, 0, kScreenW, kScreenH-self.scrollViewY);
            self.thirdView.myTextView.frame=CGRectMake(0, 0, kScreenW, kScreenH-self.scrollViewY);
            break;
        case 3:
            _fourView.isFirstViewLoaded=YES;
            self.fourView.tableView.frame=CGRectMake(0, 0, kScreenW, kScreenH-self.scrollViewY);
            break;
        default:
            break;
    }
    
}
#pragma mark - 通知
#pragma mark - KVO
- (void)secondViewCreatedNotification:(NSNotification *)notification
{
    /*
     从FirstViews接收到通知后，传入SecondView的指针，
     把之前的childControllerView都删除，重新按照新的4个View建立起来childControllView
     用[self pageMenu:self.pageMenu itemSelectedFromIndex:0 toIndex:1];更新menu第二页的内容
     */
    self.secondView = [notification.userInfo objectForKey:@"secondViewKey"];
   // [self.childViewControllers replacementObjectForKeyedArchi
    for (UIViewController *vc in self.childViewControllers) {
        [vc willMoveToParentViewController:nil];
        [vc removeFromParentViewController];
    }
    
    [self addChildViewController:self.firstView];
    [self addChildViewController:self.secondView];
    [self addChildViewController:self.thirdView];
    [self addChildViewController:self.fourView];
   
    self.pageMenu.numberViewControllerSelected=SecondViewControllerSelected;
    [self pageMenu:self.pageMenu itemSelectedFromIndex:0 toIndex:1];
}
- (void)thirdViewCreatedNotification:(NSNotification *)notification
{
    /*
     从FirstViews接收到通知后，传入SecondView的指针，
     把之前的childControllerView都删除，重新按照新的4个View建立起来childControllView
     用[self pageMenu:self.pageMenu itemSelectedFromIndex:0 toIndex:1];更新menu第二页的内容
     */
    self.thirdView = [notification.userInfo objectForKey:@"thirdViewKey"];
    // [self.childViewControllers replacementObjectForKeyedArchi
    for (UIViewController *vc in self.childViewControllers) {
        [vc willMoveToParentViewController:nil];
        [vc removeFromParentViewController];
    }
    
    [self addChildViewController:self.firstView];
    [self addChildViewController:self.secondView];
    [self addChildViewController:self.thirdView];
    [self addChildViewController:self.fourView];
  
    self.pageMenu.numberViewControllerSelected=ThirdViewControllerSelected;
    [self pageMenu:self.pageMenu itemSelectedFromIndex:1 toIndex:2];
}
//收到itemscroll上的按键通知
-(void)observeButtonTouch:(NSNotification *)notification{

    //接收移动的时间段距离
    NSNumber *obsNumY=[notification.userInfo objectForKey:@"offsetY"];
    CGFloat distanceY=[obsNumY floatValue];
    [self followScrollingScrollView:distanceY];
}
//收到itemScroll的Scroll通知"
-(void)observeScrollTouch:(NSNotification *)notification{
     //接收移动的时间段距离
    CGFloat distanceY=self.pageMenu.itemScrollView.FscrollMovepoint.y;
    [self followScrollingScrollView:distanceY];
}
- (void)followScrollingScrollView:(CGFloat)distanceY{
    //上移或下移PageMenu位置
    CGRect pageMenuFrame = self.pageMenu.frame;
    pageMenuFrame.origin.y+=distanceY;
    // NSLog(@"tableviewH %f",pageMenuFrame.origin.y);
   //上移或下移总合成scroview位置,并设定上下限度
    self.scrollViewY+=distanceY;
    if(self.scrollViewY>kScreenH-80){
        self.scrollViewY=kScreenH-80;
        pageMenuFrame.origin.y=self.scrollViewY-40;
    }
    if(self.scrollViewY<150){
        self.scrollViewY=150;
         pageMenuFrame.origin.y=self.scrollViewY-40;
    }
    self.pageMenu.frame = pageMenuFrame;
    
    //即时更新各子图tableview的高度
    self.scrollView.frame=CGRectMake(0, self.scrollViewY, kScreenW, kScreenH-self.scrollViewY);
    self.firstView.tableView.frame=CGRectMake(0, 0, kScreenW, kScreenH-self.scrollViewY);
    if(self.secondView.isFirstViewLoaded){self.secondView.tableView.frame=CGRectMake(0, 0, kScreenW, kScreenH-self.scrollViewY);}
    if(self.thirdView.isFirstViewLoaded){self.thirdView.tableView.frame=CGRectMake(0, 0, kScreenW, kScreenH-self.scrollViewY);}
    if(self.fourView.isFirstViewLoaded){self.fourView.tableView.frame=CGRectMake(0, 0, kScreenW, kScreenH-self.scrollViewY);}
 //   self.fourView.tableView.frame=CGRectMake(0, 0, kScreenW, kScreenH-self.scrollViewY);
}


#pragma mark - 废弃保留区域
//以下不使用函数
- (void)refreshState:(NSNotification *)noti {
         BOOL state = [noti.userInfo[@"isRefreshing"] boolValue];
         // 正在刷新时禁止self.scrollView滑动
         self.scrollView.scrollEnabled = !state;
}
     
 - (void)scrollViewDidScroll:(UIScrollView *)scrollView {
 
     BaseViewController *baseVc = self.childViewControllers[self.pageMenu.selectedItemIndex];
     static int i=0;
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         if (baseVc.scrollView.contentSize.height < kScreenH && [baseVc isViewLoaded]) {
             i++;
          //   NSLog(@"发现了 %d 次",i);
     //        [baseVc.scrollView setContentOffset:CGPointMake(0, -kScrollViewBeginTopInset) animated:YES];
         }
     });
 }
 
 - (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
     BaseViewController *baseVc = self.childViewControllers[self.pageMenu.selectedItemIndex];
     
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         if (baseVc.scrollView.contentSize.height < kScreenH && [baseVc isViewLoaded]) {
        //     [baseVc.scrollView setContentOffset:CGPointMake(0, -kScrollViewBeginTopInset) animated:YES];
         }
     });
 }
 
//内存不足时释放内存

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 


@end




