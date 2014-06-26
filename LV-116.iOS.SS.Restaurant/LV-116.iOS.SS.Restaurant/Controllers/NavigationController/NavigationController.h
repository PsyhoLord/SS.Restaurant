//
//  NavigationController.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 6/21/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

@class DataProvider;

// NavigationController class need for navigation
// also it will contain pointer to an object of DataProvider
@interface NavigationController : UINavigationController

#warning Do you really think Navigation controller should know about DataProvider ? What is responsibility of NavigationController ? Do you need custom NavigationController at all ?
@property (strong, nonatomic) DataProvider *dataProvider;

@end
