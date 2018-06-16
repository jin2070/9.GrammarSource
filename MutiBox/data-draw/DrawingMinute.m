//
//  DrawingMinute.m
//  MutiBox
//
//  Created by pc on 2018/6/9.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "DrawingMinute.h"
#define MULTIPLESCONDHAND 1.2 //坐标长度
#define ADJUSTCOORDINATEMINUTE -100 //调整高度
@interface DrawingMinute()

@end

@implementation DrawingMinute



-(void)DrawingMinuteHand
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    //画圆
    CGContextSetRGBStrokeColor(context,1,0,0,1);//画笔线的颜色
    CGContextSetLineWidth(context, 2.0);//线的宽度
    //self.iabc=0;
    //初始化&生产60个坐标
    if(!self.Arraysinit){
        self.Arraysinit=[[InitMakingArrays alloc] init];
    }
    //开始画出来
    //for(j=0;j<=self.countround;j++)
    //{
    int i;
    i=self.runningMinute;
    NSLog(@"what a:%d",self.countround);
    NSLog(@"what kkk:%d",i);
   // NSLog(@"what iabc:%d",self.iabc);
   //     if(self.i==59){self.i=0;};
   // }
   // i=self.countround; //接受Controller跳动次数
    
    self.coordntDatas=[self.Arraysinit.coordntArrays objectAtIndex:i];
    CGPoint aPoints[2];//坐标点
    aPoints[0] =CGPointMake(self.screenWithFromControll/2,self.screenHeightFromControll/2+ADJUSTCOORDINATEMINUTE);//坐标1
    aPoints[1] =CGPointMake(self.coordntDatas.x*MULTIPLESCONDHAND+self.screenWithFromControll/2, self.coordntDatas.y*MULTIPLESCONDHAND+self.screenHeightFromControll/2+ADJUSTCOORDINATEMINUTE);//坐标2
    CGContextAddLines(context, aPoints, 2);//添加线
    CGContextDrawPath(context, kCGPathStroke); //绘制路径
    //  }
    
}


@end
