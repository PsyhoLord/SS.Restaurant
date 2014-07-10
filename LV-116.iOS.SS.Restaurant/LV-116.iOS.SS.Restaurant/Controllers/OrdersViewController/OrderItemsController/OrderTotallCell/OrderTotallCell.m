//
//  TotallOrderCell.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Mykola_Salo on 7/8/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "OrderTotallCell.h"
#import "OrderModel.h"
#import "OrderItemModel.h"
#import "MenuItemModel.h"

@implementation OrderTotallCell

- (void)awakeFromNib
{
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( self ) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"OrderTotallCell" owner:self options:nil];
        self = [nibArray objectAtIndex:0];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)AddNewOrderItem:(UIButton *)sender {
    
    
}



- (void) drawCellWithModel:(OrderModel*)orderModel
{
    float totalValue=0;
    for (int i=0;i<[orderModel.arrayOfOrderItems count];i++)
    {
    
        OrderItemModel *itemInOrderWithCount;
        
        itemInOrderWithCount=[orderModel.arrayOfOrderItems objectAtIndex:i];
        
        totalValue+=(itemInOrderWithCount.menuItemModel.price)*[itemInOrderWithCount countOfItem];
    }
    
    self.totallPrice.text=[NSString stringWithFormat:@"Totall  %.2f$",totalValue];
     // [[(OrderItemModel *)[orderModel.arrayOfOrderItem objectAtIndex:i] ].menuItemModel ];
}


@end
