//
//  horoscope_TableViewCell.m
//  Smatrimony
//
//  Created by INDOBYTES on 20/04/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "horoscope_TableViewCell.h"

@implementation horoscope_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _horoscopeBtn.layer.cornerRadius = 10; // this value vary as per your desire
    _horoscopeBtn.clipsToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
