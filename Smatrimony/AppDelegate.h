//
//  AppDelegate.h
//  Smatrimony
//
//  Created by INDOBYTES on 02/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "LoginViewController.h"
#import <UserNotifications/UserNotifications.h>
#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
@interface AppDelegate : UIResponder <UIApplicationDelegate,UNUserNotificationCenterDelegate>
{
    NSUserDefaults *user_inf;
}
@property (strong, nonatomic) UIWindow *window;
@property(assign,nonatomic)BOOL shouldRotate;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

