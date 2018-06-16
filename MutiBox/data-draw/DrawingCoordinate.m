//
//  DrawingCoordinate.m
//  MutiBox
//
//  Created by pc on 2018/6/9.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "DrawingCoordinate.h"
#define MULTIPLEsecond 1.4 //坐标长度
#define MULTIPLEfive 1.3 //坐标长度
#define MULTIPLEnumber 1.15 //坐标长度
#define ADJUSTCOORDINATE -100 //调整高度
@interface DrawingCoordinate()
@property(nonatomic,strong)CoordinateInit *coordNumbers;  //坐标单位
@end
@implementation DrawingCoordinate

-(void)DrawCoordinateClock
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    //画圆
    CGContextSetRGBStrokeColor(context,1,0,0,1);//画笔线的颜色
    CGContextSetLineWidth(context, 2.0);//线的宽度
   // UIFont *font = [UIFontfontWithName:@"HelveticaNeue-Bold",size:30.0f];
    UIFont *font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
    //UIColor *redColor = [UIColorredColor];
    //初始化&生产60个坐标
    if(!self.Arraysinit){
        self.Arraysinit=[[InitMakingArrays alloc] init];
    }
    //开始画出来
    int i;
    int j; //时针显示间隔参数
    j=0;
    NSString *timeNumberString; //时针数加载参数
    for(i=0;i<=59;i++) //根据点击的次数画圆的数量
    {
        self.coordntDatas=[self.Arraysinit.coordntArrays objectAtIndex:i];
        self.coordNumbers=[self.Arraysinit.coordntArrays objectAtIndex:i];
        CGPoint aPoints[2];//坐标点
       
        
        if(0==i%(5))
        {
            aPoints[0] =CGPointMake(self.coordntDatas.x*MULTIPLEfive+self.screenWithFromControll/2, self.coordntDatas.y*MULTIPLEfive+self.screenHeightFromControll/2+ADJUSTCOORDINATE);//坐标1
            aPoints[1] =CGPointMake(self.coordntDatas.x*MULTIPLE+self.screenWithFromControll/2, self.coordntDatas.y*MULTIPLE+self.screenHeightFromControll/2+ADJUSTCOORDINATE);//坐标2
            CGContextAddLines(context, aPoints, 2);//添加线
            CGContextDrawPath(context, kCGPathStroke); //绘制路径
            //数字显示
         
            if(j==12){j=0;} //调用时针数组的12个数
            timeNumberString=[[DrawingCoordinate timeNumbers] objectAtIndex:j]; //生成12个时针数
            [timeNumberString drawAtPoint:CGPointMake(self.coordntDatas.x*MULTIPLEnumber-10+self.screenWithFromControll/2, self.coordntDatas.y*MULTIPLEnumber+self.screenHeightFromControll/2-10+ADJUSTCOORDINATE) withAttributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:[UIColor greenColor]}];
              j++;//时针数显示间隔累计
        }else{
            aPoints[0] =CGPointMake(self.coordntDatas.x*MULTIPLEsecond+self.screenWithFromControll/2, self.coordntDatas.y*MULTIPLEsecond+self.screenHeightFromControll/2+ADJUSTCOORDINATE);//坐标1
            aPoints[1] =CGPointMake(self.coordntDatas.x*MULTIPLE+self.screenWithFromControll/2, self.coordntDatas.y*MULTIPLE+self.screenHeightFromControll/2+ADJUSTCOORDINATE);//坐标2
            CGContextAddLines(context, aPoints, 2);//添加线
            CGContextDrawPath(context, kCGPathStroke); //绘制路径
          //   NSLog(@"what is this %f",self.coordntDatas.x);
            
        }
    }
 
}

+(NSArray *)timeNumbers  //显示表钟时数
{
    return @[@"60",@"5",@"10",@"15",@"20",@"25",@"30",@"35",@"40",@"45",@"50",@"55"];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/*NO.2写文字
 
 CGContextSetLineWidth(context, 1.0);
 CGContextSetRGBFillColor (context, 0.5, 0.5, 0.5, 0.5);
 UIFont  *font = [UIFont boldSystemFontOfSize:18.0];
 [@"公司：北京中软科技股份有限公司\n部门：ERP事业部\n姓名：McLiang" drawInRect:CGRectMake(20, 40, 280, 300) withFont:font];
 */




@end
