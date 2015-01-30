//
//  QPColorTemperaturePickerAppDelegate.m
//  QPColorTemperaturePicker
//
//  Created by Pei Qing on 1/31/15.
//

#import "QPColorTemperaturePickerAppDelegate.h"
#import "QPColorTemperaturePickerView.h"

@implementation QPColorTemperaturePickerAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Setup root controller as color
  TestColorTemperatureViewController *rootController =
      [[TestColorTemperatureViewController alloc] initWithNibName:nil bundle:nil];

  // Then add it to a nav controller so we can experiment with pushing
  UINavigationController *navController = [[UINavigationController alloc]
      initWithRootViewController:rootController];

  // Add navigation to our window
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  self.window.rootViewController = navController;

  // Show the window
  [self.window makeKeyAndVisible];
  return YES;
}

@end
