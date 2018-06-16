//
//  DrawFoundationSuperClass.h
//  MutiBox
//
//  Created by pc on 2018/6/9.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocal-Draw.h" //协议画图基础接口
#import "InitMakingArrays.h" //生成坐标数组
#import "DegineCrdArry.h"  //数组生成函数设计
#import "CoordinateInit.h" //坐标原始数据
#define MULTIPLE 1.5 //圆圈画出来时的半径参数

@interface DrawFoundationSuperClass : UIView<Protocal_Draw>
@property(nonatomic)float screenWithFromControll; //主窗口屏幕大小接受FromController
@property(nonatomic)float screenHeightFromControll;
@property(nonatomic)int countround; //点击数量的接口
@property(nonatomic,strong)InitMakingArrays *Arraysinit;  //初始化生成坐标组
@property(nonatomic,strong)CoordinateInit *coordntDatas;  //坐标单位

@end
