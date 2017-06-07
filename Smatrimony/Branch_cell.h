//
//  Branch_cell.h
//  Smatrimony
//
//  Created by INDOBYTES on 27/04/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Branch_cell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *branch_name;
@property (strong, nonatomic) IBOutlet UITextView *address;
@property (strong, nonatomic) IBOutlet UILabel *phone;
@property (strong, nonatomic) IBOutlet UILabel *email;
@property (strong, nonatomic) IBOutlet UIButton *directions;

@end
