//
//  NSDictionaryTools.m
//  TestViewAction
//
//  Created by pc on 2018/9/4.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "NSDictionaryTools.h"

@implementation NSDictionaryTools
-(void)ShowTime
{
    [self A_Test];
}
-(void)A_Test
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"张鑫",@"name",@"123",@"number", nil];
    //得到词典的数量
    NSInteger counta = [dictionary count];
    NSLog(@"--001词典的数量:%ld",counta);
    //得到字典所有key值
    NSEnumerator *enumeratorName = [dictionary keyEnumerator];
    for (NSObject *object in enumeratorName){
        NSLog(@"---002遍历key的值:%@" , object);
    }
    //得到字典所有Value值
    NSEnumerator *enumeratorValue = [dictionary objectEnumerator];
    for (NSObject *object in enumeratorValue){
        NSLog(@"---004遍历Value的值:%@" , object);
    }
    NSObject *object = [dictionary objectForKey:@"name"];
    if (object != nil) {
        NSLog(@"---005通过KEY找到的value是:%@",object);
    }
    
    NSDictionary *dict001 = [[NSDictionary alloc] initWithObjectsAndKeys:@"张绍锋", @"name", @"男", @"sex", nil];
    NSLog(@"\n---006 dict001 = %@ \n", dict001);
    
    // 属性
    // 1 个数
    NSInteger count = dict001.count;
    NSLog(@"\n ---007count = %ld \n", count);
    
    // 2 所有的键
    NSArray *keyArray = dict001.allKeys;
    NSLog(@"\n");
    for (NSString *string in keyArray)
    {
        NSLog(@"---008string = %@", string);
    }
    
    // 3 所有的值
    NSArray *valueArray = dict001.allValues;
    NSLog(@"\n");
    for (NSString *string in valueArray)
    {
        NSLog(@"---009string = %@", string);
    }
    // 字典操作
    // 获取键对应的值
    NSString *value = [dict001 objectForKey:@"name"];
    NSLog(@"\n");
    NSLog(@"---010name = %@", value);
    
    // 可变字典
    NSMutableDictionary *dict002 = [NSMutableDictionary dictionaryWithDictionary:dict001];
    NSLog(@"\n ---011dict002 = %@ \n", dict002);
    // 添加对象
    // 1 setobject时，值必须是非空对象类型，如果值是非对象类型，则报错
    [dict002 setObject:@"大学比业" forKey:@"education"];
    //[dict002 setObject:nil forKey:@"education"]; // 编译报错
    NSLog(@"\n ---012dict002 = %@ \n", dict002);
    
    // 2 setvalue时，不管值是不是对象类型，都不会报错，但对象不会添加到字典中
    [dict002 setValue:@"高级电工" forKey:@"job"];
    //[dict002 setValue:nil forKey:@"job"]; // 可正常编译运行，但对象不会添加到字典中
    NSLog(@"\n ---013dict002 = %@ \n", dict002);
    // 替换指定键对应的值
    [dict002 setValue:@"iOS Dve" forKey:@"job"];
    NSLog(@"\n ---014dict002 = %@ \n", dict002);
    // 删除指定键对应的值
    // 1 删除指定键对应的值
    [dict002 removeObjectForKey:@"job"];
    NSLog(@"\n ---015dict002 = %@ \n", dict002);
    
    // 2 删除指定键数组对应的值
    NSArray *keys = @[@"education", @"sex"];
    [dict002 removeObjectsForKeys:keys];
    NSLog(@"+\n ---016dict002 = %@ \n", dict002);
    
    // 3 删除所有的键值
    [dict002 removeAllObjects];
    NSLog(@"-\n ---017dict002 = %@ \n", dict002);
    // 重新初始化值
    [dict002 setDictionary:dict001];
    NSLog(@"\n ---018dict002 = %@ \n", dict002);

}
-(void)B_Test
{
    NSDictionary *dict1=@{@"k1":@"v1", @"k2":@"v2", @"k3":@"v3"};
    
    //通过key查找value
    NSString* obj=[dict1 objectForKey:@"k3"];
    NSLog(@"value:%@", obj);
    
    //获取所有的key
    NSArray *keys=[dict1 allKeys];
    NSLog(@"所有的键:%@", keys);
    
    //获取所有的值
    NSArray *values=[dict1 allValues];
    NSLog(@"所有的值:%@", values);
    
    //快速枚举法遍历  **枚举的是key**
    for(id obj in dict1)
    {
        NSLog(@"key:%@", obj); //键
        NSLog(@"value:%@", [dict1 objectForKey:obj]); //值
    }
    
    //枚举器法  objectEnumerator 枚举的是值
    NSEnumerator *enumerator=[dict1 objectEnumerator];
    id obja;
    while(obja=[enumerator nextObject])
    {
        NSLog(@"枚举器法obj:%@",obja);
    }
    
    //枚举器法 枚举键
    NSEnumerator *kenumerator=[dict1 keyEnumerator];
    id key;
    while(key=[kenumerator nextObject])
    {
        NSLog(@"键枚举器法key:%@",key);
    }
    
    //字典的长度
    NSUInteger count=dict1.count;
    NSLog(@"字典一共有%lu个键值对",count);
}


@end
