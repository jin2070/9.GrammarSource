//
//  DrawMoon.m
//  MutiBox
//
//  Created by pc on 2018/5/27.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
#import "DrawingInterface.h"

//import delegate drawing
#import "DrawingCoordinate.h"
#import "DrawingSecond.h"
#import "DrawingMinute.h"
#import "DrawingCoordinateSub.h"
#import "DrawingSmallPin.h"

//#define MULTIPLE 1.5 //圆圈画出来时的半径参数

@implementation DrawingInterface

-(void)drawRect:(CGRect)rect
{
    [self drawClock];
}
-(void)drawClock
{
    //环境初始化
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context,1,0,1,1);//画笔线的颜色
    CGContextSetLineWidth(context, 3.0);//线的宽度
    
    //生成对象
    DrawingCoordinate *drawingCoordinate=[[DrawingCoordinate alloc] initWithFrame:CGRectMake(0, 0, 300, 500)];
    DrawingSecond *drawingSecond=[[DrawingSecond alloc] initWithFrame:CGRectMake(0, 0, 300, 500)];
    DrawingMinute *drawingMinute=[[DrawingMinute alloc] initWithFrame:CGRectMake(0, 0, 300, 500)];
    DrawingCoordinateSub *drawingCoordinateSub=[[DrawingCoordinateSub alloc] initWithFrame:CGRectMake(0, 0, 300, 500)];
    DrawingSmallPin *drawingSmallPin=[[DrawingSmallPin alloc] initWithFrame:CGRectMake(0, 0, 300, 500)];
    
    //以下都是Interface传递参数&委托实行
    drawingCoordinate.screenWithFromControll=self.screenWithFromControll;
    drawingCoordinate.screenHeightFromControll=self.screenHeightFromControll;
    drawingCoordinate.countround=self.countSecond;
    self.drawlineDelegat=drawingCoordinate;
    [self.drawlineDelegat DrawCoordinateClock];
    
    drawingSecond.screenWithFromControll=self.screenWithFromControll;
    drawingSecond.screenHeightFromControll=self.screenHeightFromControll;
    drawingSecond.countround=self.countSecond;
    self.drawlineDelegat=drawingSecond;
    [self.drawlineDelegat DrawingSecondHand];
    
    drawingMinute.screenWithFromControll=self.screenWithFromControll;
    drawingMinute.screenHeightFromControll=self.screenHeightFromControll;
    drawingMinute.runningMinute=self.countMinute;
    self.drawlineDelegat=drawingMinute;
    [self.drawlineDelegat DrawingMinuteHand];
    
    drawingSmallPin.screenWithFromControll=self.screenWithFromControll;
    drawingSmallPin.screenWithFromControll=self.screenWithFromControll;
    drawingSmallPin.runningSmallPin=self.countSmallpin;
   
    //drawingSmallPin.runningSmallPin=self.countSmallpin;
    self.drawlineDelegat=drawingSmallPin;
    [self.drawlineDelegat DrawingSmallPin];
    
    drawingCoordinateSub.screenWithFromControll=self.screenWithFromControll;
    drawingCoordinateSub.screenHeightFromControll=self.screenHeightFromControll;
    drawingCoordinateSub.countround=self.countSecond;
    self.drawlineDelegat=drawingCoordinateSub;
    [self.drawlineDelegat DrawCoordinateSub];
 
   
}
    

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
