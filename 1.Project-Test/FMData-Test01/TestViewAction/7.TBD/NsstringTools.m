//
//  NsstringTools.m
//  TestViewAction
//
//  Created by pc on 2018/8/30.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "NsstringTools.h"

@implementation NsstringTools
-(void)ShowTime
{

    [self E_Test];
}
-(void)D_NstringMutable
{
    NSMutableString *str = [NSMutableString stringWithString:@"string"];
    
    //////////插入//////////
    [str insertString:@"123" atIndex:2];
    NSLog(@"%@", str);
    //输出:   st123ring
    
    
    //////////删除//////////
    [str deleteCharactersInRange:NSMakeRange(2, 2)];
    NSLog(@"%@", str);
    //输出:   st3ring
    
    
    //////////拼接//////////
    [str appendString:@"456"];
    NSLog(@"%@", str);
    //输出:   st3ring456
    
    
    //////////格式化拼接//////////
    [str appendFormat:@"7 89"];
    NSLog(@"%@", str);
    //输出:   st3ring4567 89
    
    
    //////////设置新字符串//////////
    [str setString:@"string"];
    NSLog(@"%@", str);
    //输出:   string
    
    //////////字符串替换//////////
    //1.指定范围替换
    [str replaceCharactersInRange:NSMakeRange(2, 2) withString:@"123"];
    NSLog(@"%@", str);
    //输出:   st123ng
    
    
    //2.指定字符串,条件,范围替换
    [str replaceOccurrencesOfString:@"123" withString:@"--" options:NSRegularExpressionSearch range:NSMakeRange(0, str.length)];
    NSLog(@"%@", str);
    //输出:   st--ng
    
    
}
-(void)A_test
{
    // 1. + (instancetype)string;
    NSString *str = [NSString string];
    str=@"hello";
    NSLog(@"1001 str----%p--%@",str,str);
    //str=@"hello";
    NSString *hellostring=[NSString string];
    NSLog(@"1002 hellostring----%p--%@",hellostring,hellostring);
    // 2. - (instancetype)init;
    //An initialized NSString object that contains no characters. The returned object may be different from the original receiver.
    NSString *strbbb = [[NSString alloc] init];
    NSLog(@"1003 strbbb----%p----%@",strbbb,strbbb);
    
    NSUInteger length = 4;
    const void *bytes = "aabbccdd";
    NSString *strcc = [[NSString alloc] initWithBytes:bytes length:length encoding:NSUTF8StringEncoding];
    NSLog(@"1004 strcc----%p----%@",strcc,strcc);
    
    // NSUInteger lengthdd = 4;
    NSString *a = @"Hello World!";
    NSString *strdd = [[NSString alloc] initWithString:a];
    NSLog(@"1005 strdd----%p----%@",strdd,strdd);
    
    const char *aee = "azzzzzzzzzzzzzzb";
    NSString *stree = [[NSString alloc] initWithCString:aee encoding:NSUTF8StringEncoding];
    NSLog(@"1006 stree----%p----%@",stree,stree);
}
-(void)B_Test
{
    //字符串常量创建，存储在常量区
    //常量区特点：内容不会重复.所以如果其它对象存储的内容一样(如下例子)，则指针指向相同的地址。
    //str存储的是abc的地址，指针指向abc(str是存储在栈区)
    NSString *str1 = @"abc";
    NSString *str11 = @"abc";
    NSLog(@"1001 str1:%@ P:%p  str11:%@ P:%p",str1,str1,str11,str11);
    
    //通过alloc init创建，存储在堆区，若其它对象存储的内容一样，不会指针指向同一个地址，会直接alloc init分配存储空间（str2对象则存储在栈区）。
    //注意：但是不同平台存储方式不一样，mac中的地址会相同，因为对字符串对象进行过优化，二iOS平台则地址不同。
    //     不同编译器存储方式也不一样，iOS6.0以前会通过alloc重新创建地址，而iOS6.0后alloc会指向同一个地址
    NSString *str2 = [[NSString alloc] initWithFormat:@"def"];
    NSString *str22 = [[NSString alloc] initWithFormat:@"def"];
    NSLog(@"1002 str2:%@ P:%p   str22%@ P:%p",str2,str2,str22,str22);
    
    
    
    //通过类工厂方法创建。存储在堆区,存储方式等同于alloc init（因为类工厂方法就在类中封装了alloc init）
    NSString *str3 = [NSString stringWithFormat:@"hig"];
    NSString *str33 = [NSString stringWithFormat:@"hig"];
    NSLog(@"1003 str3:%@ P:%p  str33%@ P:%p",str3,str3,str33,str33);
    
    
    /*通过alloc和类工厂方法都会在堆区分配内存，但是initWithString不会分配内存，因为：
     initWithString是通过copy返回一个字符串，二这个copy是浅拷贝，所以无论什么平台，都会指向同一块地址。
     */
    //下面会发生警告uising ”initWithString“ with a literal is redundant（用文字是多余的），相当于常量的创建方式。
    //         NSString *str5 = [[NSString alloc] initWithString:@"klm"];
    // NSLog(@"1005 str5:%@   str55%@",str5,str55);
}
-(void)C_Test  //NString
{
    //////////字符串属性//////////
    NSString *str1 = @"string";
    
    NSLog(@"长度:                   %ld", str1.length);
    NSLog(@"描述:                   %@", str1.description);
    NSLog(@"哈希地址:                %lu", (unsigned long)str1.hash);
    NSLog(@"字符串对应下标字符:        %c", [str1 characterAtIndex:2]);
    //输出:   长度:                   6
    //输出:   描述:                   string
    //输出:   哈希地址:                10152471993823965
    //输出:   字符串对应下标字符:        r
    
    //////////字符串拼接//////////
    NSString *string = @"1";
    NSString *appStr = @"2";
    NSString *resultStr1 = [string stringByAppendingString:appStr];
    NSString *resultStr2 = [string stringByAppendingFormat:@" + %@", appStr];
    
    NSLog(@"普通拼接:     %@", resultStr1);
    NSLog(@"格式化拼接:   %@", resultStr2);
    //输出:   普通拼接:     12
    //输出:   格式化拼接:   1 + 2
    
    //////////字符串基本类型转换//////////
    NSString *numStr = @"87234.2345";
    
    NSLog(@"double型:        %f", numStr.doubleValue);
    NSLog(@"float型:         %f", numStr.floatValue);
    NSLog(@"int型:           %d", numStr.intValue);
    NSLog(@"NSInteger型:     %ld", numStr.integerValue);
    NSLog(@"long long型:     %lld", numStr.longLongValue);
    NSLog(@"BOOL型:          %d", numStr.boolValue);
    //输出:   double型:        87234.234500
    //输出:   float型:         87234.234375
    //输出:   int型:           87234
    //输出:   NSInteger型:     87234
    //输出:   long long型:     87234
    //输出:   BOOL型:          1
    
    //////////字符串大小写转换//////////
    NSString *stringd = @"string";
    
    NSLog(@"大写:         %@", stringd.uppercaseString);
    NSLog(@"小写:         %@", stringd.lowercaseString);
    NSLog(@"首字母大写:    %@", stringd.capitalizedString);
    //输出:   大写:         STRING
    //输出:   小写:         string
    //输出:   首字母大写:    String
    
    NSString *stringa = @"123 456\nABC,DEF\nabc.def";
    //获取该行的范围(指定范围)
    NSRange range1 = [stringa lineRangeForRange:NSMakeRange(0, 10)];
    NSLog(@"%ld 行长度:     %ld", range1.location, range1.length);
    //输出:       0 行长度:     16
    
    //获取该段落范围(指定范围)
    NSRange range2 = [stringa paragraphRangeForRange:NSMakeRange(0, 3)];
    NSLog(@"%ld 段落长度:   %ld", range2.location, range2.length);
    //输出:       0 段落长度:   8
    
    NSString *stringb = @"123456\nABCDEF\nabcdef";
    //1.列举(按行)
    [stringb enumerateLinesUsingBlock:^(NSString * _Nonnull line, BOOL * _Nonnull stop) {
        NSLog(@"每行:   %@", line);
    }];
    //输出:    每行:   123456
    //输出:    每行:   ABCDEF
    //输出:    每行:   abcdef
    
    [stringb enumerateSubstringsInRange:NSMakeRange(5, 10) options:NSStringEnumerationByLines usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        
        NSLog(@"%@", substring);
        NSLog(@"%ld   %ld", substringRange.location, substringRange.length);
        NSLog(@"%ld   %ld", enclosingRange.location, enclosingRange.length);
        
    }];
    //输出:   6
    //输出:   5 1
    //输出:   5 2
    
    //输出:   ABCDEF
    //输出:   7   6
    //输出:   7   7
    
    //输出:   a
    //输出:   14   1
    //输出:   14   1
    
    //////////字符串编码和转换//////////
    NSString *stringc = @"string";
    
    NSLog(@"最快编码值(枚举):      %lu", (unsigned long)stringc.fastestEncoding);
    NSLog(@"最小编码值(枚举):      %lu", (unsigned long)stringc.smallestEncoding);
    NSLog(@"UTF8编码值:           %s", string.UTF8String);
    //输出:     最快编码值(枚举):      1
    //输出:     最小编码值(枚举):      1
    //输出:     UTF8编码值:           string
    

    //////////字符串分割//////////
    NSString *stringe= @"A_B_c_D_E_F";
    
    //分割(指定字符串)
    NSArray *resultArr1 = [stringe componentsSeparatedByString:@"_"];
    NSLog(@"%@", resultArr1);
    //输出:   (A, B, c, D, E, F)
    
    //分割(指定字符集合)
    NSArray *resultArr2 = [stringe componentsSeparatedByCharactersInSet:[NSCharacterSet lowercaseLetterCharacterSet]];
    NSLog(@"%@", resultArr2);
    //输出:   ("A_B_" , "_D_E_F")
    
    NSString *stringf = @"3EWRs a;af";
    
    //////////修剪//////////
    NSString *result1 = [stringf stringByTrimmingCharactersInSet:[NSCharacterSet lowercaseLetterCharacterSet]];
    NSLog(@"%@", result1);
    //输出:   3EWRs a;
    
    
    //////////填充//////////
    NSString *result2 = [stringf stringByPaddingToLength:20 withString:@"填充" startingAtIndex:1];
    NSLog(@"%@", result2);
    //输出:   3EWRs a;af充填充填充填充填充填
    
    
    //////////折叠//////////
    NSString *result3 = [stringf stringByFoldingWithOptions:NSNumericSearch locale:[NSLocale systemLocale]];
    NSLog(@"%@", result3);
    //输出:   3EWRs a;af
    
    
    //////////替换//////////
    //替换(指定字符串)
    NSString *result4 = [stringf stringByReplacingOccurrencesOfString:@" " withString:@"替换"];
    NSLog(@"%@", result4);
    //输出:   3EWRs替换a;af
    

    
    //替换(指定范围)
    NSString *result6 = [stringf stringByReplacingCharactersInRange:NSMakeRange(0, string.length) withString:@"替换"];
    NSLog(@"%@", result6);
    //输出:   替换
    
    //////////字符串翻译//////////
    NSString *dalian = @"大连";
    NSString *result = [dalian stringByApplyingTransform:NSStringTransformMandarinToLatin reverse:NO];
    
    NSLog(@"%@", result);
    //输出:   dà lián
    
    //////////字符串写入//////////
    //写入到指定路径,编码的文件中

}

-(void)E_Test
{
   // NSString *str1=[[NSString alloc]init];
    
    //1.创建
    
    //快速创建
    
    //NSString *str2=@"11";
    
    
    
    //alloc方法初始化，这种方法已经被快速创建方法取代,此处警告就是因为这种方法已经不用
    
   // NSString *str3=[[NSString alloc]initWithString:@"1"];
    
    //格式化符创建
    
    NSString *str4=[[NSString alloc]initWithFormat:@"1"];
    
    NSString *str5=[[NSString alloc]initWithFormat:@"1"];
    
    
    
    
    
    //2.比较两个字符串是否相等；相等是NSOrderedSame，升序NSOrderedAscending；此时比较两个字符串的大小是不分大小写
    
    NSComparisonResult result=[str4 caseInsensitiveCompare:str5];
    
    if (result==NSOrderedAscending) {
        
        NSLog(@"升序");
        
        
        
    }
    
    if (result==NSOrderedDescending) {
        
        NSLog(@"降序");
        
    }
    
    
    
    if (result==NSOrderedSame) {
        
        NSLog(@"相等");
        
    }
    
    
    
    //不区分大小写NSCaseInsensitiveSearch、NSNumericSearch
    
    
    
    NSString *s1=@"aaaa";
    
    NSString *s2=@"AAAA";
    
    NSComparisonResult result1=[s1 compare:s2 options:NSCaseInsensitiveSearch|NSNumericSearch];
    
    if (result1==NSOrderedAscending) {
        
        NSLog(@"---升序");
        
        
        
    }
    
    if (result1==NSOrderedDescending) {
        
        NSLog(@"---降序");
        
    }
    
    
    
    if (result1==NSOrderedSame) {
        
        NSLog(@"----相等");
        
    }
    
    
    
    //区分大小写NSLiteralSearch
    
    NSString *s3=@"aaaa";
    
    NSString *s4=@"AAAA";
    
    NSComparisonResult result2=[s3 compare:s4 options:NSLiteralSearch];
    
    if (result2==NSOrderedAscending) {
        
        NSLog(@"---升序");
        
        
        
    }
    
    if (result2==NSOrderedDescending) {
        
        NSLog(@"---降序");
        
    }
    
    
    
    if (result2==NSOrderedSame) {
        
        NSLog(@"----相等");
        
    }
    
    
    
    //在这里str4=str5比较的是两个字符串的地址,两个字符串的地址是不相等的
    
    
    
    if (str4 == str5) {
        
        NSLog(@"比较地址");
        
    }
    
    
    
    //3.字符串的访问
    
    //分割字符串componentsSeparatedByString
    
    NSString *str6=@"ssajjakkall";
    
    NSArray *arr1=[str6 componentsSeparatedByString:@"a"];
    
    NSLog(@"%@",arr1);
    
    //访问指定的字符串
    
    NSString *str7=@"abcdsdf";
    
    char s=[str7 characterAtIndex:1];
    
    NSLog(@"%c",s);
    
    
    
    
    
    //4.字符串的截取
    
    //截取到指定的字符串,此方法是把从0~2的字符删去
    
    NSString *str8=[str7 substringFromIndex:2];
    
    NSLog(@"%@",str8);
    
    //从指定位置接取
    
    NSString *str9=[str7 substringToIndex:2];
    
    NSLog(@"%@",str9);
    
    //范围截取
    
    //NSMakeRange(位置, 截取长度);
    
    
    
    NSRange r=NSMakeRange(0, 2);
    
    NSString *str10=[str7 substringWithRange:r];
    
    NSLog(@"%@",str10);
    
    
    
    //5.拼接字符串
    
    //stringWithFormate方法
    
    NSString *str11=@"ab";
    
    NSString *str12=@"cd";
    
    NSString *str13=[NSString stringWithFormat:@"%@%@",str11,str12];
    
    NSLog(@"%@",str13);
    
    //stringByAppendingString方法
    
    NSString *str14=[str11 stringByAppendingString:str12];
    
    NSLog(@"%@",str14);
    
    
    
    //stringByAppendingFormat方法
    
    NSString *str15=[str11 stringByAppendingFormat:@"%@",str12];
    
    NSLog(@"%@",str15);
    
    //6查找替换
    
    //查找
    
    NSString *email=@"11111111@qq.com";
    
    NSString *str16=@"@qq.com";
    
    NSRange range=[email rangeOfString:str16];
    
    NSLog(@"range.location=%lu,range.length=%lu",range.location,range.length);
    
    //替换
    
    NSString *str17=@"1234aaa";
    
    NSString *str18=[str17 stringByReplacingOccurrencesOfString:str17 withString:@"abcdd"];
    
    NSLog(@"%@",str18);
}
@end
