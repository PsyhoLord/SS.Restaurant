//
//  TotallOrderCell.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Mykola_Salo on 7/8/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "POrderItems.h"

@class OrderModel;
@class MenuItemModel;

@interface OrderTotallCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *totallPrice;

@property (weak, nonatomic) id <POrderItems> delegate;

- (void) drawCellWithModel: (OrderModel*)orderModel;

@end
