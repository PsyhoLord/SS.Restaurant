//
//  Alert.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 6/28/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

// Class Alert needs for show alert box.

@interface Alert : NSObject

// This method creates UIAlert and show it
+ (void)showConnectionAlert;

// This method show alert error when http method is failed. 
+ (void)showHTTPMethodsAlert:(NSError*)error;

@end
