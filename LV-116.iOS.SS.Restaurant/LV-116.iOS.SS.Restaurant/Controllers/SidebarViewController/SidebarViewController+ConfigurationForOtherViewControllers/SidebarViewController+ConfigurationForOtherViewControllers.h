//
//  SidebarViewController+ConfigurationForOtherViewControllers.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 7/13/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "SidebarViewController.h"

@interface SidebarViewController (ConfigurationForOtherViewControllers)

// set sidebare configuration for viewController
// barButtonItem - bar button for calling sidebar
// (BOOL)isGesture - if YES, go to sidebar by pan gesture
+ (void) setupSidebarConfigurationForViewController: (UIViewController*)viewController
                                      sidebarButton: (UIBarButtonItem*)barButtonItem
                                          isGesture: (BOOL)isGesture;


@end
