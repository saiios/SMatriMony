//
//  DR_cell.h
//  Smatrimony
//
//  Created by INDOBYTES on 24/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DR_cell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *age;
@property (strong, nonatomic) IBOutlet UIButton *full_profile;
@property (strong, nonatomic) IBOutlet UIButton *skip;
@property (strong, nonatomic) IBOutlet UIButton *yes;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UIButton *img_click;
@property (strong, nonatomic) IBOutlet UILabel *timerLabel;


@end
