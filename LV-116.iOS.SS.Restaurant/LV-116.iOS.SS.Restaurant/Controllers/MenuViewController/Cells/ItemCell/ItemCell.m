//
//  ItemCell.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Kristina on 19.06.14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "ItemCell.h"

@implementation ItemCell

@synthesize ItemName;
@synthesize Image;
@synthesize ItemPrice;
@synthesize ItemDescription;
@synthesize ItemWeight;
@synthesize InfoButton;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        NSArray *nibItemArray = [[NSBundle mainBundle] loadNibNamed:@"ItemCell" owner:self options:nil];
        //[nibItemArray awakeFromNib: @"itemCell"];
        self = [nibItemArray objectAtIndex:0];
    }
    return self;
}


- (IBAction)touchUpInfoButton:(UIButton *)sender {
}
@end
