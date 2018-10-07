//
//  MyHeaderView.m
//  HVScrollView
//
//  Created by Libo on 17/6/14.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "MyHeaderView.h"

@interface MyHeaderView()
@end

@implementation MyHeaderView

-(void)drawRect:(CGRect)rect
{
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW,self.imageHeight )];
    [imageView setImage:[UIImage imageNamed:@"222.jpg"]];
    [self addSubview:imageView];
 
}

@end
