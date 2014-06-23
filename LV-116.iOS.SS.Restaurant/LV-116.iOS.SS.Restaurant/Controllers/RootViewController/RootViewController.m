//
//  ViewController.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Alexander on 26.05.14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "RootViewController.h"
#import "NavigationController.h"
#import "DataProvider.h"

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ((NavigationController*)self.navigationController).dataProvider = [[DataProvider alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
