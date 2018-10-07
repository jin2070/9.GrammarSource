//
//  Operator.m
//  TestViewAction
//
//  Created by pc on 2018/9/14.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "Operator.h"

@interface Operator ()

@end

@implementation Operator
@synthesize idValue;
@synthesize textPhone;
@synthesize oprateType;
@synthesize sqlValue;
@synthesize textName;

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"返回"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(dismiss:)];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"保存"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(saveValue:)];
    [[self navigationItem] setLeftBarButtonItem:backButton];
    [[self navigationItem] setRightBarButtonItem:saveButton];
    
   // [backButton release];
   // [saveButton release];
    
    if (oprateType == 0) {
        [self.navigationItem setTitle:@"数据插入"];
    }
    else if(oprateType == 1){
        [self.navigationItem setTitle:@"数据更新"];
        idValue.text = [NSString stringWithFormat:@"%d", sqlValue.sqlID];
        textPhone.text = sqlValue.sqlText;
        textName.text = sqlValue.sqlname;
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dismiss:(id)sender{
    [[self parentViewController] dismissViewControllerAnimated:YES completion:^{
        //code;
    }];
}
- (void)saveValue:(id)sender{
    
    
    if (idValue.text.length == 0) {
        UIAlertController *alertview=[UIAlertController alertControllerWithTitle:@"提示" message:@"请输入ID" preferredStyle:UIAlertControllerStyleAlert];
        
        // UIAlertControllerStyleActionSheet 是显示在屏幕底部
        UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *defult = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertview addAction:cancel];
        [alertview addAction:defult];
   
    
     //   [alert ];
      //  [alert release];
        return;
    }
    if (textPhone.text.length == 0) {
        UIAlertController *alertview=[UIAlertController alertControllerWithTitle:@"提示" message:@"请输入电话" preferredStyle:UIAlertControllerStyleAlert];
        
        // UIAlertControllerStyleActionSheet 是显示在屏幕底部
        UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *defult = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertview addAction:cancel];
        [alertview addAction:defult];
        
       // [alert show];
       // [alert release];
        return;
    }
    if (textName.text.length == 0) {
         UIAlertController *alertview=[UIAlertController alertControllerWithTitle:@"提示" message:@"请输入姓名" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *defult = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertview addAction:cancel];
        [alertview addAction:defult];

    //    [alert show];
     //   [alert release];
        return;
    }
    
    
    
    //初始化数据库
    SqlServiceClass *sqlSer = [[SqlServiceClass alloc] init];
    
    //数据库插入
    if (oprateType == 0) {
        
        sqlTestList *sqlInsert = [[sqlTestList alloc]init];
        sqlInsert.sqlID = [idValue.text intValue];
        sqlInsert.sqlText = textPhone.text;
        sqlInsert.sqlname = textName.text;
        
        //调用封装好的数据库插入函数
        if ([sqlSer insertTestList:sqlInsert]) {
            UIAlertController *alertview=[UIAlertController alertControllerWithTitle:@"提示" message:@"插入数据成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *defult = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertview addAction:cancel];
            [alertview addAction:defult];
            
       
        //    [alert show];
         //   [alert release];
        }
        else {
            UIAlertController *alertview=[UIAlertController alertControllerWithTitle:@"提示" message:@"插入数据失败" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *defult = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertview addAction:cancel];
            [alertview addAction:defult];
            
          //  [alert show];
          //  [alert release];
            
        }
 //       [sqlInsert release];
        
    }
    //数据库更新
    if(oprateType == 1){
        
        sqlTestList *newValue = [[sqlTestList alloc]init];
        newValue.sqlID = [idValue.text intValue];
        newValue.sqlText = textPhone.text;
        newValue.sqlname = textName.text;
        
        //调用封装好的更新数据库函数
        if ([sqlSer updateTestList:newValue]) {
            UIAlertController *alertview=[UIAlertController alertControllerWithTitle:@"提示" message:@"更新数据成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *defult = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertview addAction:cancel];
            [alertview addAction:defult];
 
        }
        else {
            UIAlertController *alertview=[UIAlertController alertControllerWithTitle:@"提示" message:@"更新数据失败" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *defult = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertview addAction:cancel];
            [alertview addAction:defult];

            
        }
        
    }
    
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
