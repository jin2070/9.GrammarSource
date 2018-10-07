//
//  ScrollviewFunction.m
//  HVScrollView
//
//  Created by pc on 2018/7/21.
//  Copyright © 2018年 iDress. All rights reserved.
//

#import "ScrollviewFunction.h"

@implementation ScrollviewFunction
//重新定义，拖动的函数，可以避开scrollview的屏蔽
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesEnded:touches withEvent:event];
    [super touchesEnded:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesMoved:touches withEvent:event];
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    // 获取目前的点和，上一个点位置
    CGPoint currentPoint = [touch locationInView:self];
    CGPoint prePoint = [touch previousLocationInView:self];
    CGFloat offsetX = currentPoint.x - prePoint.x;
    CGFloat offsetY = currentPoint.y - prePoint.y;
    self.FscrollMovepoint=CGPointMake(offsetX, offsetY);
    
    //CGPoint preP=[touch pr]
    //NSLog(@"move.y: %f",self.FscrollMovepoint.y);
    
    //通知启动
    // 1.添加字典, 将数据包到字典中
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"name",@"xiaoming",@"111401",@"number", nil];
    
    // 2.创建通知
    //通知的名字是key,必须通知与接听一致，userInfo可以设置为nil;
    NSNotification *notification =[NSNotification notificationWithName:@"NotiAnyname" object:nil userInfo:dict];
    //    NSNotification *nohell=[NSNotification notificationWithName:@"hell" object:<#(nullable id)#>]
    // 3.通过 通知中心 发送 通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
}

@end
