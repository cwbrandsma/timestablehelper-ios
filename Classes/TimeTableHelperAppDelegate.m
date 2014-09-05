//
//  TimeTableHelperAppDelegate.m
//  TimeTableHelper
//
//  Created by Chris Brandsma on 8/7/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "TimeTableHelperAppDelegate.h"
//#import "FlurryAnalytics.h"

@implementation TimeTableHelperAppDelegate

@synthesize window;
@synthesize navController;

void uncaughtExceptionHandler(NSException *exception) {
    NSLog(@"Big Exception: %@", exception.reason);

    @try {
        //[FlurryAnalytics logError:@"Uncaught" message:@"Crash!" exception:exception];
    }
    @catch (NSException *ex2) {
        NSLog(@"Flurry Exception: %@", ex2.reason);
    }
    @finally {
    }
}


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    @try {
        //[FlurryAnalytics startSession:@"RUGDYZZ4W6L7AX1JG5HP"];
    }
    @catch (NSException *exception) {
        NSLog(@"Flurry Failed to load: %@", exception.reason);
    }
    @finally {
    }
    
    
    // Override point for customization after application launch.
	[window addSubview:navController.view];
	
    [window makeKeyAndVisible];
	[window bringSubviewToFront:navController.view];
	
	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
	
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[navController release];
    [window release];
    [super dealloc];
}


@end
