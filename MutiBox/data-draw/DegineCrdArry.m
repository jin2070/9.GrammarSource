//
//  MoonArry.m
//  MutiBox
//
//  Created by pc on 2018/5/26.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "DegineCrdArry.h"
@interface DegineCrdArry()

@end
@implementation DegineCrdArry
-(NSMutableArray *)coordntArrays
{
    if(!_coordntArrays){
        _coordntArrays=[[NSMutableArray alloc] init];  //生成数组初始化
    }
    return _coordntArrays;
}
-(void)addCoordtData:(CoordinateInit *)coordntData//添加数组成员的函数设计
{
     [self.coordntArrays addObject:coordntData];  //添加数组成员的函数设计
}

@end
