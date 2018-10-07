//
//  Operator.h
//  TestViewAction
//
//  Created by pc on 2018/9/14.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SqlServiceClass.h"
@interface Operator : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textName;
@property (weak, nonatomic) IBOutlet UITextField *idValue;
@property (weak, nonatomic) IBOutlet UITextField *textPhone;
@property (nonatomic,weak) sqlTestList *sqlValue;
@property (nonatomic) int oprateType;
@end
