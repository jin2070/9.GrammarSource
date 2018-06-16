//
//  MoonArry.h
//  MutiBox
//
//  Created by pc on 2018/5/26.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoordinateInit.h"


@interface DegineCrdArry : NSObject

@property(nonatomic,strong)NSMutableArray *coordntArrays;   //数组定义
-(void)addCoordtData:(CoordinateInit *)coordntData;  //坐标对象生成
@end
