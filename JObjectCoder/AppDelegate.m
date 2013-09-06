//
//  AppDelegate.m
//  JObjectCoder
//
//  Created by Joe on 13-9-5.
//  Copyright (c) 2013年 Joe. All rights reserved.
//

#import "AppDelegate.h"
#import "PathHelper.h"
#import "Test.h"
#import "JDecoder.h"
#import "JEncoder.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSString *path = [[PathHelper documentDirectoryPath] stringByAppendingPathComponent:@"1.txt"];
    Test *t = [[Test alloc]init];
    [JEncoder encodeObject:t toFile:path error:nil];
    Test *t2 = (Test *)[JDecoder decodeWithContentsOfFile:path error:nil];

    NSLog(@"%@",t2);
    NSLog(@"%@",t2.userInfo);
    NSLog(@"%d",[[t2.userInfo valueForKey:@"qqq"] propertyID]);
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
