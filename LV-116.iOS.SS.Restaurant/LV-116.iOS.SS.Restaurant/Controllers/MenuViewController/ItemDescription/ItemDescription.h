//
//  ItemDescription.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Kristina on 02.07.14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProvider.h"
#import "MenuItemModel.h"


@interface ItemDescription : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *itemName;
@property (strong, nonatomic) IBOutlet UILabel *itemWeight;
@property (strong, nonatomic) IBOutlet UILabel *itemPrice;
@property (strong, nonatomic) IBOutlet UILabel *itemDescription;
@property (strong, nonatomic) IBOutlet UIImageView *itemImage;
@property (strong, nonatomic) MenuItemModel *itemModel;

- (void)drawDescriptionWithModel:(MenuItemModel*)menuItemModel;

- (instancetype) initWithModel:(MenuItemModel*)menuItemModel;
@end
