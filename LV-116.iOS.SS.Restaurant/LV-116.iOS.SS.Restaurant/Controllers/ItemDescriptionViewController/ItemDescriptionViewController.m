//
//  DescriptionViewController.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 7/12/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "ItemDescriptionViewController.h"
#import "SWRevealViewController.h"
#import "SidebarViewController+ConfigurationForOtherViewControllers.h"

#import "MenuDataProvider.h"
#import "MenuItemModel.h"


@interface ItemDescriptionViewController () <UIScrollViewDelegate>
@property (strong, nonatomic) MenuItemModel *menuItemModel;
@end


@implementation ItemDescriptionViewController
{
    __weak IBOutlet UIImageView *_itemImage;
    __weak IBOutlet UILabel *_itemName;
    __weak IBOutlet UILabel *_itemWeight;
    __weak IBOutlet UILabel *_itemPrice;
    __weak IBOutlet UILabel *_itemDescription;
    
    IBOutlet UISwipeGestureRecognizer *_swipeGestureSlide;
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
    
    
    [self setupGestureRecognizerConfiguration];
    
    [SidebarViewController setupSidebarConfigurationForViewController: self
                                                        sidebarButton: self.sidebarButton
                                                            isGesture: NO];
    self.menuItemModel = _arrayOfItem[ _index ];
    [self drawDescriptionWithModel];
}

- (void)drawDescriptionWithModel
{
    _itemName.text        = _menuItemModel.name;
    _itemDescription.text = _menuItemModel.description;
    _itemPrice.text       = [NSString stringWithFormat:@"%.2f$", _menuItemModel.price];
    _itemWeight.text      = [NSString stringWithFormat:@"%ldg",_menuItemModel.portions];
    
    if ( _menuItemModel.image ) {
        _itemImage.image = _menuItemModel.image;
    } else {
        
        // Download image if model hasn't.
        [MenuDataProvider loadMenuItemImage: _menuItemModel
                                  withBlock: ^(UIImage *itemImage, NSError *error) {
                                      if ( error ) {
                                          // [Alert showConnectionAlert];
                                      } else {
                                          [self.menuItemModel setImage:itemImage];
                                          _itemImage.image = itemImage;
                                      }
                                  }
         ];
        
    }
}

// Set gesture.
- (void) setupGestureRecognizerConfiguration
{
    [self.view addGestureRecognizer: _swipeGestureRecognizer];
    [self.view addGestureRecognizer: _swipeGestureSlide];
}

// Swipe for slide on next item.
- (IBAction)handleSwipeGestureSlide:(UISwipeGestureRecognizer *)sender
{
    if( _index++ == _arrayOfItem.count-1 ) {
        _index = 0;
    }
    self.menuItemModel =  ((MenuItemModel*)_arrayOfItem[ _index ]);
        
    [self drawDescriptionWithModel];
}

// Swipe for reveal menu.
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
