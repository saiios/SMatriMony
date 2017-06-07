//
//  Orders_Cell.h
//  Steeloncall_Seller
//
//  Created by Manoyadav on 15/12/16.
//  Copyright © 2016 sai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Invoice_Cell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *matri_id;
@property (strong, nonatomic) IBOutlet UILabel *email;
@property (strong, nonatomic) IBOutlet UILabel *mode;
@property (strong, nonatomic) IBOutlet UILabel *activated_on;
@property (strong, nonatomic) IBOutlet UILabel *plan_name;
@property (strong, nonatomic) IBOutlet UILabel *expired_on;
@property (strong, nonatomic) IBOutlet UIButton *invoice_view;
@property (strong, nonatomic) IBOutlet UIButton *download;
@property (strong, nonatomic) IBOutlet UILabel *s_no;
@property (strong, nonatomic) IBOutlet UIView *border_view;

@end
