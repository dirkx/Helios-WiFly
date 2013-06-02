//
//  AppDelegate.h
//  Sonnenbarke
//
//  Created by Dirk-Willem van Gulik on 31/05/2013.
//  Copyright (c) 2013 Dirk-Willem van Gulik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WiFlyDiscoverer.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {    
}

@property (strong, nonatomic) WiFlyDiscoverer * discoverer;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navigationController;

@property (strong, nonatomic) UISplitViewController *splitViewController;

@end
