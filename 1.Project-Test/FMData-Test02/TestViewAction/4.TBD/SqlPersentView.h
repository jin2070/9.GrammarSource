//
//  SqlPersentView.h
//  TestViewAction
//
//  Created by pc on 2018/9/15.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SqlServiceClass.h"
@interface SqlPersentView : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic)NSArray *listData;

- (IBAction)insertValue;
- (IBAction)updateValue;
- (IBAction)getAllValue;
- (IBAction)deleteValue;
- (IBAction)searchValue;


@end
