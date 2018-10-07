//
//  FirstViewController.h
//  HVScrollView
//
//  Created by Libo on 17/6/12.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "BaseViewController.h"

@interface FirstViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *MainTable;

@property (nonatomic,strong) NSMutableArray *menuList;
@property (nonatomic,strong) NSMutableArray *oList;
@property (nonatomic,strong) NSMutableArray *nList;
@end
