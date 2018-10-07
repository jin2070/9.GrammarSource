//
//  ContentViewController.m
//  TestViewAction
//
//  Created by pc on 2018/10/2.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "ContentViewController.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"

@interface ContentViewController ()

@end

@implementation ContentViewController
-(void)getInfoFromChapterViewController:(NSString *)title andVersesAmount:(NSString *)num
{
    
    // Custom initialization
    self.booksName = title;
    self.chapter = num;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ( [(NSString *)[prefs valueForKey:@"hasVerseNumber"] isEqualToString:@"false"] )
        self.hasVerse = false;
    else
        self.hasVerse = true;
    
    self.oldVelocity = -1000;
   
}
- (void)viewDidLoad {
    
    NSString *dbpath = [[NSBundle mainBundle] pathForResource:@"cunp.sqlite3" ofType:nil];
    
    //  NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
    
    // Do any additional setup after loading the view from its nib.
    if ([self.booksName isEqualToString:@"詩篇"] || [self.booksName isEqualToString:@"诗篇"])
        self.title = [NSString stringWithFormat:@"第 %@ 篇", self.chapter];
    else
        self.title = [NSString stringWithFormat:@"第 %@ 章", self.chapter];
    
    FMDatabase *dataBaseSql = [FMDatabase databaseWithPath:dbpath];
    if (![dataBaseSql open]) {
        NSLog(@"Open Database failed");
        return;
    }
    NSString *resultHuman;
    //   if ([language isEqualToString:@"zh-Hans"])
    //       rs = [db stringForQuery:@"select osis from books_simpl where human = ?", booksName];
    //  else
    resultHuman = [dataBaseSql stringForQuery:@"select osis from books where human = ?", self.booksName];
    NSString *search_text = [[NSString alloc] initWithFormat:@"select * from verses where book='%@' and verse like '%@.%%'", resultHuman, self.chapter];
    FMResultSet *resultText = [dataBaseSql executeQuery:search_text];
    
    NSMutableString *content = [[NSMutableString alloc] initWithString:@""];
    NSString *trimText;
    NSInteger versesNum = -1;
    while ([resultText next]) {
        
        trimText=[resultText stringForColumn:@"unformatted"];
      //  NSInteger ilocation=[trimText rangeOfString:@"+"].location;
      //  NSLog(@"ilocation %tu",ilocation);
        //在resultText搜索stringByReplacingOccurrencesOfString 用“”替换“+”字节
        trimText = [[resultText stringForColumn:@"unformatted"] stringByReplacingOccurrencesOfString:@" +" withString:@""
                                                                                      options:NSRegularExpressionSearch
                                                                                        range:NSMakeRange(0, [resultText stringForColumn:@"unformatted"].length)];
        //NSLog(@"versesNum: %tu",versesNum?@"Yes":@"NO);
     //   NSLog(@"versesNum: %tu",versesNum);
        //3个节一个组插入“\n\n”,显示调节空间，方便阅读
        //在trimText里angeOfString搜索@"\n"字节，搜索后返回.location位置nsuintger和.length 字节的长度nsuinter
        if ([trimText rangeOfString:@"\n"].location == 0  && versesNum != -1) {
            [content appendString:@"\n\n"];
       //     NSLog(@"content: %@",content);
        }
     //   NSLog(@"content: %@",content);
        trimText = [trimText stringByReplacingOccurrencesOfString:@"\n+" withString:@""
                                                          options:NSRegularExpressionSearch
                                                            range:NSMakeRange(0, trimText.length)];
     //   if ([language isEqualToString:@"zh-Hans"])
            trimText = [trimText stringByReplacingOccurrencesOfString:@"裏" withString:@"裡"
                                                              options:NSRegularExpressionSearch
                                                                range:NSMakeRange(0, trimText.length)];
        //self.hasverse确认是否有章节
        if (self.hasVerse) {
            //componentsSeparatoedByString在"verse"行里用“.”分开， 章和节数量
            NSArray *num = [[resultText stringForColumn:@"verse"] componentsSeparatedByString:@"."];
            NSLog(@"what is that num:%@, length:%tu",num,[[num objectAtIndex:1] length]);
           //在小数点0.010或0.020后面不能显示0的数字，用*10来显示节的数量
            if ([[num objectAtIndex:1] length] == 2) {
                versesNum = [[num objectAtIndex:1] intValue];
                versesNum = versesNum * 10;
            }
            else
                //在"verses"后数字里取出第几节
                versesNum = [[num objectAtIndex:1] intValue];
            //前一节结束的时候，加上下一节的第几节数。
            [content appendString:[NSString stringWithFormat:@"%ld ", (long)versesNum]];
        }
        NSLog(@"content: %@",content);
        [content appendString:trimText];
        versesNum = 1;
    }
    
   // if ([language isEqualToString:@"zh-Hans"]) {
        //    UInt32 big5 = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        //  NSString *big5EncStr = [content stringByReplacingPercentEscapesUsingEncoding:big5];
      //  NSString *big5EncStr=[ content stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        //     Big5ToGB *big5togb = [[Big5ToGB alloc] init];
        //     NSString *gbEncStr = [big5togb big5ToGB:big5EncStr];
        //    [myTextView setText:gbEncStr];
        //       [big5togb release];
    //}
   // else
    self.myTextView=[[UITextView alloc]initWithFrame:CGRectMake(2, 65, self.view.frame.size.width, self.view.frame.size.height)];
        [self.myTextView setText:content];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    UIFont *font = self.myTextView.font;
    CGFloat pointSize = [prefs floatForKey:@"myFontSize"];
    NSString *fontName = font.fontName;
    if (pointSize != 0)
        self.myTextView.font = [UIFont fontWithName:fontName size:pointSize];
    else
        self.myTextView.font=[UIFont fontWithName:@"Goergia" size:28];
    self.myTextView.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:self.myTextView];
    [dataBaseSql close];
     [self initGestureAlloc];
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}
-(void)initGestureAlloc
{
    UISwipeGestureRecognizer  *recognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftSwipeFrom:)];
    [recognizerLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [[self view] addGestureRecognizer:recognizerLeft];
  
    UISwipeGestureRecognizer  *recognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightSwipeFrom:)];
    [recognizerRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [[self view] addGestureRecognizer:recognizerRight];
   // [recognizerRight release];
}

#pragma mark -
#pragma mark HandleAction
-(void)handleLeftSwipeFrom:(UISwipeGestureRecognizer *)recogizer
{
    NSDictionary* dict = nil;
    dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:UISwipeGestureRecognizerDirectionLeft] forKey:@"direction"];
    
    if (dict)
        [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"%@%@", @"swipeNotify", self.booksName] object:self userInfo:dict];
}
-(void)handleRightSwipeFrom:(UISwipeGestureRecognizer *)recognizer
{
    //NSLog(@"handleRightSwipeFrom received: %d", recognizer.direction);
    
    NSDictionary* dict = nil;
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight)
        dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:UISwipeGestureRecognizerDirectionRight] forKey:@"direction"];
    
    if (dict)
        [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"%@%@", @"swipeNotify", self.booksName] object:self userInfo:dict];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
