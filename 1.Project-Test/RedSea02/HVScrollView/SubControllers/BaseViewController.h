//
//  BaseViewController.h
//  HVScrollView
//
//  Created by Libo on 17/6/14.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import <UIKit/UIKit.h>

//#define isIPhoneX kScreenH==812
//#define bottomMargin (isIPhoneX ? 34 : 0)

UIKIT_EXTERN NSNotificationName const ChildScrollViewDidScrollNSNotification;
UIKIT_EXTERN NSNotificationName const ChildScrollViewRefreshStateNSNotification;

@interface BaseViewController : UIViewController
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) CGPoint lastContentOffset;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL isFirstViewLoaded;
//-(void)updataeTableCell;
@property (nonatomic, assign) BOOL refreshState;

@end
