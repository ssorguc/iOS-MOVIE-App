//
//  AppDelegate.m
//  Popular Movies
//
//  Created by Test on 9/27/17.
//  Copyright © 2017 Test. All rights reserved.
//

#import "AppDelegate.h"
#import <RestKit/RestKit.h>
#import "ObjectMappingInitializer.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //Configure RestKit
    //Initialize AFNetworking HTTPClient
    //Generally you will dispatch all requests through the AFRKHTTPClient class.
    /* AFRKHTTPClient is a web client object configured to talk to a particular web server.
     It is initialized with a base URL and allows you to set configuration that is common to the requests in your application, such as HTTP headers and authentication information. */
    NSURL *baseURL = [NSURL URLWithString:@"https://api.themoviedb.org"];
    AFRKHTTPClient *client = [[AFRKHTTPClient alloc] initWithBaseURL:baseURL];
    //Now that you have a client configured, you can send and process HTTP requests through the client.
    /*When making a request through the client, you supply the resource path on the remote web server that you wish to interact with. Since the most common action in an iOS application is making an asynchronous request to a remote web service, RestKit provides very straight-forward convenience methods for the HTTP verbs: GET, POST, PUT and DELETE. You only need to declare that your class implements the RKRequestDelegate protocol */
    
    //RKObjectManager - Captures the common patterns for communicating with a RESTful web application over HTTP using object mapping
    //Much as RKClient is your gateway to a simpler life with HTTP, RKObjectManager is your gateway to the world of object mapping. 
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    [ObjectMappingInitializer initializeRKObjectManagerMapping:objectManager];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
