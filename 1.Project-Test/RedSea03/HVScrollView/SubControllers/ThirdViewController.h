//
//  ThirdViewController.h
//  HVScrollView
//
//  Created by Libo on 17/6/12.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "BaseViewController.h"

@interface ThirdViewController : BaseViewController
@property(nonatomic)NSString *booksName;
@property(nonatomic)NSString *chapter;
@property (nonatomic, retain) IBOutlet UITextView *myTextView;
@property(nonatomic)BOOL hasVerse;
@property(nonatomic)CGFloat oldVelocity;


//@property (nonatomic, retain) IBOutlet UITableView *chapterTableView;
//@property (nonatomic, retain) NSMutableArray *menuList;

-(void)getInfoFromChapterViewController:(NSString *)title andVersesAmount:(NSString *)num;
@end
