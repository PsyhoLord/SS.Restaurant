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

@interface UIImage (ImageBlur)

- (UIImage *)imageWithGaussianBlur;


@end

@implementation UIImage (ImageBlur)

- (UIImage *)imageWithGaussianBlur {
    float weight[5] = {0.2270270270, 0.1945945946, 0.1216216216, 0.0540540541, 0.0162162162};
    // Blur horizontally
    UIGraphicsBeginImageContext(self.size);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height) blendMode:kCGBlendModePlusLighter alpha:weight[0]];
    for (int x = 1; x < 5; ++x) {
        [self drawInRect:CGRectMake(x, 0, self.size.width, self.size.height) blendMode:kCGBlendModePlusLighter alpha:weight[x]];
        [self drawInRect:CGRectMake(-x, 0, self.size.width, self.size.height) blendMode:kCGBlendModePlusLighter alpha:weight[x]];
    }
    UIImage *horizBlurredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // Blur vertically
    UIGraphicsBeginImageContext(self.size);
    [horizBlurredImage drawInRect:CGRectMake(0, 0, self.size.width, self.size.height) blendMode:kCGBlendModePlusLighter alpha:weight[0]];
    for (int y = 1; y < 5; ++y) {
        [horizBlurredImage drawInRect:CGRectMake(0, y, self.size.width, self.size.height) blendMode:kCGBlendModePlusLighter alpha:weight[y]];
        [horizBlurredImage drawInRect:CGRectMake(0, -y, self.size.width, self.size.height) blendMode:kCGBlendModePlusLighter alpha:weight[y]];
    }
    UIImage *blurredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //
    return blurredImage;
}

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Set IBOtlets.
    
    
    [self setupGestureRecognizerConfiguration];
    
    [SidebarViewController setupSidebarConfigurationForViewController: self
                                                        sidebarButton: self.sidebarButton
                                                            isGesture: NO];
    self.menuItemModel = _items[ _index ];

    
    [self drawDescriptionWithModel];
}

- (void)drawDescriptionWithModel
{
    _itemName.text        = _menuItemModel.name;
    _itemDescription.text = _menuItemModel.description;
    _itemPrice.text       = [NSString stringWithFormat:@"%.2f$", _menuItemModel.price];
    _itemWeight.text      = [NSString stringWithFormat:@"%dg",_menuItemModel.portions];
    
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
    if( _index++ == _items.count-1 ) {
        _index = 0;
    }
    self.menuItemModel =  ((MenuItemModel*)_items[ _index ]);
        
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
