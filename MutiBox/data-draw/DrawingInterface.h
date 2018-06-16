//
//  DrawMoon.h
//  MutiBox
//
//  Created by pc on 2018/5/27.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocal-Draw.h"

@interface DrawingInterface : UIView
@property(nonatomic)float screenWithFromControll; //主窗口屏幕大小接受FromController
@property(nonatomic)float screenHeightFromControll;
@property(nonatomic)int countSecond; //点击数量的接口
@property(nonatomic)int countMinute;//分钟跳动接口
@property(nonatomic)int countSmallpin;//
@property(nonatomic,strong)id<Protocal_Draw>drawlineDelegat; //委托
-(void)drawClock;
@end
