//
//  AppDelegate.m
//  Smatrimony
//
//  Created by INDOBYTES on 02/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuViewController.h"
#import "LoginViewController.h"
#import "Home_VC.h"

#import "Login_Agent.h"
#import "Agent_Dashboard.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    user_inf=[NSUserDefaults standardUserDefaults];
    NSString *matri_id=[user_inf valueForKey:@"matri_id"];
    NSString *F_matri_id=[user_inf valueForKey:@"F_matri_id"];
    
    NSString *Re_Open=[[NSUserDefaults standardUserDefaults]valueForKey:@"Re_Open"];
    
        if ([Re_Open isEqualToString:@"User_Login"])
        {
            LoginViewController *menuController  =[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:menuController];
            self.window.rootViewController = nav;
        }
        else if ([Re_Open isEqualToString:@"User_Dashboard"])
        {
            MenuViewController *menuController  =[[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:menuController];
            self.window.rootViewController = nav;
        }
       else if ([Re_Open isEqualToString:@"Agent_Login"])
        {
            Login_Agent *menuController  =[[Login_Agent alloc]initWithNibName:@"Login_Agent" bundle:nil];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:menuController];
            self.window.rootViewController = nav;
        }
        else if ([Re_Open isEqualToString:@"Agent_Dashboard"])
        {
            Agent_Dashboard *menuController  =[[Agent_Dashboard alloc]initWithNibName:@"Agent_Dashboard" bundle:nil];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:menuController];
            self.window.rootViewController = nav;
        }
        else
        {
            Home_VC *menuController  =[[Home_VC alloc]initWithNibName:@"Home_VC" bundle:nil];
            
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:menuController];
            
            self.window.rootViewController = nav;
        }
    
    [self.window makeKeyAndVisible];


//    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"UserLogin"])
//    {
//        if ([matri_id isEqualToString:@""]||matri_id.length==0)
//        {
//            LoginViewController *menuController  =[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
//            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:menuController];
//            self.window.rootViewController = nav;
//        }
//        else
//        {
//            MenuViewController *menuController  =[[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
//            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:menuController];
//            self.window.rootViewController = nav;
//        }
//    [self.window makeKeyAndVisible];
//    }
//    else
//    {
//        if ([matri_id isEqualToString:@""]||matri_id.length==0)
//        {
//            LoginViewController *menuController  =[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
//            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:menuController];
//            self.window.rootViewController = nav;
//        }
//        else
//        {
//        Home_VC *menuController  =[[Home_VC alloc]initWithNibName:@"Home_VC" bundle:nil];
//        
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:menuController];
//        
//        self.window.rootViewController = nav;
//        }
//        [self.window makeKeyAndVisible];
//        
//    }
    [self registerForRemoteNotifications];

    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
    return YES;
}
- (void)registerForRemoteNotifications {
    
    if(SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10.0")){
        
        
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
            if(!error){
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }
        }];
    }
    else {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        {
            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
            [[UIApplication sharedApplication] registerForRemoteNotifications];
            
            NSLog(@"current notifications : %@", [[UIApplication sharedApplication] currentUserNotificationSettings]);
        }
        else
        {
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
             (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
            
            
        }
    }
}
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // custom stuff we do to register the device with our AWS middleman
    NSLog(@"%@",[deviceToken description]);
    
    NSString *str = [NSString stringWithFormat:@"%@",deviceToken];
    
    NSString *deviceTokenStr = [[[[deviceToken description]
                                  stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                 stringByReplacingOccurrencesOfString: @">" withString: @""]
                                stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    NSLog(@"Device Token: %@", deviceTokenStr);
    
}

- (BOOL)application:(nonnull UIApplication *)application
            openURL:(nonnull NSURL *)url
            options:(nonnull NSDictionary<NSString *, id> *)options
{
    NSString *url_str=[NSString stringWithFormat:@"%@",url];
        return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                              openURL:url
                                                    sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                           annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
}
-(void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void(^)(UIBackgroundFetchResult))completionHandler
{
    // iOS 10 will handle notifications through other methods
    
    if( SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10.0") )
    {
        NSLog( @"iOS version >= 10. Let NotificationCenter handle this one." );
        
        // set a member variable to tell the new delegate that this is background
        return;
    }
    
    NSLog( @"HANDLE PUSH, didReceiveRemoteNotification: %@", userInfo );
    
    // custom code to handle notification content
    
    if( [UIApplication sharedApplication].applicationState == UIApplicationStateInactive )
    {
        NSLog( @"INACTIVE" );
        
        completionHandler( UIBackgroundFetchResultNewData );
        
    }
    else if( [UIApplication sharedApplication].applicationState == UIApplicationStateBackground )
    {
        
        NSLog( @"BACKGROUND" );
        completionHandler( UIBackgroundFetchResultNewData );
        
    }
    else
    {
        NSLog( @"FOREGROUND" );
        completionHandler( UIBackgroundFetchResultNewData );
    }
}



//Called when a notification is delivered to a foreground app.
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    NSLog(@"User Info : %@",notification.request.content.userInfo);
    completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);
    
}

//Called to let your app know which action was selected by the user for a given notification.
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    NSLog(@"User Info : %@",response.notification.request.content.userInfo);
    completionHandler();
    
    
}


//Handle actions

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler {
    //Handle action as well
}

-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    if (self.shouldRotate) {
        return UIInterfaceOrientationMaskAll;
    }else{
        return UIInterfaceOrientationMaskPortrait;
    }
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    NSString *url_str=[NSString stringWithFormat:@"%@",url];
        BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                      openURL:url
                                                            sourceApplication:sourceApplication
                                                                   annotation:annotation
                        ];
        // Add any custom logic here.
        return handled;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
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
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Smatrimony"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
