//
//  Id_SearchCell.m
//  Smatrimony
//
//  Created by INDOBYTES on 29/04/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "Id_SearchCell.h"

@implementation Id_SearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.submitBtn.layer.cornerRadius = 10;
    self.submitBtn.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
