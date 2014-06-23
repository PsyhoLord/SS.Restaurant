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

@property (strong, nonatomic) DataProvider *dataProvider;

@end
