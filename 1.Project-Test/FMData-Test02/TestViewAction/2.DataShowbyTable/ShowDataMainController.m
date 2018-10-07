//
//  ShowDataMainController.m
//  TestViewAction
//
//  Created by pc on 2018/10/1.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "ShowDataMainController.h"
#import "ChapterViewController.h"
#import "FMDatabase.h"

#define kViewControllerKey        @"viewController"
#define kTitleKey                @"title"
#define kDetailKey                @"detail text"
#define kSimpifiedKey           @"simlified name"

@interface ShowDataMainController ()

@end

@implementation ShowDataMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"CFBundleDisplayName",nil);
    self.title = @"聖經和合本";
    self.menuList = [NSMutableArray array];
    self.oList = [NSMutableArray array];
    self.nList = [NSMutableArray array];
    NSString *homePath= NSHomeDirectory();
    NSLog(@"根路径地址：%@",homePath);
    NSString *dbpath = [[NSBundle mainBundle] pathForResource:@"cunp.sqlite3" ofType:nil];
    NSLog(@"根路径地址：%@",dbpath);
    
    FMDatabase* dataBase = [FMDatabase databaseWithPath:dbpath];
    if (![dataBase open]) {
        NSLog(@"Database Open failed!");
        return;
    }else{
        NSLog(@"Database Open Succeed!");
    }
    FMResultSet *resultSet;
    if ([[[NSLocale preferredLanguages] objectAtIndex:0] isEqualToString:@"zh-Hans"])
        resultSet= [dataBase executeQuery:@"select * from books_simpl"];
    else
        resultSet = [dataBase executeQuery:@"select * from books"];
    
    while ([resultSet next]) {
        if ([[resultSet stringForColumn:@"number"] intValue] < 40)
            [self.oList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   [resultSet stringForColumn:@"human"], kTitleKey,
                                   [resultSet stringForColumn:@"chapters"], kDetailKey,
                                   [resultSet stringForColumn:@"simpl"], kSimpifiedKey,
                                   nil]];
        else
            [self.nList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   [resultSet stringForColumn:@"human"], kTitleKey,
                                   [resultSet stringForColumn:@"chapters"], kDetailKey,
                                   [resultSet stringForColumn:@"simpl"], kSimpifiedKey,
                                   nil]];
        }
    [self.menuList addObject:self.oList];
    [self.menuList addObject:self.nList];
    [dataBase close];
    
    self.MainTable.delegate=self;
    self.MainTable.dataSource=self;
    [self.MainTable reloadData];
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.menuList count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.menuList objectAtIndex:section] count];
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return NSLocalizedString(@"OLDTestment",nil);
    else
        return NSLocalizedString(@"NEWTestment",nil);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCellIdentifier = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.opaque = NO;
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
        
        cell.detailTextLabel.backgroundColor = [UIColor yellowColor];
        cell.detailTextLabel.opaque = NO;
        cell.detailTextLabel.textColor = [UIColor grayColor];
        cell.detailTextLabel.highlightedTextColor = [UIColor blueColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    }
    // get the view controller's info dictionary based on the indexPath's row
    NSMutableArray *sublist = [self.menuList objectAtIndex:indexPath.section];
    NSDictionary *dataDictionary = [sublist objectAtIndex:indexPath.row];
    cell.textLabel.text = [dataDictionary valueForKey:kTitleKey];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",
                                 [dataDictionary valueForKey:kSimpifiedKey],
                                 [dataDictionary valueForKey:kDetailKey]];
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *sublist = [self.menuList objectAtIndex:indexPath.section];
    NSMutableDictionary *rowData = [sublist objectAtIndex:indexPath.row];
    ChapterViewController *targetViewController = [rowData objectForKey:kViewControllerKey];
    if (!targetViewController)
    {
    
        targetViewController = [[ChapterViewController alloc] init];
        [targetViewController getInfoFromMainViewController:[rowData objectForKey:kTitleKey] andVersesAmount:[[rowData objectForKey:kDetailKey] intValue]];
      
        [rowData setValue:targetViewController forKey:kViewControllerKey];

    }
    [self.navigationController pushViewController:targetViewController animated:YES];
}





#pragma mark - didReceiveMemoryWaring
//didReceiveMemoryWaring
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
