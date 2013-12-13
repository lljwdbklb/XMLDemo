//
//  LJJAppDelegate.m
//  XMLDemo
//
//  Created by Jun on 13-12-11.
//  Copyright (c) 2013年 Jun. All rights reserved.
//

#import "LJJAppDelegate.h"

#import "LJJViewController.h"

@implementation LJJAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[LJJViewController alloc]init];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
