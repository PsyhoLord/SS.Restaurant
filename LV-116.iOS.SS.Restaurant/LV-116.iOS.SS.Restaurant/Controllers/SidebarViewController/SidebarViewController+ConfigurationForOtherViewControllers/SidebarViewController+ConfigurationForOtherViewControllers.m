//
//  SidebarViewController+ConfigurationForOtherViewControllers.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 7/13/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "SidebarViewController+ConfigurationForOtherViewControllers.h"
#import "SWRevealViewController.h"

@implementation SidebarViewController (ConfigurationForOtherViewControllers)

// set sidebare configuration
// (BOOL)addGesture - if YES, go to sidebar by pan gesture
+ (void) setupSidebarConfigurationForViewController: (UIViewController*)viewController
                                      sidebarButton: (UIBarButtonItem*)barButtonItem
                                          isGesture: (BOOL)isGesture
{
    // Change button color
    barButtonItem.tintColor = [UIColor colorWithWhite: 0.1f alpha: 0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    barButtonItem.target = viewController.revealViewController;
    barButtonItem.action = @selector(revealToggle:);
    
    if ( isGesture ) {
        // Set the gesture
        [viewController.view addGestureRecognizer: viewController.revealViewController.panGestureRecognizer];
    }
}

@end
