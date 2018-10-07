//
//  CreateFilePath.m
//  TestViewAction
//
//  Created by pc on 2018/9/11.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "CreateFilePath.h"
@interface CreateFilePath()
@property(nonatomic)NSString *homePath;
@property(nonatomic,strong)NSFileManager *manager;
@end
@implementation CreateFilePath
- (instancetype)init {
    self = [super init];
    if (self) {
        self.homePath = NSHomeDirectory();
        self.manager = [NSFileManager defaultManager];
        NSLog(@"根路径地址：%@",self.homePath);
        [self C_ReadContent];
    }
    return self;
}
//获取Document路径
+ (NSString *)getDocumentPath
{
    NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [filePaths objectAtIndex:0];
}

//获取Library路径
+ (NSString *)getLibraryPath
{
    NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [filePaths objectAtIndex:0];
}
-(void)PrintNSlog
{
    
}
//获取应用程序路径
+ (NSString *)getApplicationPath
{
    return NSHomeDirectory();
}
//判断文件是否存在于某个路径中
+ (BOOL)fileIsExistOfPath:(NSString *)filePath
{
    BOOL flag = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        flag = YES;
    } else {
        flag = NO;
    }
    return flag;
}
-(void)A_CreateFileOnPath
{
    //---- 初始化
    NSFileManager *fm  = [NSFileManager defaultManager];
    
    //---- 创建保存的路径
    NSArray *patharr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //取出数组内容
    NSString *path = [patharr objectAtIndex:0];
    //---- path :/Users/liwei/Document
    
    NSString *filePath = [path stringByAppendingPathComponent:@"helloworld.txt"];
    
    //---- filepath :/Users/liwei/Documents/helloword.txt
    
    
    NSString *text = @"我喜欢野游 5.6,121212";
    //---- 定义data
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    //---- 写入文件
    BOOL isOK=[fm createFileAtPath:filePath contents:data attributes:nil];
    
    if (isOK) {
        NSLog(@"One文件创建成功！");
    }else{
        
        NSLog(@"One失败了！");
    }
}
-(void)B_CreatefileTwo
{
    //---- 初始化
    NSString *str = @"我是金春城！";
    [str writeToFile:@"/Users/pc/Documents/sqlite/wows.txt" atomically:YES encoding:NSUTF8StringEncoding error:nil];

}
-(void)C_ReadContent
{
    NSString *filePath=@"/Users/pc/Documents/sqlite/y01txt.txt";
    NSData *data2 = [NSData dataWithContentsOfFile:filePath];
    //  2)将NSData转换为NSString
    NSString *contentStr1 = [[NSString alloc] initWithData:data2 encoding:NSUTF8StringEncoding];
    NSLog(@"fileContent------:%@",contentStr1);
}
@end
