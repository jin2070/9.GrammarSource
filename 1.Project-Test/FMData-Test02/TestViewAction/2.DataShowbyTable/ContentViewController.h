//
//  ContentViewController.h
//  TestViewAction
//
//  Created by pc on 2018/10/2.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentViewController : UIViewController

@property(nonatomic)NSString *booksName;
@property(nonatomic)NSString *chapter;
@property (nonatomic, retain) IBOutlet UITextView *myTextView;
@property(nonatomic)BOOL hasVerse;
@property(nonatomic)CGFloat oldVelocity;


//@property (nonatomic, retain) IBOutlet UITableView *chapterTableView;
//@property (nonatomic, retain) NSMutableArray *menuList;

-(void)getInfoFromChapterViewController:(NSString *)title andVersesAmount:(NSString *)num;
@end
