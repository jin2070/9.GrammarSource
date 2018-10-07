//
//  NSbundleTest.m
//  TestViewAction
//
//  Created by pc on 2018/9/22.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "NSbundleTest.h"

@implementation NSbundleTest
-(void)drawRect:(CGRect)rect
{
    //获取bundle的位置
    NSString * bundlePath = [[ NSBundle mainBundle] pathForResource: @ "CreateBundlefile" ofType :@ "bundle"];
    //获取bundle里的文件两种方法
    NSString *imgPath= [bundlePath stringByAppendingPathComponent :@"008.png"];
    UIImage *image_1=[UIImage imageWithContentsOfFile:imgPath];
    UIImage *image = [UIImage imageNamed:@"CreateBundlefile.bundle/222.jpg"];
    
    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(50, 20, 200, 150)];
    UIImageView *imgView_1=[[UIImageView alloc] initWithFrame:CGRectMake(50, 200, 200, 150)];
    //显示图片
    [imgView setImage:image];
    [imgView_1 setImage:image_1];
    [self addSubview:imgView];
    [self addSubview:imgView_1];
    
    
}


@end
