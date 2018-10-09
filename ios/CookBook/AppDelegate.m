//
//  AppDelegate.m
//  CookBook
//
//  Created by zhangxi on 16/4/7.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "AppDelegate.h"
#import "MainPageViewController.h"
#import "GroupPurchaseViewController.h"
#import "CookbookViewController.h"
#import "MineInfoViewController.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "CookDataManager.h"
#import "IQKeyboardManager.h"
#import "InteractiveManager.h"
#import "WXApiManager.h"
#import <JSPatch/JSPatch.h>
#import "NSDate+ZXAdd.h"

#define JSPATCH_APP_KEY @"5509710c63d20a6a"

@interface AppDelegate ()<RDVTabBarControllerDelegate,WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"");
    NSLog(@"");

    [JSPatch startWithAppKey:JSPATCH_APP_KEY];
#ifdef DEBUG
    [JSPatch setupDevelopment];
    
    [JSPatch setupCallback:^(JPCallbackType type, NSDictionary *data, NSError *error) {
        switch (type) {
            case JPCallbackTypeUpdate: {
                NSLog(@"updated %@ %@", data, error);
                break;
            }
            case JPCallbackTypeRunScript: {
                NSLog(@"run script %@ %@", data, error);
                break;
            }
            default:
                break;
        }
    }];

#endif
    
    [JSPatch sync];
    
    [WXApi registerApp:WXAPP_ID];

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
//    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    RDVTabBarController *tabVc = [self configTabbarController];
//    UserManager *manager = [UserManager shareInstance];
    [[InteractiveManager shareInstance] initDelegate];
    
    [GlobalVar shareGlobalVar];

//    [[UserManager shareInstance] refreshToken:YES];
    
    self.window.rootViewController = tabVc;
    [self.window makeKeyAndVisible];
    
    
//    NSMutableArray *arr = [NSMutableArray array];
//    [arr addObject:[UIImage imageNamed:@"add"]];
//    [arr addObject:[UIImage imageNamed:@"close"]];
//
//    [arr addObject:[UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE]];

//    CookPhotoProxy * ss = [[CookPhotoProxy alloc] initWithImages:arr andDelegate:nil];
//    [ss test];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[UserManager shareInstance] saveCurUserInfo];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
//    [[UserManager shareInstance] refreshToken:YES];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    
    [[UserManager shareInstance] saveCurUserInfo];
    [self saveContext];
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if ([[url absoluteString] hasPrefix:@"wx"])
    {
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    else
    {
        return YES;
    }
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([[url absoluteString] hasPrefix:@"wx"])
    {
        BOOL isSuc = [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
        return  isSuc;
    }
    return YES;
}



#pragma mark - RDVTabBarController
//
//-(BOOL)tabBarController:(RDVTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
//{
//    if ([((UINavigationController *)viewController).topViewController isKindOfClass:[MineInfoViewController class]])
//    {
//        if ([UserManager shareInstance].bIsLogin)
//        {
//            return YES;
//        }
//        else
//        {
//            CATransition* transition = [CATransition animation];
//            transition.type = kCATransitionPush;//可更改为其他方式
//            transition.subtype = kCATransitionFromTop;//可更改为其他方式
//            [((UINavigationController *)tabBarController.selectedViewController).view.layer addAnimation:transition forKey:kCATransition];
//
//            LoginViewController *loginVC=[[LoginViewController alloc]init];
//            [((UINavigationController *)tabBarController.selectedViewController) pushViewController:loginVC animated:NO];
//            return NO;
//        }
//    }
//    else
//    {
//        return YES;
//    }
//}


- (RDVTabBarController *)configTabbarController
{
    MainPageViewController *mainPagevVc = [[MainPageViewController alloc] init];
    UINavigationController * firstNavVc = [[UINavigationController alloc] initWithRootViewController:mainPagevVc];
    [firstNavVc setNavigationBarHidden:YES];
    
    GroupPurchaseViewController *groupPurchaseVc = [[GroupPurchaseViewController alloc] init];
    UINavigationController *secondNavVc= [[UINavigationController alloc] initWithRootViewController:groupPurchaseVc];
    [secondNavVc setNavigationBarHidden:YES];
    
    CookbookViewController *cookbookVc = [[CookbookViewController alloc] init];
    UINavigationController *thirdNavVc= [[UINavigationController alloc]initWithRootViewController:cookbookVc];
    [thirdNavVc setNavigationBarHidden:YES];
    
    MineInfoViewController *mineInfoVc = [[MineInfoViewController alloc] init];
    UINavigationController *fourthNavVc= [[UINavigationController alloc]initWithRootViewController:mineInfoVc];
    [fourthNavVc setNavigationBarHidden:YES];
    
    
    RDVTabBarController *tabVc = [[RDVTabBarController alloc] init];
    tabVc.tabBar.backgroundColor=[UIColor clearColor];
    tabVc.delegate=self;
    [tabVc setViewControllers:@[firstNavVc, secondNavVc, thirdNavVc, fourthNavVc]];
    
    RDVTabBar *tabBar = [tabVc tabBar];
//    tabBar.backgroundView.backgroundColor=[UIColor colorWithWhite:1 alpha:0.5];
//    tabBar.backgroundColor=[UIColor colorWithWhite:1 alpha:0.7];
//    tabBar.backgroundView.backgroundColor = [UIColor clearColor];
    
    

    [tabBar setFrame:CGRectMake(CGRectGetMinX(tabBar.frame), CGRectGetMinY(tabBar.frame), CGRectGetWidth(tabBar.frame), 49)];
    
    
//    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
//    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"first", @"second", @"third", @"fourth"];
    NSArray *titles=@[@"首页",@"团购",@"厨房",@"我的"];
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabVc tabBar] items]) {
//        [item setBackgroundSelectedImage:nil withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        [item setTitle:[titles objectAtIndex:index]];
        item.selectedTitleAttributes =@{NSForegroundColorAttributeName:RGBACOLOR(176, 116, 67, 1)};
        index++;
    }
    
    return tabVc;
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.coralhust.CookBook" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CookBook" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CookBook.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
