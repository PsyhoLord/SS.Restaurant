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

static NSString *const methodAlertTitle           = @"Error";
static NSString *const methodAlertMessage         = @"Code of error: %d";

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

// This method show alert error when http method is failed.
+ (void)showHTTPMethodsAlert:(NSError*)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: methodAlertTitle
                                                    message: [NSString stringWithFormat: methodAlertMessage, error.code]
                                                   delegate: nil
                                          cancelButtonTitle: connectionAlertButtonTitle
                                          otherButtonTitles: nil];
    [alert show];
}

 - (void) showDeleteOrderItemWarning
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Are you sure?"
                                                    message: @"Are you want to delete current item?"
                                                   delegate: self cancelButtonTitle:@"NO"
                                          otherButtonTitles: @"YES", nil
                          ];
    [alert show];
}
@end
