//
//  ViewController.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Alexander on 26.05.14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

@class SidebarViewController;

// RootViewController class is root storyboard
@interface HomeViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
//@property (weak, nonatomic) SidebarViewController *sidebarViewController;
@end
