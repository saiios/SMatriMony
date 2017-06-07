//
//  Invoice_view_Cell.h
//  Smatrimony
//
//  Created by INDOBYTES on 29/05/17.
//  Copyright © 2017 Indobytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Invoice_view_Cell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *invoice_id;
@property (strong, nonatomic) IBOutlet UILabel *customer_id;
@property (strong, nonatomic) IBOutlet UILabel *pay_mode;
@property (strong, nonatomic) IBOutlet UILabel *company_name;
@property (strong, nonatomic) IBOutlet UILabel *com_email;
@property (strong, nonatomic) IBOutlet UILabel *plan_type;
@property (strong, nonatomic) IBOutlet UILabel *p_mobile;
@property (strong, nonatomic) IBOutlet UILabel *p_email;
@property (strong, nonatomic) IBOutlet UILabel *plan_name;
@property (strong, nonatomic) IBOutlet UILabel *activated_on;
@property (strong, nonatomic) IBOutlet UILabel *exp_on;
@property (strong, nonatomic) IBOutlet UILabel *product_amount;
@property (strong, nonatomic) IBOutlet UILabel *service_tax;
@property (strong, nonatomic) IBOutlet UILabel *swatch_bharath;
@property (strong, nonatomic) IBOutlet UILabel *grand_total;

@end
