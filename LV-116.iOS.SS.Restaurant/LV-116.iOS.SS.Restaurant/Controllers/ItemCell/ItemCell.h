//
//  ItemCell.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Kristina on 19.06.14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *ItemName;
@property (weak, nonatomic) IBOutlet UIImageView *Image;
@property (weak, nonatomic) IBOutlet UIView *ItemPrice;
@property (weak, nonatomic) IBOutlet UILabel *ItemDescription;
@property (weak, nonatomic) IBOutlet UILabel *ItemWeight;


@end
