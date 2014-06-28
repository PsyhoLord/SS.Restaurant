//
//  Alert.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 6/28/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "Alert.h"

static NSString *const connectionAlertTitle       = @"No network connection";
static NSString *const connectionAlertMessage     = @"You must be connected to the internet to use this app.";
static NSString *const connectionAlertButtonTitle = @"OK";

@implementation Alert

// This method creates UIAlert and show it
+ (void)showConnectionAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:connectionAlertTitle
                                                    message:connectionAlertMessage
                                                   delegate:nil
                                          cancelButtonTitle:connectionAlertButtonTitle
                                          otherButtonTitles:nil];
    [alert show];
}

@end
