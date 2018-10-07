//
//  ViewController.m
//  TestViewAction
//
//  Created by pc on 2018/7/19.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "ViewController.h"
//1.NSString
//#import "NsstringTools.h"
//2.NSArray
//#import "NSarrayTools.h"
//3.NSDictionary
//#import "NSDictionaryTools.h"
//4.Sqlite
//#import "SqlServiceClass.h"
//#import "SqliteView.h"
//#import "SqlPersentView.h"
//5.Create File Path
//#import "CreateFilePath.h"

//6.NSBundle
//#import "NSbundleTest.h"
//7.FMDatabase
//#import "FMDataView.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)viewDidLoad
{
 
  //  DrawingSomothing *drawsome=[[DrawingSomothing alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self initializeClass:0];
}
-(void)initializeClass:(NSInteger)select
{
    /*
    switch (select) {
        case 1://1.NSString
            [self A_Nstringshowtime];
            break;
        case 2: //2.NSArray
            [self B_Narrayshowtime];
            break;
        case 3: //NSDictionary
            [self C_NSDictionaryShwothim];
            break;
        case 4: //Sqlite
            [self D_Sqlite];
            break;
        case 5://Create File and Path
            [self E_FilePath];
            break;
        case 6:////6.NSbundle
            [self F_NSBundleTest];
            break;
        case 7://7.FMDatabase
            [self G_FMDatabase];
            break;
        default:
            break;
    }
    */
}
/*
//1.NSString
-(void)A_Nstringshowtime
{
    NsstringTools *nstringtool=[[NsstringTools alloc] init];
    [nstringtool ShowTime];
}
//2.NSArray
-(void)B_Narrayshowtime
{
    NSarrayTools *nsarray=[[NSarrayTools alloc] init];
    [nsarray ShowTime];
}
//3.NSDictionary
-(void)C_NSDictionaryShwothim
{
    NSDictionaryTools *ndTools=[[NSDictionaryTools alloc] init];
    [ndTools ShowTime];
    
}
//4.SQLite
-(void)D_Sqlite
{
    
 
    SqlServiceClass *sqlservice=[[SqlServiceClass alloc]init];
    [sqlservice openDB];
    SqliteView *sqliteview=[[SqliteView alloc]initWithFrame:CGRectMake(10, 100, 360, 620)];
    sqliteview.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:sqliteview];

  //  SqlPersentView *persentview=[
}
//5.Create File & Path
-(void)E_FilePath
{

    CreateFilePath *filePath=[[CreateFilePath alloc] init];
    [filePath PrintNSlog];
    
  //  NSString *libaryFile=[CreateFilePath getDocumentPath];
    //NSString *applicationPath=[CreateFilePath getApplicationPath];
    //BOOL check=[CreateFilePath fileIsExistOfPath:@"/Users/pc/Documents/sqlite/or01txt"];
    //NSLog(@"what is the libaryFile: %@",libaryFile);
    //NSLog(@"what is the libaryFile: %@",applicationPath);
    //NSLog(@"is it yes: %@",check?@"yes":@"no");
}
//6.NSbundle
-(void)F_NSBundleTest
{
    NSbundleTest *bundleTest=[[NSbundleTest alloc]initWithFrame:CGRectMake(10, 50, 300, 400)];
    bundleTest.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:bundleTest];
    
}
//7.FMDatabase
-(void)G_FMDatabase
{
    
}
 */
@end
