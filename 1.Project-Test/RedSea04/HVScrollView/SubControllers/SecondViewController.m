//
//  SecondViewController.m
//  HVScrollView
//
//  Created by Libo on 17/6/12.
//  Copyright © 2017年 iDress. All rights reserved.
//

// ----------- 悬浮菜单SPPageMenu的框架github地址:https://github.com/SPStore/SPPageMenu ---------
// ----------- 本demo地址:https://github.com/SPStore/HVScrollView ----------

#import "SecondViewController.h"
#import "ThirdViewController.h"
#define kViewControllerKey        @"viewController"
#define kTitleKey                @"title"
#define kDetailKey                @"detail text"

@interface SecondViewController ()

@end

@implementation SecondViewController
-(void)getInfoFromMainViewController:(NSString *)title andVersesAmount:(NSInteger)num
{
    self.title = self.booksName = title;
    self.versesAmount = num;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(swipeNotify:) name:[NSString stringWithFormat:@"%@%@", @"swipeNotify", self.booksName] object:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    //进入下一个viewcontroller后，可以推动返回
    [self.chapterTableView deselectRowAtIndexPath:self.chapterTableView.indexPathForSelectedRow animated:NO];
    //   [self.myTableView deselectRowAtIndexPath:self.myTableView.indexPathForSelectedRow animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self BuildTableDataWithSql];
    // Do any additional setup after loading the view.
}
-(void)BuildTableDataWithSql
{
    self.title = self.booksName;
    self.menuList = [NSMutableArray array];
    
    if ([self.booksName isEqualToString:@"詩篇"] || [self.booksName isEqualToString:@"诗篇"])
        for (int i=1; i<=self.versesAmount; i++) {
            [self.menuList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [NSString stringWithFormat: @"第 %d 篇",i], kTitleKey,
                                      [NSString stringWithFormat: @"%d",i], kDetailKey,
                                      nil]];
            
        }
    else
        for (int i=1; i<=self.versesAmount; i++) {
            [self.menuList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [NSString stringWithFormat: @"第 %d 章",i], kTitleKey,
                                      [NSString stringWithFormat: @"%d",i], kDetailKey,
                                      nil]];
            
        }
    [self initTableView];
    self.chapterTableView.delegate=self;
    self.chapterTableView.dataSource=self;
    [self.chapterTableView reloadData];
    
}
-(void)initTableView{
    if(!self.chapterTableView)
    {
    self.chapterTableView=[[UITableView alloc]initWithFrame:CGRectMake(2, 65, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.chapterTableView];
    }
}
#pragma mark -
#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.menuList count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *kCellIdentifier = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellIdentifier];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.opaque = NO;
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
        
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.opaque = NO;
        cell.detailTextLabel.textColor = [UIColor grayColor];
        cell.detailTextLabel.highlightedTextColor = [UIColor whiteColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    }
    
    // get the view controller's info dictionary based on the indexPath's row
    NSDictionary *dataDictionary = [self.menuList objectAtIndex:indexPath.row];
    cell.textLabel.text = [dataDictionary valueForKey:kTitleKey];
    cell.detailTextLabel.text = @"";
    
    return cell;
}
#pragma mark -
#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentIndex = indexPath.row;
    
    NSMutableDictionary *rowData = [self.menuList objectAtIndex:indexPath.row];
    ThirdViewController *targetViewController = [rowData objectForKey:kViewControllerKey];
    if (!targetViewController) {
        targetViewController = [[ThirdViewController alloc] init];
        [targetViewController getInfoFromChapterViewController:self.booksName andVersesAmount:[rowData objectForKey:kDetailKey]];
        [rowData setValue:targetViewController forKey:kViewControllerKey];
    }
    //生成通知打包新ThirdView,传送到ViewController
    NSDictionary* dict = nil;
    dict = [NSDictionary dictionaryWithObject:targetViewController forKey:@"thirdViewKey"];
    if (dict)
        [[NSNotificationCenter defaultCenter] postNotificationName:@"newThirdView" object:self userInfo:dict];
    
   // [self.navigationController pushViewController:targetViewController animated:YES];
}

#pragma mark - KVO
- (void)swipeNotify:(NSNotification *)notification
{
    //NSLog(@"swipeNotify: %@", notification.userInfo);
    //NSLog(@"swipeNotify: %@", [notification.userInfo objectForKey:@"direction"]);
    NSNumber *direction = [notification.userInfo objectForKey:@"direction"];
    if ([direction integerValue] == UISwipeGestureRecognizerDirectionRight) {
        if(--self.currentIndex <0) {
            self.currentIndex = 0;
            NSLog(@"currentIndex limited: %ld", (long)self.currentIndex);
            return;
        }
    }
    else if ([direction integerValue] == UISwipeGestureRecognizerDirectionLeft) {
        if(++self.currentIndex >= self.versesAmount) {
            self.currentIndex = self.versesAmount-1;
            NSLog(@"currentIndex limited: %ld", (long)self.currentIndex);
            return;
        }
    }
    
    //从menuList指定位置，导出到新的dictionary
    NSMutableDictionary *rowData = [self.menuList objectAtIndex:self.currentIndex];
    //新的dictionary里，用key赋值新的targetviewcontroller.
    ThirdViewController *targetViewController = [rowData objectForKey:kViewControllerKey];
    if (!targetViewController)
    {
        //初始化，及传参数出去
        targetViewController = [[ThirdViewController  alloc] init];
        [targetViewController getInfoFromChapterViewController:self.booksName andVersesAmount:[rowData objectForKey:kDetailKey]];
        //:self.booksName andChapter:[rowData objectForKey:kDetailKey]];
        //在新的dictionary里，用新的key,保存targeviewcontroller
        [rowData setValue:targetViewController forKey:kViewControllerKey];
        //  [targetViewController release];
    }
    /*
     [self.navigationController pushViewController:targetViewController animated:YES];
     */
    //用vcs保存所有viewcontroller后，再把最有一个viewcontroller替换成更新的targetViewcontroller
    NSMutableArray *vcs =  [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    if ([direction integerValue] == UISwipeGestureRecognizerDirectionRight) {
        [vcs insertObject:targetViewController atIndex:[vcs count]-1];
        [self.navigationController setViewControllers:vcs animated:NO];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if ([direction integerValue] == UISwipeGestureRecognizerDirectionLeft) {
        [vcs replaceObjectAtIndex:[vcs count]-1 withObject:targetViewController];
        [self.navigationController setViewControllers:vcs animated:YES];
    }
    
}


@end
