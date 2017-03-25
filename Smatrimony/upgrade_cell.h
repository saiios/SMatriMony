//
//  upgrade_cell.h
//  Smatrimony
//
//  Created by INDOBYTES on 21/03/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface upgrade_cell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *plan_name;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *price_month;
@property (strong, nonatomic) IBOutlet UILabel *chat;
@property (strong, nonatomic) IBOutlet UILabel *horoscope;
@property (strong, nonatomic) IBOutlet UILabel *mobile;
@property (strong, nonatomic) IBOutlet UIButton *make_payment;
@property (strong, nonatomic) IBOutlet UILabel *mesages;
@property (strong, nonatomic) IBOutlet UILabel *priority;

@end
