//
//  Profile_header.h
//  Smatrimony
//
//  Created by INDOBYTES on 16/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Profile_header : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *chatBtn;
@property (strong, nonatomic) IBOutlet UIButton *callBtn;
@property (strong, nonatomic) IBOutlet UIButton *SortListBTn;
@property (weak, nonatomic) IBOutlet UILabel *shortListLabel;
@property (weak, nonatomic) IBOutlet UILabel *callNowLabel;
@property (weak, nonatomic) IBOutlet UILabel *chatNowLabel;

@end
