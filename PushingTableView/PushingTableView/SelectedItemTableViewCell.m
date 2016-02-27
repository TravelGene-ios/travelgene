//
//  SelectedItemTableViewCell.m
//  PushingTableView
//
//  Created by 刘智月 on 2/26/16.
//  Copyright (c) 2016 zhiyue. All rights reserved.
//

#import "SelectedItemTableViewCell.h"

@implementation SelectedItemTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
