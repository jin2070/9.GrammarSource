//
//  DrawingSmallPin.m
//  MutiBox
//
//  Created by pc on 2018/6/11.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//
#define MULTIPLEoutS 0.23 //坐标长度
#define MULTIPLEinS 0.00 //坐标长度
#define MULTIPLEnumS 0.17 //坐标长度
#define MULTIPLESMALLHAND 0.3 //坐标长度
#define ADJUSTSMALLPIN -100 //调整高度

#import "DrawingSmallPin.h"

#define MULTIPLEnum 0.17 //坐标长度
@interface DrawingSmallPin()
@property(nonatomic,strong)CoordinateInit *coordNumbers;  //坐标单位
@property(nonatomic)int i;
@end

@implementation DrawingSmallPin
-(void)drawRect:(CGRect)rect
{
    
}
-(void)DrawingSmallPin
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    //画圆
    CGContextSetRGBStrokeColor(context,0,0,0.5,0.5);//画笔线的颜色
    CGContextSetLineWidth(context, 2.0);//线的宽度
    
    if(!self.Arraysinit){
        self.Arraysinit=[[InitMakingArrays alloc] init];
    }
    //开始画出来
    
    self.i=self.runningSmallPin;
    self.coordntDatas=[self.Arraysinit.coordntArrays objectAtIndex:self.i];
    
    CGPoint aPoints[2];//坐标点
    aPoints[0] =CGPointMake(self.coordntDatas.x*MULTIPLEinS+self.screenWithFromControll/2, self.coordntDatas.y*MULTIPLEinS+310+self.screenHeightFromControll/2+ADJUSTSMALLPIN);//坐标1
    aPoints[1] =CGPointMake(self.coordntDatas.x*MULTIPLEoutS+self.screenWithFromControll/2, self.coordntDatas.y*MULTIPLEoutS+310+self.screenHeightFromControll/2+ADJUSTSMALLPIN);//坐标2
    CGContextAddLines(context, aPoints, 2);//添加线
    CGContextDrawPath(context, kCGPathStroke); //绘制路径
    
}


@end
