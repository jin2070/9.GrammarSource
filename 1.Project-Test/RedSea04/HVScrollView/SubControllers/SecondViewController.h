//
//  SecondViewController.h
//  HVScrollView
//
//  Created by Libo on 17/6/12.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "BaseViewController.h"

@interface SecondViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic)NSInteger versesAmount;
@property(nonatomic)NSString *booksName;
@property(nonatomic)NSInteger currentIndex;
@property (nonatomic, retain) IBOutlet UITableView *chapterTableView;
@property (nonatomic, retain) NSMutableArray *menuList;


-(void)getInfoFromMainViewController:(NSString *)title andVersesAmount:(NSInteger)num;
-(void)BuildTableDataWithSql;
-(void)swipeNotify:(NSNotification *)notification;
@end
