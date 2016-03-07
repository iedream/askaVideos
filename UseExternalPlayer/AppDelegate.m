//
//  AppDelegate.m
//  UseExternalPlayer
//
//  Created by Catherine Zhao on 2016-03-04.
//  Copyright © 2016 Catherine. All rights reserved.
//

#import "AppDelegate.h"
#import <DropboxSDK/DropboxSDK.h>
#import "PlistSettingViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    DBSession *dbSession = [[DBSession alloc]initWithAppKey:@"wn0w24k33et1yhg" appSecret:@"yj99i0ktrr5mm9s" root:kDBRootDropbox];
    [dbSession updateAccessToken:@"1ebth9kxfcw2b13c" accessTokenSecret:@"1ouubp3abzjf2lz" forUserId:@"336589692"];
    [DBSession setSharedSession:dbSession];
    [self setUserId];
    [PlistSettingViewController populateLocalDictionary];
    
    return YES;
}

-(void)storeUserId {
    NSString *text = [PlistSettingViewController getPlistName];
    NSString *filename = @"plistName.txt";
    NSString *localDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *localPath = [localDir stringByAppendingPathComponent:filename];
    [text writeToFile:localPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

-(void)setUserId {
    NSString *filename = @"plistName.txt";
    NSString *localDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *localPath = [localDir stringByAppendingPathComponent:filename];
    [PlistSettingViewController setPlistName: [[NSString alloc]initWithContentsOfFile:localPath encoding:NSUTF8StringEncoding error:NULL]];
}

//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//    if ([[DBSession sharedSession] handleOpenURL:url]) {
//        
//        [[NSNotificationCenter defaultCenter]
//         postNotificationName:@"isDropboxLinked"
//         object:[NSNumber numberWithBool:[[DBSession sharedSession] isLinked]]];
//        
//        return YES;
//    }
//    
//    return NO;
//}
//
//-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
//    if ([[DBSession sharedSession] handleOpenURL:url]) {
//        if ([[DBSession sharedSession] isLinked]) {
//            NSLog(@"App linked successfully!");
//            // At this point you can start making API calls
//        }
//        return YES;
//    }
//    // Add whatever other url handling code your app requires here
//    return NO;
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    [self storeUserId];
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self storeUserId];
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
    [self storeUserId];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
