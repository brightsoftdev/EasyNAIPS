//
//  EasyNAIPSAppDelegate.m
//  EasyNAIPS
//
//  Created by Iain Blair on 28/08/12.
//  Copyright (c) 2012 Iain Blair. All rights reserved.
//

#import "EasyNAIPSAppDelegate.h"

#import "LocationBriefingTableViewController.h"
#import "NAIPSObjectStore.h"
#import "PullRefreshTableViewController.h"
#import "SettingsViewController.h"

@implementation EasyNAIPSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // Override point for customization after application launch.
    
    LocationBriefingTableViewController *vc = [[LocationBriefingTableViewController alloc] init];
    
    PullRefreshTableViewController *removeMe = [[PullRefreshTableViewController alloc] init];
    
    SettingsViewController *settings = [[SettingsViewController alloc] init];
    
    UINavigationController *locationNavController = [[UINavigationController alloc] initWithRootViewController:vc];
    
     UINavigationController *areaNavController = [[UINavigationController alloc] initWithRootViewController:removeMe];
    
       UINavigationController *settingsController = [[UINavigationController alloc] initWithRootViewController:settings];
    
    NSArray *controllers = [NSArray arrayWithObjects:locationNavController,areaNavController,settingsController,nil];
    
    
    UITabBarController *tabController = [[UITabBarController alloc] init];
      
    [tabController setViewControllers:controllers];
    
    [[self window] setRootViewController:tabController];
    
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
    
    
    BOOL success = [[NAIPSObjectStore sharedStore] saveChanges];
    
    if (!success)
    {
        NSLog(@"Could not save store");
    }
    
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
