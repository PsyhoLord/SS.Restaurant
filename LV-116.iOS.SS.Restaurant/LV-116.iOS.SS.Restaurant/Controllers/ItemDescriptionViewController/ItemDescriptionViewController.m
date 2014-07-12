//
//  DescriptionViewController.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 7/12/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "ItemDescriptionViewController.h"
#import "SWRevealViewController.h"

#import "MenuDataProvider.h"
#import "MenuItemModel.h"


@implementation ItemDescriptionViewController
{
    __weak IBOutlet UIImageView *_itemImage;
    __weak IBOutlet UILabel *_itemName;
    __weak IBOutlet UILabel *_itemWeight;
    __weak IBOutlet UILabel *_itemPrice;
    __weak IBOutlet UILabel *_itemDescription;
    
    IBOutlet UISwipeGestureRecognizer *_swipeGestureRecognizer;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Set IBOtlets.
    [self drawDescriptionWithModel: _menuItemModel];
    [self setupGestureRecognizerConfiguration];
    [self setupSidebarConfigurationWithGesture: NO];
}



- (void)drawDescriptionWithModel:(MenuItemModel*)menuItemModel
{
    _itemName.text        = menuItemModel.name;
    _itemDescription.text = menuItemModel.description;
    _itemPrice.text       = [NSString stringWithFormat:@"%.2f$", menuItemModel.price];
    _itemWeight.text      = [NSString stringWithFormat:@"%ldg",menuItemModel.portions];
    
    if ( menuItemModel.image ) {
        _itemImage.image = menuItemModel.image;
    } else {
        
        // Download image if model hasn't.
        [MenuDataProvider loadMenuItemImage: menuItemModel
                                  withBlock: ^(UIImage *itemImage, NSError *error) {
                                      if ( error ) {
                                          // [Alert showConnectionAlert];
                                      } else {
                                          menuItemModel.image = itemImage;
                                          _itemImage.image = itemImage;
                                      }
                                  }
         ];
        
    }
}

// set sidebare configuration
// (BOOL)addGesture - if YES, go to sidebar by pan gesture
- (void) setupSidebarConfigurationWithGesture: (BOOL)addGesture
{
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite: 0.1f alpha: 0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    if ( addGesture ) {
        // Set the gesture
        [self.view addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    }
}

// set gesture
- (void) setupGestureRecognizerConfiguration
{
    [self.view addGestureRecognizer: _swipeGestureRecognizer];
}

- (IBAction) handleSwipeGestureRecognizer: (UISwipeGestureRecognizer *)sender
{
    [self.navigationController popViewControllerAnimated: YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
