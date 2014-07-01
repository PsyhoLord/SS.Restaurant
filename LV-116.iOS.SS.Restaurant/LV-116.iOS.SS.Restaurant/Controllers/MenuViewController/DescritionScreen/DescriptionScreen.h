//
//  DescriptionScreen.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Kristina on 30.06.14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "MenuItemModel.h"

@interface DescriptionScreen : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *ItemImage;
@property (weak, nonatomic) IBOutlet UILabel *ItemName;
@property (weak, nonatomic) IBOutlet UILabel *ItemWeight;
@property (weak, nonatomic) IBOutlet UILabel *ItemPrice;
@property (weak, nonatomic) IBOutlet UILabel *ItemDescription;

- (void)drawDescriptionWithModel:(MenuItemModel*)menuItemModel;

@end
