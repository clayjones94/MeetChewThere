//
//  AppDelegate.m
//  MeetChewThere
//
//  Created by Clay Jones on 10/30/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import "AppDelegate.h"
#import "MCTDiscoverViewController.h"
#import "MCTCreateEventViewController.h"
#import "MCTProfileEventsViewController.h"
#import "MCTUtils.h"
#import <ChameleonFramework/Chameleon.h>
#import "MCTSelectDateViewController.h"
#import "MCTAddEventDetailsViewController.h"

@interface AppDelegate () <UITabBarControllerDelegate>

@property UITabBarController *controller;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [Chameleon setGlobalThemeUsingPrimaryColor:[MCTUtils defaultBarColor] withContentStyle:UIContentStyleLight];
    
    _controller = [[UITabBarController alloc] init];
    _controller.delegate = self;
    [_controller setViewControllers:[self tabBarControllers] animated:NO];
    
    self.window.rootViewController = _controller;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (NSArray *)tabBarControllers {
    UINavigationController *discoverController = [[UINavigationController alloc] initWithRootViewController:[[MCTDiscoverViewController alloc] init]];
    discoverController.tabBarItem.title = @"Discover";
    discoverController.tabBarItem.image = [UIImage imageNamed:@"discover_tab"];
    
    UINavigationController *createController = [[UINavigationController alloc] initWithRootViewController:[[MCTCreateEventViewController alloc] init]];
    createController.tabBarItem.title = @"New Event";
    createController.tabBarItem.image = [UIImage imageNamed:@"new_event_tab"];
    
    UINavigationController *eventsController = [[UINavigationController alloc] initWithRootViewController:[[MCTProfileEventsViewController alloc] init]];
    eventsController.tabBarItem.title = @"Events";
    eventsController.tabBarItem.image = [UIImage imageNamed:@"my_events_tab"];
    
    NSArray *viewControllers = @[discoverController, createController, eventsController];
    for (UINavigationController *vc in viewControllers) {
        [vc.navigationBar setOpaque:YES];
    }
    return viewControllers;
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    NSArray *viewControllers = ((UINavigationController *) viewController).viewControllers;
    if([[viewControllers objectAtIndex:viewControllers.count - 1] isKindOfClass:[MCTCreateEventViewController class]]) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[MCTAddEventDetailsViewController new]];
        [_controller presentViewController:nav animated:YES completion:nil];
        return NO;
    }
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

@end
