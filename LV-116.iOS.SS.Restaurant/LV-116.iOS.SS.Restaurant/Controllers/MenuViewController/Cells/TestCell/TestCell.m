//
//  TestCell.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 6/26/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "TestCell.h"

@implementation TestCell
@synthesize ItemName;

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
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"TestCell" owner: self options:nil];
        self = [nibArray objectAtIndex:0];
    
    }
    return self;
}
@end
