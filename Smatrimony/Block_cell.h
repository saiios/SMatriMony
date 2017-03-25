//
//  Block_cell.h
//  Smatrimony
//
//  Created by INDOBYTES on 20/02/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Block_cell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *matri_id;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UILabel *yr_hight;
@property (strong, nonatomic) IBOutlet UILabel *location;
@property (strong, nonatomic) IBOutlet UILabel *cast;
@property (strong, nonatomic) IBOutlet UILabel *ocp;
@property (strong, nonatomic) IBOutlet UIButton *unblock;

@end
