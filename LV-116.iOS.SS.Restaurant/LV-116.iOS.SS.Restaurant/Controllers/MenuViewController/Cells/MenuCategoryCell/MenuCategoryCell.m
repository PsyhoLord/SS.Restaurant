//
//  CategoryCell.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Kristina on 19.06.14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "MenuCategoryCell.h"
#import "MenuCategoryModel.h"

@implementation MenuCategoryCell

- (void)awakeFromNib
{
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( self ) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"MenuCategoryCell" owner:self options:nil];
        self = [nibArray objectAtIndex:0];
    }
    return self;
}

// this method draws category cell with data menuCategoryModel
// (MenuCategoryModel*)menuCategoryModel - data for category cell
- (void) drawCellWithModel:(MenuCategoryModel*)menuCategoryModel
{
    _categoryName.text = menuCategoryModel.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
