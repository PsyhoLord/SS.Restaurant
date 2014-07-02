//
//  ItemDescription.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Kristina on 02.07.14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "ItemDescription.h"


@interface ItemDescription ()

@end

@implementation ItemDescription

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
    // Do any additional setup after loading the view from its nib.
    
    _itemName.text = @"LOL";
    
    
    _itemName.text        = _itemModel.name;
    _itemDescription.text = _itemModel.description;
    _itemPrice.text       = [NSString stringWithFormat:@"%.2f$", _itemModel.price];
    _itemWeight.text      = [NSString stringWithFormat:@"%ldg",_itemModel.portions];
    
    if ( _itemModel.image ) {
        
        _itemImage.image = _itemModel.image;
        
    } else {
        
        [DataProvider loadMenuItemImage:_itemModel withBlock:^(UIImage *itemImage, NSError *error) {
            
            if ( error ) {
                //                [Alert showConnectionAlert];
            } else {
                _itemModel.image = itemImage;
                
                _itemImage.image = itemImage;
            }
        }];
        
    }
    [self reloadInputViews];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (instancetype) initWithModel:(MenuItemModel*)menuItemModel
{
    self = [super init];
    if (self){
        _itemName.text        = menuItemModel.name;
        _itemDescription.text = menuItemModel.description;
        _itemPrice.text       = [NSString stringWithFormat:@"%.2f$", menuItemModel.price];
        _itemWeight.text      = [NSString stringWithFormat:@"%ldg",menuItemModel.portions];
        
        if ( menuItemModel.image ) {
            
            _itemImage.image = menuItemModel.image;
            
        } else {
            
            [DataProvider loadMenuItemImage:menuItemModel withBlock:^(UIImage *itemImage, NSError *error) {
                
                if ( error ) {
                    //                [Alert showConnectionAlert];
                } else {
                    menuItemModel.image = itemImage;
                    
                    _itemImage.image = itemImage;
                }
            }];
            
        }
        [self reloadInputViews];

    }
    return  self;
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
        
        [DataProvider loadMenuItemImage:menuItemModel withBlock:^(UIImage *itemImage, NSError *error) {
            
            if ( error ) {
                //                [Alert showConnectionAlert];
            } else {
                menuItemModel.image = itemImage;
                
                _itemImage.image = itemImage;
            }
        }];
        
    }
    [self reloadInputViews];
}

@end
