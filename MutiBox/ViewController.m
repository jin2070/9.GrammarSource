//
//  ViewController.m
//  MutiBox
//
//  Created by pc on 2018/5/13.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "ViewController.h"

#import "DrawingInterface.h"
#import "CoordinateInit.h"
#import "InitMakingArrays.h"

#define MULTIPLE 1.5 //圆圈画出来时的半径参数

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *clickDrawMoon;  //点击画图转换按键
@property (weak, nonatomic) IBOutlet UIButton *clickStopruning;
@property(nonatomic,strong)DrawingInterface *drawingInterface; //导入画圆类
@property CGFloat witdhScreen; //屏幕宽度
@property CGFloat heightScreen; //屏幕高度
@property(nonatomic) int roundSecond;//转圈，数组顺序变更
@property(nonatomic)int roundMinute;
@property(nonatomic)int roundSmallPin;
@property(nonatomic,weak)NSTimer *timer;//计时器
@property(nonatomic)BOOL startOrPuse;//start yes puse no


@end

@implementation ViewController


//属性初始化

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.startOrPuse=NO;
    self.witdhScreen=self.view.bounds.size.width;  //屏幕尺寸
    self.heightScreen=self.view.bounds.size.height;//屏幕尺寸
    self.roundSecond=0;  //点击数初始化
    [self.clickDrawMoon setBackgroundColor:[UIColor yellowColor]]; //开始按键颜色
    self.drawingInterface=[[DrawingInterface alloc] initWithFrame:CGRectMake(0,0,self.witdhScreen,self.heightScreen)];//导入画图类
    [self appealClock];
    
}
-(void)startTimerruning
{
    if(self.roundSecond==59){self.roundSecond=0;};  //按键时圆圈位置移动，点击数累计
    self.roundSecond++;
    if(self.roundSecond==59){self.roundMinute++;};  //设定60圈循环
    if(self.roundMinute==59){self.roundMinute=0;};
    if(self.roundSecond%(3)==2){self.roundSmallPin++;};
    if(self.roundSmallPin==59){self.roundSmallPin=0;};
    [self appealClock];  //显示子图
    [self needDisplayDrawingInterface];  //更新子图
}
- (IBAction)clickDrawMoonFunction:(id)sender {
  
    if(!_timer || self.startOrPuse==NO)//时针开始运动
    {
        //触发定时
        self.timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(startTimerruning) userInfo:nil repeats:YES];
        [self.clickDrawMoon setTitle:@"PAUSE" forState:UIControlStateNormal];
        self.startOrPuse=YES;
    }else //时针暂停
    {
        [self.clickDrawMoon setTitle:@"START" forState:UIControlStateNormal];
        [self.timer invalidate];
        self.startOrPuse=NO;
    }
    
}

- (IBAction)clickStopTimerrunning:(id)sender {   //时针清零
    [self.timer invalidate];  //时针暂停
    self.roundSecond=0;    //设置秒针跳动
    self.roundMinute=0; //设置分针跳动
    self.roundSmallPin=0;   //设置小小针跳动
    self.startOrPuse=YES;
    [self.clickDrawMoon setTitle:@"START" forState:UIControlStateNormal];
    [self appealClock];
    [self needDisplayDrawingInterface];
}


//调用Drawmoon类，显示图案

-(void)appealClock{
 
    self.drawingInterface.countSecond=self.roundSecond;
    self.drawingInterface.countMinute=self.roundMinute;
    self.drawingInterface.countSmallpin=self.roundSmallPin;
    self.drawingInterface.screenWithFromControll=self.witdhScreen;  //屏幕大小横向
    self.drawingInterface.screenHeightFromControll=self.heightScreen;//屏幕大小高度
    self.drawingInterface.center=self.view.center;
    self.drawingInterface.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:self.drawingInterface];
    [self.view addSubview:self.clickDrawMoon];
    [self.view addSubview:self.clickStopruning];
  
}
-(void)needDisplayDrawingInterface
{
    [self.drawingInterface setNeedsDisplay]; //更新子view数据
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)didChangeValueForKey:(NSString *)key
{
}
@end




