//
//  DescriptionScreen.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Kristina on 30.06.14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "DescriptionScreen.h"
#import "DataProvider.h"


@interface DescriptionScreen ()

@end

@implementation DescriptionScreen

@synthesize ItemName   = _ItemName;
@synthesize ItemPrice  = _ItemPrice;
@synthesize ItemWeight = _ItemWeight;
@synthesize ItemImage  = _ItemImage;


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
    // Do any additional setup after loading the view.
}

- (void)drawDescriptionWithModel:(MenuItemModel*)menuItemModel
{
    _ItemName.text        = menuItemModel.name;
    _ItemDescription.text = menuItemModel.description;
    _ItemPrice.text       = [NSString stringWithFormat:@"%.2f$", menuItemModel.price];
    _ItemWeight.text      = [NSString stringWithFormat:@"%ldg",menuItemModel.portions];
    
    if ( menuItemModel.image ) {
        
        _ItemImage.image = menuItemModel.image;
        
    } else {
        
        [DataProvider loadMenuItemImage:menuItemModel withBlock:^(UIImage *itemImage, NSError *error) {
            
            if ( error ) {
                //                [Alert showConnectionAlert];
            } else {
                menuItemModel.image = itemImage;
                
                _ItemImage.image = itemImage;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
