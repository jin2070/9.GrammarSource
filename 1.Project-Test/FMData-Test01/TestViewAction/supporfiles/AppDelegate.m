//
//  AppDelegate.m
//  TestViewAction
//
//  Created by pc on 2018/7/19.
//  Copyright © 2018年 Jinchuncheng. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

-(void)applicationDidFinishLaunching:(UIApplication *)application{
    NSLog(@"hello");
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ( [prefs valueForKey:@"hasVerseNumber"] == nil ) {
        [prefs setValue:@"true" forKey:@"hasVerseNumber"];
        [prefs synchronize];
    }
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
 //   NSLog(@"print01");
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
// NSLog(@"print02");
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  //   NSLog(@"print03");
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
   //  NSLog(@"print04");
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
   //  NSLog(@"print05");
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
   //  NSLog(@"print06");
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
