//
//  UIViewController+BackgroundImage.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 7/24/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "UIViewController+BackgroundImage.h"

static NSString *const kBackgroundImage = @"blurred2.jpg";

@implementation UIViewController (BackgroungImage)

// Sets background image for any view controller.
+ (void)setBackgroundImage:(UIViewController*)viewController
{
    viewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: kBackgroundImage]];
}

@end
