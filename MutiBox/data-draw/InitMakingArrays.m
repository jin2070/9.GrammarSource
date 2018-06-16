//
//  MoonArryStack.m
//  MutiBox
//
//  Created by pc on 2018/5/26.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "InitMakingArrays.h"
#import "CoordinateInit.h"

@implementation InitMakingArrays
-(instancetype)init  //生成数组60个坐标初始化
{
    self=[super init];
    int i=0;
    if(self){
        //开始生成60个坐标，储存到Array
        for(NSString *circlex in[CoordinateInit cirPointX]){
          //  NSLog(@"take cirPointY %@",[[CoordinateInit cirPointY] objectAtIndex:i]);
            CoordinateInit *coordntdata=[[CoordinateInit alloc] init];
            coordntdata.x=[circlex intValue];
            coordntdata.y=[[[CoordinateInit cirPointY] objectAtIndex:i] intValue];
            [self addCoordtData:coordntdata];
            i++;
        //    moondata.y=[circlex]
        }
      
    }
    
    return self;
}

@end
