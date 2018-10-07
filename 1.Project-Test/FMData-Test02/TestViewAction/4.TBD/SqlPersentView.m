//
//  SqlPersentView.m
//  TestViewAction
//
//  Created by pc on 2018/9/15.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "SqlPersentView.h"
//#import "Operator.h"

@interface SqlPersentView ()

@end

@implementation SqlPersentView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)insertValue {
}

- (IBAction)updateValue {
}

- (IBAction)getAllValue {
    [self.searchBar resignFirstResponder];
    
    SqlServiceClass *sqlSer = [[SqlServiceClass alloc] init];
    self.listData = [sqlSer getTestList];
    [self.tableView reloadData];
  //  [self.tableView setNeedsDisplay];
   // [sqlSer release];
}

- (IBAction)deleteValue {
}

- (IBAction)searchValue {
}
#pragma mark -
#pragma mark Table View Data Source Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listData count] + 1;//从第二行开始，第一行不显示数据
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath.row;%ld",indexPath.row);
    NSString *CustomIdentifier =  [NSString stringWithFormat:@"cell%ld",(long)indexPath.row];
    NSLog(@"customidentifier:%@",CustomIdentifier);
    //cell不重用
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomIdentifier];
    NSLog(@"indexPath.row;%ld",indexPath.row);
    if (indexPath.row == 0)
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSLog(@"indexPath.row;%ld",indexPath.row);
    if ( cell == nil ) {
        // cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
        //     reuseIdentifier:CustomIdentifier] autorelease];
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        cell.backgroundColor = [UIColor clearColor];
    }
    NSLog(@"indexPath.row;%ld",indexPath.row);
    if (indexPath.row > 0)
    {
        NSUInteger row = [indexPath row];
        sqlTestList *sqlList = [[sqlTestList alloc] init] ;
        
        if (self.listData != nil)
            sqlList = [self.listData objectAtIndex: (row - 1)];//读取数据的时候也要减一行，从第二行开始
        
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0+40, 10, 70, 30)];
        UILabel *IDLabel = [[UILabel alloc]initWithFrame:CGRectMake(90+40, 10, 70, 30)];
        UILabel *valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(180+40, 10, 70, 30)];
        nameLabel.text = sqlList.sqlname;
        IDLabel.text = sqlList.sqlText;
        valueLabel.text = [NSString stringWithFormat:@"%d",sqlList.sqlID];
        [cell.contentView addSubview:nameLabel];
        [cell.contentView addSubview:IDLabel];
        [cell.contentView addSubview:valueLabel];
        //   [nameLabel release];
        //  [IDLabel release];
        //     [valueLabel release];
    }
    else
    {
        for (int i = 0; i < 3; i ++) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(90 * i + 40, 10, 70 , 30)];
            NSArray *array = [NSArray arrayWithObjects:@"姓名",@"ID",@"电话", nil];
            label.text = [array objectAtIndex:i];
            label.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:label];
            //    [label release];
        }
    }
    return cell;
    
}
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.searchBar resignFirstResponder];
    if (indexPath.row == 0) {
        return nil;//让第一行不能点击
    }
    else
        return indexPath;
}
/*
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString *CustomIdentifier =  [NSString stringWithFormat:@"cell%ld",(long)indexPath.row];
    //cell不重用
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomIdentifier];
    if (indexPath.row == 0)
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ( cell == nil ) {
        // cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
        //     reuseIdentifier:CustomIdentifier] autorelease];
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        cell.backgroundColor = [UIColor clearColor];
    }
    if (indexPath.row > 0)
    {
        NSUInteger row = [indexPath row];
        sqlTestList *sqlList = [[sqlTestList alloc] init] ;
        
        if (self.listData != nil)
            sqlList = [self.listData objectAtIndex: (row - 1)];//读取数据的时候也要减一行，从第二行开始
        
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0+40, 10, 70, 30)];
        UILabel *IDLabel = [[UILabel alloc]initWithFrame:CGRectMake(90+40, 10, 70, 30)];
        UILabel *valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(180+40, 10, 70, 30)];
        nameLabel.text = sqlList.sqlname;
        IDLabel.text = sqlList.sqlText;
        valueLabel.text = [NSString stringWithFormat:@"%d",sqlList.sqlID];
        [cell.contentView addSubview:nameLabel];
        [cell.contentView addSubview:IDLabel];
        [cell.contentView addSubview:valueLabel];
        //   [nameLabel release];
        //  [IDLabel release];
        //     [valueLabel release];
    }
    else
    {
        for (int i = 0; i < 3; i ++) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(90 * i + 40, 10, 70 , 30)];
            NSArray *array = [NSArray arrayWithObjects:@"姓名",@"ID",@"电话", nil];
            label.text = [array objectAtIndex:i];
            label.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:label];
            //    [label release];
        }
    }
    return cell;
}

- (NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.searchBar resignFirstResponder];
    if (indexPath.row == 0) {
        return nil;//让第一行不能点击
    }
    else
        return indexPath;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return [self.listData count] + 1;//从第二行开始，第一行不显示数据
}
*/
@end
