//
//  Mail_cell.m
//  Smatrimony
//
//  Created by INDOBYTES on 15/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import "Mail_cell.h"

@implementation Mail_cell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
    self.call_now.layer.cornerRadius = 15;
    self.call_now.clipsToBounds = YES;
    
    self.send_mail.layer.cornerRadius = 15;
    self.send_mail.clipsToBounds =YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
