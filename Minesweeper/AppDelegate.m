//
//  AppDelegate.m
//  Minesweeper
//
//  Created by Zakk Hoyt on 10/29/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [self setup   Appearance];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)setupAppearance{
    
    
    // UIView (this is what controls the color of the back button arrow)
    [[UIView appearance] setTintColor:[UIColor greenColor]];
    
    // Navigation bar
    NSDictionary *navBarAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:navBarAttributes];
    [[UINavigationBar appearance] setBarTintColor:[UIColor greenColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    // The nav bar back button
    [[UIBarButtonItem appearance] setTitleTextAttributes:navBarAttributes forState:UIControlStateNormal];
    
    // Tabbar
    [[UITabBar appearance] setBarTintColor:[UIColor blackColor]];
    [[UITabBar appearance] setTintColor:[UIColor greenColor]];
    
    // TabbarItem
    NSDictionary *tabBarAttributes = @{NSForegroundColorAttributeName : [UIColor greenColor]};
    [[UITabBarItem appearance] setTitleTextAttributes:tabBarAttributes forState:UIControlStateNormal];
    
    // Segmented control
    NSDictionary *segmentAttributes = @{NSForegroundColorAttributeName : [UIColor greenColor],
                                        NSStrokeColorAttributeName : [UIColor blackColor]};
    [[UISegmentedControl appearance] setTitleTextAttributes:segmentAttributes forState:UIControlStateNormal];
    
    // Toolbar
    [[UIToolbar appearance] setBarTintColor:[UIColor blackColor]];
    [[UIToolbar appearance] setTintColor:[UIColor greenColor]];
    
    // Text controls
    [[UITextView appearance] setTextColor:[UIColor whiteColor]];
    [[UITextField appearance] setTextColor:[UIColor whiteColor]];
    
    [[UITableView appearance] setBackgroundColor:[UIColor blackColor]];
    [[UITableViewCell appearance] setBackgroundColor:[UIColor blackColor]];
    
    [[UICollectionView appearance] setBackgroundColor:[UIColor blackColor]];
    [[UICollectionViewCell appearance]setBackgroundColor:[UIColor blackColor]];
    
    [[UIButton appearance]setTintColor:[UIColor greenColor]];
    [[[UIButton appearance]titleLabel] setFont:[UIFont fontWithName:@"Chalkduster" size:17]];
    
    [[UILabel appearance]setTextColor:[UIColor cyanColor]];
    [[UILabel appearance]setFont:[UIFont fontWithName:@"Chalkduster" size:17]];
}

@end
