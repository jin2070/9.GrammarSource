//
//  DrawingCoordinateSub.m
//  MutiBox
//
//  Created by pc on 2018/6/9.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "DrawingCoordinateSub.h"

#define MULTIPLEout 0.33 //坐标长度
#define MULTIPLEin 0.25 //坐标长度
#define MULTIPLEnum 0.17 //坐标长度
#define ADJUSTCOORDINATESUB -100 //调整高度
@interface DrawingCoordinateSub()
@property(nonatomic,strong)CoordinateInit *coordNumbers;  //坐标单位
@end

@implementation DrawingCoordinateSub
-(void)DrawCoordinateSub
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    //画圆
    CGContextSetRGBStrokeColor(context,1,0,0,1);//画笔线的颜色
    CGContextSetLineWidth(context, 1.0);//线的宽度
    // UIFont *font = [UIFontfontWithName:@"HelveticaNeue-Bold",size:30.0f];
    UIFont *font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:9];
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
        if(i%(3)==1){
            self.coordntDatas=[self.Arraysinit.coordntArrays objectAtIndex:i];
            self.coordNumbers=[self.Arraysinit.coordntArrays objectAtIndex:i];
            CGPoint aPoints[2];//坐标点
            
            aPoints[0] =CGPointMake(self.coordntDatas.x*MULTIPLEin+self.screenWithFromControll/2, self.coordntDatas.y*MULTIPLEin+self.screenHeightFromControll/2-60+ADJUSTCOORDINATESUB);//坐标1
            aPoints[1] =CGPointMake(self.coordntDatas.x*MULTIPLEout+self.screenWithFromControll/2, self.coordntDatas.y*MULTIPLEout+self.screenHeightFromControll/2-60+ADJUSTCOORDINATESUB);//坐标2
            CGContextAddLines(context, aPoints, 2);//添加线
            CGContextDrawPath(context, kCGPathStroke); //绘制路径
             //数字显示
        /*
            j=i/5;
            timeNumberString=[[DrawingCoordinateSub timeNumbers] objectAtIndex:j]; //生成12个时针数
            [timeNumberString drawAtPoint:CGPointMake(self.coordntDatas.x*MULTIPLEnum-3+self.screenWithFromControll/2, self.coordntDatas.y*MULTIPLEnum+self.screenHeightFromControll/2-65) withAttributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:[UIColor greenColor]}];
         */
            }
    }
    
    for(i=0;i<=59;i++) //根据点击的次数画圆的数量
    {
        if(i%(10)==1){
            self.coordntDatas=[self.Arraysinit.coordntArrays objectAtIndex:i];
            self.coordNumbers=[self.Arraysinit.coordntArrays objectAtIndex:i];
           // j=i/5;
            timeNumberString=[[DrawingCoordinateSub timeNumbers] objectAtIndex:j]; //生成12个时针数
            [timeNumberString drawAtPoint:CGPointMake(self.coordntDatas.x*MULTIPLEnum-3+self.screenWithFromControll/2, self.coordntDatas.y*MULTIPLEnum+self.screenHeightFromControll/2-65+ADJUSTCOORDINATESUB) withAttributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:[UIColor greenColor]}];
            j++;
        }
    }
   
 
}
+(NSArray *)timeNumbers  //显示表钟时数
{
    return @[@"60",@"5",@"10",@"15",@"20",@"25",@"30"];
}
    /*
+(NSArray *)timeMinNumbers  //显示表钟时数
{
    return @[@"30",@"5",@"10",@"15",@"20",@"25"];
}*/
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
