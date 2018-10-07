//
//  CreateFilePath.h
//  TestViewAction
//
//  Created by pc on 2018/9/11.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreateFilePath : NSObject
+ (NSString *)getDocumentPath;
+ (NSString *)getApplicationPath;
+ (BOOL)fileIsExistOfPath:(NSString *)filePath;
-(void)PrintNSlog;
//-(void)CreatefileTwo;
@end
