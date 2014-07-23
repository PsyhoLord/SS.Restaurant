//
//  Alert.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 6/28/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "Alert.h"
#import "OrderItemCell.h"

static NSString *const kConnectionAlertTitle       = @"No network connection";
static NSString *const kConnectionAlertMessage     = @"You must be connected to the internet to use this app.";
static NSString *const kConnectionAlertButtonTitle = @"OK";

static NSString *const kMethodAlertTitle           = @"Error";
static NSString *const kMethodAlertMessage         = @"Code of error: %ld";

static NSString *const kAuthorizationmethodAlertTitle   = @"Login error";
static NSString *const kAuthorizationmethodAlertMessage = @"Your login or password doesn't correct. Please, try again.";


@implementation Alert

+ (void) showConnectionAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kConnectionAlertTitle
                                                    message:kConnectionAlertMessage
                                                   delegate:nil
                                          cancelButtonTitle:kConnectionAlertButtonTitle
                                          otherButtonTitles:nil];
    [alert show];
}

// This method shows alert error when http method is failed.
+ (void) showHTTPMethodsAlert:(NSError*)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: kMethodAlertTitle
                                                    message: [NSString stringWithFormat: kMethodAlertMessage, (long)error.code]
                                                   delegate: nil
                                          cancelButtonTitle: kConnectionAlertButtonTitle
                                          otherButtonTitles: nil];
    [alert show];
}

// This method shows alert when login and password don't correct.
+ (void) showAuthorizationAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: kAuthorizationmethodAlertTitle
                                                    message: kAuthorizationmethodAlertMessage
                                                   delegate: nil
                                          cancelButtonTitle: kConnectionAlertButtonTitle
                                          otherButtonTitles: nil];
    [alert show];
}

//Shows alert to confirm OrderItem deleting
+ (void) showDeleteOrderItemWarningWithDelegate: (OrderItemCell *) newDelegate
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Are you sure?"
                                                    message: @"Are you want to delete current item?"
                                                   delegate: newDelegate
                                          cancelButtonTitle: @"NO"
                                          otherButtonTitles: @"YES", nil
                          ];
    [alert show];
}

// This method shows alert when order updated sucessfully.
+ (void) showUpdateOrderInfoSuccesfullWhithTitle: (NSString *) title andMessage: (NSString *) message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: title
                                                    message: message
                                                   delegate: nil
                                          cancelButtonTitle: @"OK"
                                          otherButtonTitles: nil
                          ];
    [alert show];

}

@end
