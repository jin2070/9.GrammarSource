//
//  FMDataMainController.m
//  TestViewAction
//
//  Created by pc on 2018/9/30.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "FMDataMainController.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
//控件位置
#define TXTHEIGHT 50
#define TXTLEFT 80
#define TXTRIGHT 200
#define LBLLEFT 10
#define LBLRIGHT 60
#define BTNLEFT 100
#define BTNRIGHT 150

@interface FMDataMainController ()
//输入控件
@property (nonatomic) IBOutlet UITextField *nameField;
@property (nonatomic) IBOutlet UITextField *priceField;
@property (nonatomic) IBOutlet UITextField *idField;
@property(nonatomic)UILabel *nameLabel;
@property(nonatomic)UILabel *priceLabel;
@property(nonatomic)UILabel *idLabel;
@property(nonatomic) UIButton *addButton;
@property(nonatomic) UIButton *delButton;
@property(nonatomic) UIButton *replaceButton;
@property(nonatomic) UIButton *findButton;
@property(nonatomic,strong)FMDatabase *dataBase;
@end

@implementation FMDataMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initInputView];
    [self CreateTable];
}
//获取dabase存放的路径
-(NSString *)getPath
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingPathComponent:@"HelloTable.db"];
}

-(void)initInputView
{
    self.nameField=[[UITextField alloc]initWithFrame:CGRectMake(TXTLEFT, 100, TXTRIGHT, TXTHEIGHT)];
    self.nameField.backgroundColor=[UIColor lightGrayColor];
    self.nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(LBLLEFT, 100, LBLRIGHT, TXTHEIGHT)];
    [self.nameLabel setText:@"Name"];
    [self.nameLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.nameField];
    
    self.priceField=[[UITextField alloc]initWithFrame:CGRectMake(TXTLEFT, 170, TXTRIGHT, TXTHEIGHT)];
    self.priceField.backgroundColor=[UIColor lightGrayColor];
    self.priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(LBLLEFT, 170, LBLRIGHT, TXTHEIGHT)];
    [self.priceLabel setText:@"Price"];
    [self.priceLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:self.priceLabel];
    [self.view addSubview:self.priceField];
    
    self.addButton=[[UIButton alloc] initWithFrame:CGRectMake(BTNLEFT, 250, BTNRIGHT, TXTHEIGHT)];
    [self.addButton setTitle:@"增加数据" forState:UIControlStateNormal];
    [self.addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.addButton.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:self.addButton];
    [self.addButton addTarget:self action:@selector(InsertData:) forControlEvents:UIControlEventTouchUpInside];
    
    self.idField=[[UITextField alloc]initWithFrame:CGRectMake(TXTLEFT, 320, TXTRIGHT, TXTHEIGHT)];
    self.idField.backgroundColor=[UIColor lightGrayColor];
    self.idLabel=[[UILabel alloc]initWithFrame:CGRectMake(LBLLEFT, 320, LBLRIGHT, TXTHEIGHT)];
    [self.idLabel setText:@"ID = "];
    [self.idLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:self.idField];
    [self.view addSubview:self.idLabel];
    
    self.findButton=[[UIButton alloc] initWithFrame:CGRectMake(BTNLEFT, 390, BTNRIGHT, TXTHEIGHT)];
    [self.findButton setTitle:@"查找数据" forState:UIControlStateNormal];
    [self.findButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.findButton.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:self.findButton];
    [self.findButton addTarget:self action:@selector(FindSqlData:) forControlEvents:UIControlEventTouchUpInside];
    
    self.replaceButton=[[UIButton alloc] initWithFrame:CGRectMake(BTNLEFT, 460, BTNRIGHT, TXTHEIGHT)];
    [self.replaceButton setTitle:@"更改数据" forState:UIControlStateNormal];
    [self.replaceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.replaceButton.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:self.replaceButton];
    [self.replaceButton addTarget:self action:@selector(FindSqlData:) forControlEvents:UIControlEventTouchUpInside];
    
    self.delButton=[[UIButton alloc] initWithFrame:CGRectMake(BTNLEFT, 530, BTNRIGHT, TXTHEIGHT)];
    [self.delButton setTitle:@"删除数据" forState:UIControlStateNormal];
    [self.delButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.delButton.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:self.delButton];
    [self.delButton addTarget:self action:@selector(FindSqlData:) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark - ExecFunction
-(void)CreateTable
{
    self.dataBase = [FMDatabase databaseWithPath:[self getPath]];
    NSLog(@"databas Path     %@",[self getPath]);
    if (![self.dataBase open]){
        NSLog(@"OPEN FAIL");
    }
  //  NSString *sql = @"CREATE TABLE IF NOT EXISTS studentInfo(sid INTEGER,username varchar(32),password varchar(32),score INTEGER)";
//    NSString *sql = @"CREATE TABLE IF NOT EXISTS movies (id integer primary key autoincrement,name text,actor text,country text)";
    NSString *sql = @"CREATE TABLE IF NOT EXISTS price(id integer primary key autoincrement,name text,price text)";
    [self.dataBase executeUpdate:sql];
    [self.dataBase close];
}

-(void)InsertData:(UIButton *)sender
{
    NSString *name=self.nameField.text;
    NSString *price=self.priceField.text;
 //   NSString *country=@"China";
    if ([self.dataBase open]) {
        NSString *insert = [NSString stringWithFormat:@"insert into price(name,price) values ('%@','%@')",name,price];
        //执行语句
        BOOL bb = [self.dataBase executeUpdate:insert];
        if (bb) {
            NSLog(@"添加成功");
        }
        [self.dataBase close];
      
    }

}
-(void)FindSqlData:(UIButton *)sender
{
    NSString *name=self.nameField.text;
    //NSString *price=self.priceField.text;
  //  NSMutableArray *array = [NSMutableArray array];
    if ([self.dataBase open]) {
        //模糊查询关键字
        NSString *sql = [NSString stringWithFormat:@"select  * from price where name like \"%%%@%%\"",name];
        //排序的关键字 order by
        
        FMResultSet *resultSet = [self.dataBase executeQuery:sql];
        while ([resultSet next]) {
            NSString *sname = [resultSet stringForColumn:@"name"];
            NSString *sprice = [resultSet stringForColumn:@"price"];
          //  NSString *country = [set stringForColumn:@"country"];
          //  Movie *mo = [[Movie alloc] init];
            self.nameField.text = sname;
            self.priceField.text= sprice;
       //     mo.country = country;
   //         [array addObject:mo];
            
        }
        [self.dataBase close];
      //  return array;
    }
}
-(void)DeleteSqlData:(UIButton *)sender
{
    
}
-(void)replaceSqlData:(UIButton *)sender
{
    
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

@end
