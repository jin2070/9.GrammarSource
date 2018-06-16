//
//  DrawingSecond.m
//  MutiBox
//
//  Created by pc on 2018/6/9.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "DrawingSecond.h"
#define MULTIPLESCONDHAND 1.3 //坐标长度
#define ADJUSTCOORDINATESECONDE -100 //调整高度
@implementation DrawingSecond
-(void)DrawingSecondHand
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    //画圆
    CGContextSetRGBStrokeColor(context,1,0,1,1);//画笔线的颜色
    CGContextSetLineWidth(context, 2.0);//线的宽度
    //初始化&生产60个坐标
    if(!self.Arraysinit){
        self.Arraysinit=[[InitMakingArrays alloc] init];
    }
    //开始画出来
    int i;
    i=self.countround;  //秒针的位置跳动

        self.coordntDatas=[self.Arraysinit.coordntArrays objectAtIndex:i];
        CGPoint aPoints[2];//坐标点
        aPoints[0] =CGPointMake(self.screenWithFromControll/2,self.screenHeightFromControll/2+ADJUSTCOORDINATESECONDE);//坐标1
        aPoints[1] =CGPointMake(self.coordntDatas.x*MULTIPLESCONDHAND+self.screenWithFromControll/2, self.coordntDatas.y*MULTIPLESCONDHAND+self.screenHeightFromControll/2+ADJUSTCOORDINATESECONDE);//坐标2
        CGContextAddLines(context, aPoints, 2);//添加线
        CGContextDrawPath(context, kCGPathStroke); //绘制路径

    
}



@end
