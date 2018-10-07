//
//  ChapterViewController.h
//  TestViewAction
//
//  Created by pc on 2018/10/1.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChapterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
//- (id)init:(NSString *)title andVersesAmount:(NSInteger)num;
@property(nonatomic)NSInteger versesAmount;
@property(nonatomic)NSString *booksName;
@property(nonatomic)NSInteger currentIndex;
@property (nonatomic, retain) IBOutlet UITableView *chapterTableView;
@property (nonatomic, retain) NSMutableArray *menuList;


-(void)getInfoFromMainViewController:(NSString *)title andVersesAmount:(NSInteger)num;
-(void)swipeNotify:(NSNotification *)notification;

@end
