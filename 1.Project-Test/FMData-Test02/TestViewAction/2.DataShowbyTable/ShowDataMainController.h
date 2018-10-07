//
//  ShowDataMainController.h
//  TestViewAction
//
//  Created by pc on 2018/10/1.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowDataMainController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *MainTable;

@property (nonatomic,strong) NSMutableArray *menuList;
@property (nonatomic,strong) NSMutableArray *oList;
@property (nonatomic,strong) NSMutableArray *nList;
@end
