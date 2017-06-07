//
//  Photo_cell.m
//  Smatrimony
//
//  Created by INDOBYTES on 26/04/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "Photo_cell.h"

@implementation Photo_cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setFrame:(CGRect)frame {
    frame.origin.y += 5;
    frame.size.height -= 2 * 5;
    
    frame.origin.x +=7;
    frame.size.width -= 14;
    
    [super setFrame:frame];
}

@end
