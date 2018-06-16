//
//  Protocal-Draw.h
//  MutiBox
//
//  Created by pc on 2018/6/8.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Protocal_Draw <NSObject>

@optional
//随时增加方法
-(void)DrawCoordinateClock;  //画表坐标
-(void)DrawingSecondHand;  //秒针
-(void)DrawingMinuteHand;  //分针
-(void)DrawCoordinateSub; //画小坐标
-(void)DrawingSmallPin;



//CGContextAddLines(context, aPoints, 2);
@end
